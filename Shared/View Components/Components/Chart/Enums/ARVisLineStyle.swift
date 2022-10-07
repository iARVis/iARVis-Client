//
//  ARVisLineStyle.swift
//  iARVis
//
//  Created by Anonymous on 2022/8/26.
//

import Foundation
import SwiftUI

struct ARVisLineStyle: Codable, Hashable {
    var lineWidth: CGFloat = 1
}

extension StrokeStyle {
    init(_ lineStyle: ARVisLineStyle) {
        self = .init(lineWidth: lineStyle.lineWidth)
    }
}
