//
//  ChartComponentHoverType.swift
//  iARVis (iOS)
//
//  Created by Anonymous on 2022/9/2.
//

import Foundation

enum ChartComponentHoverType {
    case rangeX
    case rangeY
    case xy
}

@available(iOS 16, *)
extension ChartComponent {
    var hoverType: ChartComponentHoverType {
        switch self {
        case .barMarkRepeat1:
            return .rangeX
        case .barMarkRepeat2:
            return .rangeX
        case .lineMarkRepeat1:
            return .rangeX
        case .lineMarkRepeat2:
            return .rangeX
        case .rectangleMarkRepeat1:
            return .rangeX
        case .ruleMarkRepeat1:
            return .rangeX
        case .pointMarkRepeat1:
            return .xy
        case .areaMarkRepeat1:
            return .xy
        }
    }
}
