//
//  UIViewControllerUtils.swift
//  iARVis (iOS)
//
//  Created by Anonymous on 2022/8/1.
//

import Foundation
import SnapKit
import UIKit

extension UIViewController {
    private func _convenientlyAddChildViewController(_ viewController: UIViewController, addConstrains: Bool = false) {
        viewController.willMove(toParent: self)
        addChild(viewController)
        viewController.didMove(toParent: self)
        if addConstrains {
            viewController.view.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
    }

    func addChildViewController(_ viewController: UIViewController, addView: Bool = true, addConstrains: Bool = false) {
        var addConstrains = addConstrains
        if addView {
            view.addSubview(viewController.view)
        } else {
            addConstrains = false
        }
        _convenientlyAddChildViewController(viewController, addConstrains: addConstrains)
    }

    func insertChildViewController(_ viewController: UIViewController, at index: Int, addConstrains: Bool = false) {
        view.insertSubview(viewController.view, at: index)
        _convenientlyAddChildViewController(viewController, addConstrains: addConstrains)
    }

    func safelyRemoveFromParent() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
        didMove(toParent: nil)
    }
}
