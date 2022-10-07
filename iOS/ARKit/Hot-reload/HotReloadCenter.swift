//
//  HotReloadCenter.swift
//  iARVis (iOS)
//
//  Created by Anonymous on 2022/9/28.
//

import Combine
import Foundation

class HotReloadCenter {
    private var isChanged: (VisualizationConfiguration) -> Bool
    private var didUpdate: (VisualizationConfiguration) -> Void

    let config: HotReloadConfiguration

    private var timerSubscription: AnyCancellable?
    private var subscriptions: Set<AnyCancellable> = []

    private var isFetching = false
    private let queue = DispatchQueue(label: "HotReloadCenterQueue")

    func setUpTimer(frequency: HotReloadConfiguration.Frequency) -> AnyCancellable {
        Timer.publish(every: frequency.seconds, on: .main, in: .default)
            .autoconnect()
            .receive(on: DispatchQueue.global())
            .sink { [weak self] input in
                guard let self = self else { return }
                self.queue.async { [weak self] in
                    guard let self = self else { return }
                    if self.config.enabled, case let .open(url) = self.config.status, !self.isFetching {
                        self.isFetching = true
                        Task {
                            if let (data, _) = try? await URLSession.shared.data(from: url),
                               let visConfig = try? JSONDecoder().decode(VisualizationConfiguration.self, from: data) {
                                if self.isChanged(visConfig) {
                                    printDebug("Visualization Configuration did change!")
                                    self.queue.async {
                                        self.didUpdate(visConfig)
                                        self.isFetching = false
                                    }
                                } else {
                                    self.queue.async {
                                        self.isFetching = false
                                    }
                                }
                            } else {
                                self.queue.async {
                                    self.isFetching = false
                                }
                            }
                        }
                    }
                }
            }
    }

    init(config: HotReloadConfiguration,
         isChanged: @escaping (VisualizationConfiguration) -> Bool,
         didUpdate: @escaping (VisualizationConfiguration) -> Void) {
        self.config = config
        self.isChanged = isChanged
        self.didUpdate = didUpdate

        config.$detectFrequency.sink { [weak self] newValue in
            guard let self = self else { return }
            self.timerSubscription = self.setUpTimer(frequency: newValue)
        }
        .store(in: &subscriptions)

        timerSubscription = setUpTimer(frequency: config.detectFrequency)
    }
}
