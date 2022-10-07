//
//  WidgetDebug2DViewController.swift
//  iARVis (iOS)
//
//  Created by Anonymous on 2022/9/19.
//

import SwiftUI
import UIKit

@available(iOS 16, *)
class WidgetDebug2DViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let hostingVC = UIHostingController(rootView: WidgetDebug2DView())
        addChildViewController(hostingVC, addConstrains: true)
    }
}

@available(iOS 16, *)
private struct WidgetDebug2DView: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink(value: ViewElementComponentDestination(viewElementComponent: ViewElementComponent.example1_ArtworkWidget)) {
                    Text("Artwork Widget")
                }
                NavigationLink(value: ViewElementComponentDestination(viewElementComponent: ViewElementComponent.example1_JamesEnsorWidget)) {
                    Text("James Ensor Widget")
                }
                NavigationLink(value: ViewElementComponentDestination(viewElementComponent: ViewElementComponent.example2_MacBookPro)) {
                    Text("MacBook Pro Widget")
                }
                NavigationLink(value: ViewElementComponentDestination(viewElementComponent: ViewElementComponent.example2_AppleSilicon)) {
                    Text("Apple Silicon Widget")
                }
                NavigationLink(value: ViewElementComponentDestination(viewElementComponent: ViewElementComponent.example3_AreaChartMatrix)) {
                    Text("Area Chart Widget")
                }
                NavigationLink(destination: SPLOMView_Previews.previews.navigationBarHidden(true)) {
                    Text("SPLOM Widget")
                }
                HStack {
                    Text("Switch to 3D mode")
                    Color.primary.opacity(0.001)
                }
                .onTapGesture {
                    if let _window = UIApplication.shared.delegate?.window,
                       let window = _window {
                        let rootVC = ARKitViewController()
                        window.rootViewController = rootVC
                    }
                }
            }
            .navigationDestination(for: ViewElementComponentDestination.self) { viewElementComponentDestination in
                ViewElementComponentDestinationView(viewElementComponentDestination: viewElementComponentDestination)
            }
        }
    }
}

private struct ViewElementComponentDestination: Hashable {
    var viewElementComponent: ViewElementComponent

    func hash(into hasher: inout Hasher) {
        hasher.combine(viewElementComponent.prettyJSON)
    }
}

private struct ViewElementComponentDestinationView: View {
    let viewElementComponentDestination: ViewElementComponentDestination

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        let viewElementComponent = viewElementComponentDestination.viewElementComponent
        ComponentView(viewElementComponent)
            .environment(\.openURL, OpenURLAction { url in
                openURL(url, widgetConfiguration: nil)
                return .handled
            })
            .navigationBarHidden(true)
            .overlay(alignment: .topLeading) {
                Color.primary.opacity(0.001)
                    .frame(width: 100, height: 100)
                    .onTapGesture {
                        dismiss()
                    }
            }
    }
}

@available(iOS 16, *)
struct WidgetDebug2DViewController_Previews: PreviewProvider {
    static var previews: some View {
        WidgetDebug2DView()
    }
}
