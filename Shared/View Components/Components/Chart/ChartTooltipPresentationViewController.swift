//
//  ChartTooltipPresentationViewController.swift
//  iARVis
//
//  Created by Anonymous on 2022/8/16.
//

import Foundation
import SwiftUI
import UIKit

@available(iOS 16, *)
class ChartTooltipPresentationViewController: UIViewController {
    var widgetConfiguration: WidgetConfiguration?
    var component: ViewElementComponent

    init(widgetConfiguration: WidgetConfiguration?, component: ViewElementComponent) {
        self.widgetConfiguration = widgetConfiguration
        self.component = component
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let hvc = UIHostingController(rootView:
            ComponentView(component)
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
                    if let self = self,
                       let widgetConfiguration = self.widgetConfiguration {
                        openURL(url, widgetConfiguration: widgetConfiguration)
                    }
                    return .handled
                })
        )
        addChildViewController(hvc, addConstrains: true)
    }
}
