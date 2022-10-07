//
//  CGPoint+Operations.swift
//  iARVis
//
//  Created by Anonymous on 2022/8/16.
//

import CoreGraphics

func + (left: CGPoint, right: CGPoint) -> CGPoint {
    CGPoint(x: left.x + right.x, y: left.y + right.y)
}

func - (left: CGPoint, right: CGPoint) -> CGPoint {
    CGPoint(x: left.x - right.x, y: left.y - right.y)
}

func * (left: CGPoint, right: CGPoint) -> CGPoint {
    CGPoint(x: left.x * right.x, y: left.y * right.y)
}

func / (left: CGPoint, scalar: CGFloat) -> CGPoint {
    CGPoint(x: left.x / scalar, y: left.y / scalar)
}
