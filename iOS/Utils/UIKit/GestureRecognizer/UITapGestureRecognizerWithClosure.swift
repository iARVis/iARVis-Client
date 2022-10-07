//
//  UITapGestureRecognizerWithClosure.swift
//  iARVis (iOS)
//
//  Created by Anonymous on 2022/9/18.
//

import UIKit

final class UITapGestureRecognizerWithClosure: UITapGestureRecognizer {
    private var action: (UITapGestureRecognizer) -> Void

    init(action: @escaping (UITapGestureRecognizer) -> Void) {
        self.action = action
        super.init(target: nil, action: nil)
        addTarget(self, action: #selector(execute))
    }

    @objc private func execute(sender: UITapGestureRecognizer) {
        action(sender)
    }
}
