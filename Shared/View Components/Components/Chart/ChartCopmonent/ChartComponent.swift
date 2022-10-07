//
//  ChartComponent.swift
//  iARVis
//
//  Created by Anonymous on 2022/8/14.
//

import Charts
import Foundation
import SwiftUI
import SwiftyJSON

@available(iOS 16, *)
enum ChartComponent: Hashable {
    case barMarkRepeat1(dataKey: String, xStart: ARVisPlottableValueFieldPair, xEnd: ARVisPlottableValueFieldPair, y: ARVisPlottableValueFieldPair, height: CGFloat?)
    case barMarkRepeat2(dataKey: String, x: ARVisPlottableValueFieldPair, y: ARVisPlottableValueFieldPair, height: CGFloat?)
    case lineMarkRepeat1(dataKey: String, x: ARVisPlottableValueFieldPair, y: ARVisPlottableValueFieldPair)
    case lineMarkRepeat2(dataKey: String, x: ARVisPlottableValueFieldPair, ySeries: [ARVisPlottableValueFieldPair])
    case rectangleMarkRepeat1(dataKey: String, xStart: ARVisPlottableValueFieldPair, xEnd: ARVisPlottableValueFieldPair, yStart: ARVisPlottableValueFieldPair, yEnd: ARVisPlottableValueFieldPair)
    case ruleMarkRepeat1(dataKey: String, x: ARVisPlottableValueFieldPair, yStart: ARVisPlottableValueFieldPair? = nil, yEnd: ARVisPlottableValueFieldPair? = nil)
    case pointMarkRepeat1(dataKey: String, x: ARVisPlottableValueFieldPair, y: ARVisPlottableValueFieldPair)
    case areaMarkRepeat1(dataKey: String, x: ARVisPlottableValueFieldPair, y: ARVisPlottableValueFieldPair, stacking: ARVisMarkStackingMethod? = nil)

    var dataKey: String {
        switch self {
        case let .barMarkRepeat1(dataKey, _, _, _, _):
            return dataKey
        case let .barMarkRepeat2(dataKey, _, _, _):
            return dataKey
        case let .lineMarkRepeat1(dataKey, _, _):
            return dataKey
        case let .lineMarkRepeat2(dataKey, _, _):
            return dataKey
        case let .rectangleMarkRepeat1(dataKey, _, _, _, _):
            return dataKey
        case let .ruleMarkRepeat1(dataKey, _, _, _):
            return dataKey
        case let .pointMarkRepeat1(dataKey, _, _):
            return dataKey
        case let .areaMarkRepeat1(dataKey, _, _, _):
            return dataKey
        }
    }
}

@available(iOS 16, *)
extension ChartComponent {
    var typeDescription: String {
        switch self {
        case .barMarkRepeat1:
            return "BarMark"
        case .barMarkRepeat2:
            return "BarMark"
        case .lineMarkRepeat1:
            return "LineMark"
        case .lineMarkRepeat2:
            return "LineMark"
        case .rectangleMarkRepeat1:
            return "RectangleMark"
        case .ruleMarkRepeat1:
            return "RectangleMark"
        case .pointMarkRepeat1:
            return "PointMark"
        case .areaMarkRepeat1:
            return "AreaMark"
        }
    }
}

enum ChartComponentType: String, RawRepresentable {
    case barMark = "BarMark"
    case lineMark = "LineMark"
    case rectangleMark = "RectangleMark"
    case ruleMark = "RuleMark"
    case pointMark = "PointMark"
    case areaMark = "AreaMark"
}
