//
//  AppDelegate.swift
//  iARVis (iOS)
//
//  Created by Anonymous on 2022/7/28.
//

import SafariServices
import SwiftUI
import SwiftyJSON
import UIKit

class MyApplication: UIApplication {
    override func open(_ url: URL, options: [UIApplication.OpenExternalURLOptionsKey: Any] = [:], completionHandler completion: ((Bool) -> Void)? = nil) {
        if let components = URLComponents(url: url, resolvingAgainstBaseURL: true),
           components.scheme?.lowercased() == URLService.scheme.lowercased() {
            if let urlService = url.urlService {
                switch urlService {
                case let .link(href: href):
                    if let url = URL(string: href) {
                        let safariViewController = WebViewController(url: url)
                        presentOnTop(safariViewController)
                    }
                case .openComponent:
                    break
                case let .openVisConfig(config):
                    if let arkitViewController = delegate?.window??.rootViewController as? ARKitViewController {
                        switch config {
                        case let .url(url):
                            break
                        case let .json(json):
                            if let visualizationConfiguration = JSON(parseJSON: json).decode(VisualizationConfiguration.self) {
                                arkitViewController.setVisualizationConfiguration(visualizationConfiguration)
                            }
                        }
                    }
                }
            }
        } else {
            if !["http", "https"].contains(URLComponents(url: url, resolvingAgainstBaseURL: true)?.scheme?.lowercased()) {
                super.open(url, options: options, completionHandler: completion)
            } else {
                // As a normal link
                if let url = URLService.link(href: url.absoluteString).url.url {
                    open(url, options: options, completionHandler: completion)
                }
            }
        }
    }
}

extension MyApplication: UIViewControllerTransitioningDelegate {}

class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)

        #if !targetEnvironment(simulator)
            let rootVC = ARKitViewController()
            window.rootViewController = rootVC
        #else
            if #available(iOS 16, *) {
                let rootVC = UIHostingController(rootView:
                    ComponentView(.example4_ShanghaiWeatherPointChartJSONStrViewElementComponent)
                        .environment(\.openURL, OpenURLAction { url in
                            openURL(url, widgetConfiguration: nil)
                            return .handled
                        })
                )
                window.rootViewController = rootVC
            }
        #endif
        window.makeKeyAndVisible()

        self.window = window
        return true
    }

    func application(_: UIApplication, open url: URL, options _: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        UIApplication.shared.open(url)
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        if let arkitViewController = UIApplication.shared.topController() as? ARKitViewController {
            if let string = UIPasteboard.general.string, let url = URL(string: string) {
                if url.absoluteString.lowercased().hasPrefix(URLService.scheme.lowercased()) {
                    if let service = url.urlService {
                        switch service {
                        case let .openVisConfig(config):
                            switch config {
                            case .url:
                                break
                            case let .json(json):
                                if let visConfig = JSON(parseJSON: json).decode(VisualizationConfiguration.self) {
                                    if visConfig != arkitViewController.visContext.visConfiguration {
                                        DispatchQueue.main.async {
                                            let alertController = UIAlertController(title: "Open", message: "Found a visualization configuration from your pasteboard, would you like to apply it?", preferredStyle: .alert)
                                            alertController.addAction(UIAlertAction(title: "Apply", style: .destructive, handler: { action in
                                                arkitViewController.setVisualizationConfiguration(visConfig)
                                            }))
                                            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in }))
                                            UIApplication.shared.presentOnTop(alertController, animated: true)
                                        }
                                    }
                                }
                            }
                        default:
                            break
                        }
                    }
                }
            }
        }
    }
}

extension UIApplication {
    func topController() -> UIViewController? {
        let keyWindow = sceneWindows.filter { $0.isKeyWindow }.first

        if var topController = keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }
        return nil
    }

    var sceneWindows: [UIWindow] {
        UIApplication.shared.connectedScenes
            .first(where: { $0 is UIWindowScene })
            .flatMap { $0 as? UIWindowScene }?.windows ?? []
    }

    func presentOnTop(_ viewController: UIViewController, animated: Bool = true) {
        topController()?.present(viewController, animated: animated)
    }

    func presentOnTop(_ viewController: UIViewController, detents: [UISheetPresentationController.Detent], animated: Bool = true) {
        viewController.modalPresentationStyle = .pageSheet
        if let sheet = viewController.sheetPresentationController {
            sheet.detents = detents
        }

        topController()?.present(viewController, animated: animated)
    }
}
