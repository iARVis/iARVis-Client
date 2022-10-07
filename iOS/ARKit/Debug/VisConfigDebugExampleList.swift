//
//  VisConfigDebugExampleList.swift
//  iARVis (iOS)
//
//  Created by Anonymous on 2022/9/19.
//

import SwiftUI
import UIKit

class VisConfigDebugExampleListViewController: UIViewController {
    let onSelection: (VisualizationConfiguration) -> Void

    init(onSelection: @escaping (VisualizationConfiguration) -> Void) {
        self.onSelection = onSelection
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let hostingVC = UIHostingController(rootView: VisConfigDebugExampleList(onSelection: { [weak self] config in
            guard let self = self else { return }
            self.onSelection(config)
        }))
        hostingVC.view.backgroundColor = .clear
        addChildViewController(hostingVC, addConstrains: true)
    }
}

private struct VisConfigDebugExampleList: View {
    let onSelection: (VisualizationConfiguration) -> Void

    var body: some View {
        List {
            HStack {
                Text("Example 1")
                Color.primary.opacity(0.001)
            }
            .onTapGesture {
                onSelection(.example1)
            }
            HStack {
                Text("Example 2")
                Color.primary.opacity(0.001)
            }
            .onTapGesture {
                onSelection(.example2)
            }
            HStack {
                Text("Example 3")
                Color.primary.opacity(0.001)
            }
            .onTapGesture {
                onSelection(.example3)
            }
            HStack {
                Text("Example 4")
                Color.primary.opacity(0.001)
            }
            .onTapGesture {
                onSelection(.example4)
            }
            HStack {
                Text("Example 5")
                Color.primary.opacity(0.001)
            }
            .onTapGesture {
                onSelection(.example5)
            }
            HStack {
                Text("Example 6")
                Color.primary.opacity(0.001)
            }
            .onTapGesture {
                onSelection(.example6)
            }
            HStack {
                Text("Switch to 2D mode")
                Color.primary.opacity(0.001)
            }
            .onTapGesture {
                if #available(iOS 16, *) {
                    if let _window = UIApplication.shared.delegate?.window,
                       let window = _window {
                        let rootVC = WidgetDebug2DViewController()
                        window.rootViewController = rootVC
                    }
                }
            }
        }
    }
}

struct VisConfigDebugExampleList_Previews: PreviewProvider {
    static var previews: some View {
        VisConfigDebugExampleList(onSelection: { _ in })
    }
}
