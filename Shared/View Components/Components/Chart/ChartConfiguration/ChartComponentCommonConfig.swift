//
//  ChartComponentCommonConfig.swift
//  iARVis
//
//  Created by Anonymous on 2022/8/27.
//

import Foundation
import SwiftyJSON

class ChartComponentCommonConfig: Codable, Hashable, ObservableObject {
    var interpolationMethod: ARVisInterpolationMethod?
    var symbol: ARVisSymbol?
    var symbolSize: ARVisSymbolSize?
    var foregroundStyleColor: ARVisColor?
    var foregroundStyleColorMap: [ColorMap]?
    var foregroundStyleField: String?
    var foregroundStyleValue: String?
    var positionByValue: String?
    var cornerRadius: CGFloat?
    var lineStyle: ARVisLineStyle?
    var annotations: [ARVisAnnotation]?
    var conditionalAnnotations: [ARVisConditionalAnnotation]?

    init(interpolationMethod: ARVisInterpolationMethod? = nil, symbol: ARVisSymbol? = nil, symbolSize: ARVisSymbolSize? = nil, foregroundStyleColor: ARVisColor? = nil, foregroundStyleColorMap: [ColorMap]? = nil, foregroundStyleField: String? = nil, foregroundStyleValue: String? = nil, positionByValue: String? = nil, cornerRadius: CGFloat? = nil, lineStyle: ARVisLineStyle? = nil, annotations: [ARVisAnnotation]? = nil, conditionalAnnotations: [ARVisConditionalAnnotation]? = nil) {
        self.interpolationMethod = interpolationMethod
        self.symbol = symbol
        self.symbolSize = symbolSize
        self.foregroundStyleColor = foregroundStyleColor
        self.foregroundStyleColorMap = foregroundStyleColorMap
        self.foregroundStyleField = foregroundStyleField
        self.foregroundStyleValue = foregroundStyleValue
        self.positionByValue = positionByValue
        self.cornerRadius = cornerRadius
        self.lineStyle = lineStyle
        self.annotations = annotations
        self.conditionalAnnotations = conditionalAnnotations
    }

    static func == (lhs: ChartComponentCommonConfig, rhs: ChartComponentCommonConfig) -> Bool {
        lhs.interpolationMethod == rhs.interpolationMethod &&
            lhs.symbol == rhs.symbol &&
            lhs.symbolSize == rhs.symbolSize &&
            lhs.foregroundStyleColor == rhs.foregroundStyleColor &&
            lhs.foregroundStyleColorMap == rhs.foregroundStyleColorMap &&
            lhs.foregroundStyleField == rhs.foregroundStyleField &&
            lhs.foregroundStyleValue == rhs.foregroundStyleValue &&
            lhs.positionByValue == rhs.positionByValue &&
            lhs.cornerRadius == rhs.cornerRadius &&
            lhs.lineStyle == rhs.lineStyle &&
            lhs.annotations == rhs.annotations &&
            lhs.conditionalAnnotations == rhs.conditionalAnnotations
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(interpolationMethod)
        hasher.combine(symbol)
        hasher.combine(symbolSize)
        hasher.combine(foregroundStyleColor)
        hasher.combine(foregroundStyleColorMap)
        hasher.combine(foregroundStyleField)
        hasher.combine(foregroundStyleValue)
        hasher.combine(positionByValue)
        hasher.combine(cornerRadius)
        hasher.combine(lineStyle)
        hasher.combine(annotations)
        hasher.combine(conditionalAnnotations)
    }
}

class ColorMap: Codable, Hashable, ObservableObject {
    var field: String
    var value: JSON
    var color: ARVisColor

    init(field: String, value: JSON, color: ARVisColor) {
        self.field = field
        self.value = value
        self.color = color
    }

    static func == (lhs: ColorMap, rhs: ColorMap) -> Bool {
        return lhs.field == rhs.field && lhs.value == rhs.value && lhs.color == rhs.color
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(field)
        if let int = value.strictInt {
            hasher.combine(int)
        } else if let double = value.strictDouble {
            hasher.combine(double)
        } else if let date = value.date {
            hasher.combine(date)
        } else if let string = value.string {
            hasher.combine(string)
        }
        hasher.combine(color)
    }
}
