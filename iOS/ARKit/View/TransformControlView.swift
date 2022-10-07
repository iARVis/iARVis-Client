//
//  TransformControlView.swift
//  iARVis (iOS)
//
//  Created by Anonymous on 2022/9/15.
//

import Combine
import SwiftUI
import UIKit

@available(iOS 16, *)
class TransformControlViewController: UIViewController {
    private var hostingViewController: UIHostingController<AnyView>?
    private var widgetConfiguration: WidgetConfiguration?

    override func viewDidLoad() {
        super.viewDidLoad()

        overrideUserInterfaceStyle = .light
    }

    func update(widgetConfiguration: WidgetConfiguration) {
        if hostingViewController == nil {
            self.widgetConfiguration = widgetConfiguration

            let transformControlViewController = UIHostingController(rootView: AnyView(TransformControlView(widgetConfiguration: widgetConfiguration).id(UUID())), ignoreSafeArea: true)
            transformControlViewController.overrideUserInterfaceStyle = .light
            hostingViewController = transformControlViewController
            addChildViewController(transformControlViewController, addConstrains: true)
            transformControlViewController.view.backgroundColor = .clear
        }

        guard let hostingViewController = hostingViewController else { return }

        if self.widgetConfiguration != widgetConfiguration {
            self.widgetConfiguration = widgetConfiguration
            hostingViewController.rootView = AnyView(TransformControlView(widgetConfiguration: widgetConfiguration).id(UUID()))
        }
    }
}

@available(iOS 16, *)
struct TransformControlView: View {
    @ObservedObject private var widgetConfiguration: WidgetConfiguration

    @State private var subscriptions: Set<AnyCancellable> = []
    @State private var publisher: PassthroughSubject<Void, Never> = .init()

    init(widgetConfiguration: WidgetConfiguration) {
        self.widgetConfiguration = widgetConfiguration
    }

    var body: some View {
        NavigationStack {
            List {
                Section {
                    TransformControlSliderView(label: "X", value: .init(get: {
                        widgetConfiguration.relativePosition.x * 100.0
                    }, set: { newValue in
                        widgetConfiguration.relativePosition.x = newValue / 100.0
                        publisher.send()
                    }))
                }

                Section {
                    TransformControlSliderView(label: "Y", value: .init(get: {
                        widgetConfiguration.relativePosition.y * 100.0
                    }, set: { newValue in
                        widgetConfiguration.relativePosition.y = newValue / 100.0
                        publisher.send()
                    }))
                }

                Section {
                    TransformControlSliderView(label: "Z", value: .init(get: {
                        widgetConfiguration.relativePosition.z * 100.0
                    }, set: { newValue in
                        widgetConfiguration.relativePosition.z = newValue / 100.0
                        publisher.send()
                    }))
                }
            }
            .navigationTitle("Transform")
            .navigationBarTitleDisplayMode(.inline)
            .safeAreaInset(edge: .bottom) {
                Color.clear.frame(height: 8)
            }
        }
        .frame(width: 350, height: 350)
        .cornerRadius(16, style: .continuous)
        .onLoad {
            publisher
                .throttle(for: .milliseconds(16), scheduler: DispatchQueue.main, latest: true)
                .sink {
                    widgetConfiguration.objectWillChange.send()
                }
                .store(in: &subscriptions)
        }
    }
}

private struct TransformControlSliderView: View {
    var label: String
    @Binding var value: Float

    var body: some View {
        HStack {
            Text("\(label)")
            Spacer()
            Text("\(String(format: "%.2f", value))(cm)")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.gray)
            Stepper("", value: $value, step: 0.5)
                .fixedSize()
        }

        Slider(
            value: $value,
            in: -25 ... 25,
            step: 0.01
        ) {} minimumValueLabel: {
            Text("-25")
                .font(.system(size: 14, weight: .medium))
        } maximumValueLabel: {
            Text("25")
                .font(.system(size: 14, weight: .medium))
        }
        .tint(.primary)
    }
}

@available(iOS 16, *)
struct TransformControlView_Previews: PreviewProvider {
    static var previews: some View {
        TransformControlView(widgetConfiguration: WidgetConfiguration(component: .spacer, relativeAnchorPoint: .top, relativePosition: .zero))
            .previewLayout(.sizeThatFits)
    }
}
