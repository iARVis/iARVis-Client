//
//  DetailedSPLOMViewController.swift
//  iARVis (iOS)
//
//  Created by Anonymous on 2022/9/8.
//

import SwiftUI
import UIKit

class LargePartialViewController: PartialViewController {
    private var childViewController: UIViewController?

    init<V: View>(view: V, addCloseButton: Bool = false, isSwipeEnabled: Bool = true) {
        super.init(direction: .center, viewSize: (.proportion(0.9), .proportion(0.9)), isSwipeEnabled: isSwipeEnabled)
        childViewController = UIHostingController(rootView:
            view
                .overlay(alignment: .topTrailing) {
                    if addCloseButton {
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
                }
        )
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if let childViewController = childViewController {
            addChildViewController(childViewController, addConstrains: true)
        }
    }
}
