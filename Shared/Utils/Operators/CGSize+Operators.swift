//
//  CGSize+Operators.swift
//  iARVis (iOS)
//
//  Created by Anonymous on 2022/8/1.
//

import Foundation
import CoreGraphics

func * (size: CGSize, scalar: CGFloat) -> CGSize {
    return CGSize(width: size.width * scalar, height: size.height * scalar)
}

func + (left: CGSize, right: CGSize) -> CGSize {
    return CGSize(width: left.width + right.width, height: left.height + right.height)
}
