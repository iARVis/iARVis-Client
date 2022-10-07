//
//  SettingView.swift
//  iARVis (iOS)
//
//  Created by Anonymous on 2022/9/28.
//

import SwiftUI

class SettingViewController: UIViewController {
    var hotReloadConfiguration: HotReloadConfiguration

    init(hotReloadConfiguration: HotReloadConfiguration) {
        self.hotReloadConfiguration = hotReloadConfiguration
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        overrideUserInterfaceStyle = .light

        var _viewController: UIViewController?
        let hostingVC = UIHostingController(rootView: SettingView(hotReloadConfiguration: hotReloadConfiguration, doneAction: {
            _viewController?.dismiss(animated: true)
        }))
        _viewController = hostingVC
        hostingVC.view.backgroundColor = .clear
        addChildViewController(hostingVC, addConstrains: true)
    }
}

struct SettingView: View {
    init(hotReloadConfiguration: HotReloadConfiguration, doneAction: @escaping () -> Void) {
        self.hotReloadConfiguration = hotReloadConfiguration
        self.doneAction = doneAction

        if case let .open(url) = hotReloadConfiguration.status {
            _hotReloadURLString = .init(wrappedValue: url.absoluteString)
        }
    }

    @ObservedObject var hotReloadConfiguration: HotReloadConfiguration
    var doneAction: () -> Void
    @State private var hotReloadURLString: String?

    var body: some View {
        if #available(iOS 16, *) {
            NavigationStack {
                List {
                    Section("Hot-reload") {
                        Toggle("Enable Hot Reload", isOn: $hotReloadConfiguration.enabled)
                        Picker("Frequency", selection: $hotReloadConfiguration.detectFrequency) {
                            ForEach(HotReloadConfiguration.Frequency.allCases) { frequency in
                                Text(frequency.rawValue.capitalized).tag(frequency)
                            }
                        }
                        HStack {
                            TextField("URL", text: $hotReloadURLString)
                                .foregroundColor(.black.opacity(0.8))
                                .onChange(of: hotReloadURLString) { input in
                                    if let $hotReloadURLString = hotReloadURLString, let url = URL(string: $hotReloadURLString) {
                                        hotReloadConfiguration.status = .open(url: url)
                                    } else {
                                        hotReloadConfiguration.status = .off
                                    }
                                }
                            Spacer(minLength: 6)
                            let isURLCorrect = !(hotReloadConfiguration.status == .off)
                            Image(systemName: isURLCorrect ? "checkmark.diamond.fill" : "xmark.diamond.fill")
                                .foregroundColor(isURLCorrect ? .green : .gray)
                        }
                    }

                    Section {
                        Button("Done") {
                            doneAction()
                        }
                    }
                }
                .navigationTitle("Setting")
            }
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView(hotReloadConfiguration: .init(), doneAction: {})
    }
}
