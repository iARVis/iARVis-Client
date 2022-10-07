//
//  UIHostingController+SafeArea.swift
//  iARVis (iOS)
//
//  Created by Anonymous on 2022/8/2.
//
import SwiftUI

/// https://gist.github.com/b8591340/97a8fb48822ac83e9e1cbbc746b258ef
extension UIHostingController {
    public convenience init(rootView: Content, ignoreSafeArea: Bool = false, disableKeyboardNotification: Bool = false) {
        self.init(rootView: rootView)
        disable(ignoreSafeArea: ignoreSafeArea, disableKeyboardNotification: disableKeyboardNotification)
    }

    func disable(ignoreSafeArea: Bool, disableKeyboardNotification: Bool) {
        guard let viewClass = object_getClass(view) else { return }

        let viewSubclassName = String(cString: class_getName(viewClass)).appending("_IgnoreSafeArea")
        if let viewSubclass = NSClassFromString(viewSubclassName) {
            object_setClass(view, viewSubclass)
        } else {
            guard let viewClassNameUtf8 = (viewSubclassName as NSString).utf8String else { return }
            guard let viewSubclass = objc_allocateClassPair(viewClass, viewClassNameUtf8, 0) else { return }

            if ignoreSafeArea {
                if let method = class_getInstanceMethod(UIView.self, #selector(getter: UIView.safeAreaInsets)) {
                    let safeAreaInsets: @convention(block) (AnyObject) -> UIEdgeInsets = { _ in
                        .zero
                    }
                    class_addMethod(viewSubclass, #selector(getter: UIView.safeAreaInsets), imp_implementationWithBlock(safeAreaInsets), method_getTypeEncoding(method))
                }
            }

            if disableKeyboardNotification {
                if let method2 = class_getInstanceMethod(viewClass, NSSelectorFromString("keyboardWillShowWithNotification:")) {
                    let keyboardWillShow: @convention(block) (AnyObject, AnyObject) -> Void = { _, _ in }
                    class_addMethod(viewSubclass, NSSelectorFromString("keyboardWillShowWithNotification:"), imp_implementationWithBlock(keyboardWillShow), method_getTypeEncoding(method2))
                }
            }

            objc_registerClassPair(viewSubclass)
            object_setClass(view, viewSubclass)
        }
    }
}
