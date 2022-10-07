//
//  CGSize+Hashable.swift
//  iARVis (iOS)
//
//  Created by Anonymous on 2022/9/28.
//

import Foundation
import CoreGraphics

extension CGSize: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(width)
        hasher.combine(height)
    }
}
