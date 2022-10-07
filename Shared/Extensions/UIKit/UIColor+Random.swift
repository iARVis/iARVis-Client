//
//  UIColor+Random.swift
//  iARVis
//
//  Created by Anonymous on 2022/9/26.
//

#if canImport(UIKit)
    import UIKit
    extension UIColor {
        static var random: UIColor {
            return UIColor(
                red: .random(in: 0 ... 1),
                green: .random(in: 0 ... 1),
                blue: .random(in: 0 ... 1),
                alpha: 1.0
            )
        }
    }
#endif
