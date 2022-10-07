//
//  HotReloadConfiguration.swift
//  iARVis (iOS)
//
//  Created by Anonymous on 2022/9/28.
//

import Foundation

class HotReloadConfiguration: ObservableObject {
    enum Status: Equatable {
        case off
        case open(url: URL)
    }

    enum Frequency: String, RawRepresentable, CaseIterable, Identifiable {
        var id: Self { self }

        case seconds_5 = "5 seconds"
        case seconds_10 = "10 seconds"
        case seconds_15 = "15 seconds"
        case seconds_30 = "30 seconds"
        case seconds_45 = "45 seconds"
        case minute_1 = "1 minute"

        var seconds: TimeInterval {
            switch self {
            case .seconds_5:
                return 5
            case .seconds_10:
                return 10
            case .seconds_15:
                return 15
            case .seconds_30:
                return 30
            case .seconds_45:
                return 45
            case .minute_1:
                return 60
            }
        }
    }

    @Published var detectFrequency: Frequency = .seconds_15
    @Published var enabled: Bool = false
    @Published var status: Status = .off
}
