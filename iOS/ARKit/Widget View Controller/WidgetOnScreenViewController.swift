//
//  WidgetOnScreenViewController.swift
//  iARVis (iOS)
//
//  Created by Anonymous on 2022/8/23.
//

import SwiftUI
import UIKit

class WidgetOnScreenViewController: PartialViewController {
    var widgetConfiguration: WidgetConfiguration

    init(widgetConfiguration: WidgetConfiguration) {
        self.widgetConfiguration = widgetConfiguration
        super.init(direction: .center, viewSize: (.proportion(0.9), .proportion(0.9)))
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        view.backgroundColor = .white

        let widgetView = ComponentView(widgetConfiguration.component)
            .overlay(alignment: .topTrailing) {
                Button { [weak self] in
                    if let self = self {
                        self.dismiss(animated: true)
                    }
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 15))
                        .foregroundColor(.gray)
                        .padding(.all, 8)
                        .background(
                            Circle()
                                .stroke(Asset.DynamicColors.dynamicWhite.swiftUIColor, lineWidth: 1)
                                .background(Asset.DynamicColors.dynamicWhite.swiftUIColor)
                        )
                        .clipShape(Circle())
                        .shadow(color: .primary.opacity(0.1), radius: 5)
                        .offset(x: -16, y: 16)
                }
            }
            .environment(\.openURL, OpenURLAction { [weak self] url in
                if let self = self {
                    let widgetConfiguration = self.widgetConfiguration
                    openURL(url, widgetConfiguration: widgetConfiguration)
                }
                return .handled
            })

        let hostingViewController = UIHostingController(rootView: widgetView)
        hostingViewController.view.backgroundColor = .white
        addChildViewController(hostingViewController)
        hostingViewController.view.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
    }
}
