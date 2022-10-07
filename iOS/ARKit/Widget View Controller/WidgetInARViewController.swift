//
//  WidgetInARViewController.swift
//  iARVis (iOS)
//
//  Created by Anonymous on 2022/8/1.
//

import ARKit
import Foundation
import SnapKit
import SwiftUI
import SwiftyJSON
import UIKit

private class WidgetInARContainerView: UIView {
    weak var viewController: WidgetInARViewController?

    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if let arKitVC = UIApplication.shared.topController() as? ARKitViewController {
            if let node = viewController?.node {
                let arSCNView = arKitVC.sceneView

                let (min, max) = node.boundingBox

                let bottomLeft = SCNVector3(min.x, min.y, 0)
                let topRight = SCNVector3(max.x, max.y, 0)
                let topLeft = SCNVector3(min.x, max.y, 0)

                let worldBottomLeft = node.convertPosition(bottomLeft, to: nil)
                let worldTopRight = node.convertPosition(topRight, to: nil)
                let worldTopLeft = node.convertPosition(topLeft, to: nil)

                let vecHorizontal = (worldTopRight - worldTopLeft).normalized
                let vecVertical = (worldBottomLeft - worldTopLeft).normalized

                if let plane = node.geometry as? SCNPlane {
                    let scale = plane.width / frame.width
                    let pointIn3D = worldTopLeft + scale * point.x * vecHorizontal + scale * point.y * vecVertical
                    let projected = arSCNView.projectPoint(pointIn3D)
                    let projectedPoint = CGPoint(x: CGFloat(projected.x), y: CGFloat(projected.y))

                    printDebug(projectedPoint.debugDescription)

                    if let hitView = arSCNView.hitTest(projectedPoint, with: event) {
                        let result = hitView is ARSCNView
                        if result {
                            viewController?.focusNode()
                        }
                        printDebug("1: \(result)")
                        return result
                    }
                }
            }

            let result = super.point(inside: point, with: event)
            if result {
                viewController?.focusNode()
            }
            printDebug("2: \(result)")
            return result
        }

        printDebug("3: false")
        return false
    }
}

class WidgetInARViewController: UIViewController {
    let nodeFocusCallback: (SCNWidgetNode) -> Void
    let chartConfigurationFocusCallback: (ChartConfiguration) -> Void

    init(node: SCNWidgetNode, nodeFocusCallback: @escaping (SCNWidgetNode) -> Void, chartConfigurationFocusCallback: @escaping (ChartConfiguration) -> Void) {
        self.node = node
        self.nodeFocusCallback = nodeFocusCallback
        self.chartConfigurationFocusCallback = chartConfigurationFocusCallback
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // TODO: Change the frame with plane's size using a fixed DPI.
    private var squareWidth: CGFloat {
        max(widgetConfiguration.size.width, widgetConfiguration.size.height)
    }

    var node: SCNWidgetNode
    var widgetConfiguration: WidgetConfiguration {
        node.widgetConfiguration
    }

    func focusNode() {
        nodeFocusCallback(node)
    }

    func focus(chartConfiguration: ChartConfiguration) {
        chartConfigurationFocusCallback(chartConfiguration)
    }

    override func loadView() {
        view = {
            let view = WidgetInARContainerView()
            view.viewController = self
            return view
        }()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        // Tap gesture's location will be messed up if view is not square-sized when using SwiftUI
        view.frame = CGRect(x: 0, y: 0, width: squareWidth, height: squareWidth)
        view.isOpaque = false
        view.backgroundColor = .clear

        let widgetView = ComponentView(widgetConfiguration.component, isScrollEnabled: widgetConfiguration.isScrollEnabled, padding: widgetConfiguration.padding)
            .overlay(alignment: .topTrailing) {
                if widgetConfiguration.showExpandButton {
                    Button { [weak self] in
                        if let self = self {
                            UIApplication.shared.presentOnTop(WidgetOnScreenViewController(widgetConfiguration: self.widgetConfiguration))
                        }
                    } label: {
                        Image(systemName: "arrow.up.left.and.arrow.down.right")
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
            }
            .environment(\.openURL, OpenURLAction { [weak self] url in
                if let self = self {
                    let widgetConfiguration = self.widgetConfiguration
                    openURL(url, widgetConfiguration: widgetConfiguration)
                }
                return .handled
            })
            .environmentObject(widgetConfiguration)
            .environment(\.chartFocusAction, ChartFocusAction { [weak self] chartConfiguration in
                if let self = self {
                    self.focus(chartConfiguration: chartConfiguration)
                }
            })

        let hostingViewController = UIHostingController(rootView: widgetView, ignoreSafeArea: true)
        hostingViewController.view.backgroundColor = widgetConfiguration.isOpaque ? .white : .clear
        addChildViewController(hostingViewController)
        hostingViewController.view.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.size.equalTo(widgetConfiguration.size)
        }
    }
}

@MainActor
func openURL(_ url: URL, widgetConfiguration: WidgetConfiguration? = nil) {
    let processWidget = { (widgetConfiguration: WidgetConfiguration, key: String, component: ViewElementComponent, anchor: WidgetAnchorPoint, position: SCNVector3, size: CGSize?, isScrollEnabled: Bool) in
        let newWidgetConfiguration = WidgetConfiguration(
            component: component,
            relativeAnchorPoint: anchor,
            relativePosition: position,
            isScrollEnabled: isScrollEnabled,
            size: size ?? SizeDefaultValueProvider.default
        )

        let isPresentationMode: Bool = {
            if let topController = UIApplication.shared.topController(),
               topController.presentingViewController != nil,
               topController is WidgetOnScreenViewController {
                return true
            }
            return false
        }()
        let isDisplayingInAR = widgetConfiguration.additionalWidgetConfiguration[key] != nil
        let isPresentingOnScreen = {
            if let topController = UIApplication.shared.topController(),
               topController.isBeingPresented,
               let topWidgetVC = topController as? WidgetOnScreenViewController,
               topWidgetVC.widgetConfiguration.component == component {
                return true
            }
            return false
        }()
        let canOpenInAR = !isPresentationMode && !isDisplayingInAR
        let canPresent: Bool = !isPresentingOnScreen && !isDisplayingInAR
        let openInAR = {
            widgetConfiguration.additionalWidgetConfiguration[key] = .init(key: key,
                                                                           widgetConfiguration: newWidgetConfiguration)
        }
        let presentOnScreen = {
            UIApplication.shared.presentOnTop(WidgetOnScreenViewController(widgetConfiguration: newWidgetConfiguration))
        }
        if canOpenInAR, canPresent {
            let alertController = UIAlertController(title: "Open", message: "Would you like to open the widget in AR, or display it on the screen?", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Open in AR", style: .default, handler: { action in
                openInAR()
            }))
            alertController.addAction(UIAlertAction(title: "Display on screen", style: .default, handler: { action in
                presentOnScreen()
            }))
            UIApplication.shared.presentOnTop(alertController, animated: true)
        } else if canOpenInAR {
            openInAR()
        } else if canPresent {
            presentOnScreen()
        }
    }

    if url.absoluteString.lowercased().hasPrefix(URLService.scheme.lowercased()) {
        if let service = url.urlService {
            switch service {
            case .link:
                UIApplication.shared.open(url)
            case let .openComponent(config, anchor, position, size, isScrollEnabled):
                if let widgetConfiguration = widgetConfiguration {
                    Task {
                        switch config {
                        case let .url(url):
                            if let configURL = url.url,
                               let (data, _) = try? await URLSession.shared.data(from: configURL),
                               let component = try? JSONDecoder().decode(ViewElementComponent.self, from: data) {
                                processWidget(widgetConfiguration, configURL.absoluteString, component, anchor, position, size, isScrollEnabled)
                            }
                        case let .json(json):
                            if let data = json.data(using: .utf8) {
                                let component = try! JSONDecoder().decode(ViewElementComponent.self, from: data)
                                processWidget(widgetConfiguration, json, component, anchor, position, size, isScrollEnabled)
                            }
                        }
                    }
                }
            case .openVisConfig:
                break
            }
        }
    } else {
        if let url = URLService.link(href: url.absoluteString).url.url {
            UIApplication.shared.open(url)
        }
    }
}

struct ChartFocusAction {
    let focus: (ChartConfiguration) -> Void
}

struct ChartFocusActionEnvironmentKey: EnvironmentKey {
    static let defaultValue = ChartFocusAction(focus: { _ in })
}

extension EnvironmentValues {
    var chartFocusAction: ChartFocusAction {
        get { self[ChartFocusActionEnvironmentKey.self] }
        set { self[ChartFocusActionEnvironmentKey.self] = newValue }
    }
}
