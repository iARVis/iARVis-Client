//
//  ChartComponent+toChartContent.swift
//  iARVis
//
//  Created by Anonymous on 2022/9/2.
//

import Charts
import Foundation
import SwiftUI
import SwiftyJSON

@available(iOS 16, *)
extension ChartComponent {
    @inlinable
    func barMark<X: Plottable, Y: Plottable>(xStart: PlottableValue<X>, xEnd: PlottableValue<X>, y: PlottableValue<Y>, height: CGFloat?) -> some ChartContent {
        BarMark(xStart: xStart, xEnd: xEnd, y: y, height: height != nil ? .fixed(height!) : .automatic)
    }

    @inlinable
    func barMark2<X: Plottable, Y: Plottable>(x: PlottableValue<X>, y: PlottableValue<Y>, height: CGFloat?) -> some ChartContent {
        BarMark(x: x, y: y, height: height != nil ? .fixed(height!) : .automatic)
    }

    @inlinable
    func lineMark<X: Plottable, Y: Plottable>(x: PlottableValue<X>, y: PlottableValue<Y>) -> some ChartContent {
        LineMark(x: x, y: y)
    }

    @inlinable
    func rectangleMark<X: Plottable, Y: Plottable>(xStart: PlottableValue<X>, xEnd: PlottableValue<X>, yStart: PlottableValue<Y>, yEnd: PlottableValue<Y>) -> some ChartContent {
        RectangleMark(xStart: xStart, xEnd: xEnd, yStart: yStart, yEnd: yEnd)
    }

    @inlinable
    func ruleMark<X: Plottable>(x: PlottableValue<X>) -> some ChartContent {
        RuleMark(x: x)
    }

    @inlinable
    func ruleMark<X: Plottable, Y: Plottable>(x: PlottableValue<X>, yStart: PlottableValue<Y>, yEnd: PlottableValue<Y>) -> some ChartContent {
        RuleMark(x: x, yStart: yStart, yEnd: yEnd)
    }

    @inlinable
    func pointMark<X: Plottable, Y: Plottable>(x: PlottableValue<X>, y: PlottableValue<Y>) -> some ChartContent {
        PointMark(x: x, y: y)
    }
   
    @inlinable
    func areaMark<X: Plottable, Y: Plottable>(x: PlottableValue<X>, y: PlottableValue<Y>, stacking: ARVisMarkStackingMethod?) -> some ChartContent {
        AreaMark(x: x, y: y, stacking: .init(stacking))
    }

    @ChartContentBuilder
    func toChartContent(configuration: ChartConfiguration, commonConfig: ChartComponentCommonConfig) -> some ChartContent {
        if let dataItem: ChartDataItem = configuration.chartData.dataItems[dataKey] {
            switch self {
            case let .barMarkRepeat1(_, xStart, xEnd, y, height):
                barMarkRepeat1(configuration: configuration, commonConfig: commonConfig, dataItem: dataItem, xStart: xStart, xEnd: xEnd, y: y, height: height)
            case let .barMarkRepeat2(_, x, y, height):
                barMarkRepeat2(configuration: configuration, commonConfig: commonConfig, dataItem: dataItem, x: x, y: y, height: height)
            case let .lineMarkRepeat1(_, x, y):
                lineMarkRepeat1(configuration: configuration, commonConfig: commonConfig, dataItem: dataItem, x: x, y: y)
            case let .lineMarkRepeat2(_, x, ySeries):
                lineMarkRepeat2(configuration: configuration, commonConfig: commonConfig, dataItem: dataItem, x: x, ySeries: ySeries)
            case let .rectangleMarkRepeat1(_, xStart, xEnd, yStart, yEnd):
                rectangleMarkRepeat1(configuration: configuration, commonConfig: commonConfig, dataItem: dataItem, xStart: xStart, xEnd: xEnd, yStart: yStart, yEnd: yEnd)
            case let .ruleMarkRepeat1(_, x, yStart, yEnd):
                ruleMarkRepeat1(configuration: configuration, commonConfig: commonConfig, dataItem: dataItem, x: x, yStart: yStart, yEnd: yEnd)
            case let .pointMarkRepeat1(_, x, y):
                pointMarkRepeat1(configuration: configuration, commonConfig: commonConfig, dataItem: dataItem, x: x, y: y)
            case let .areaMarkRepeat1(_, x, y, stacking):
                areaMarkRepeat1(configuration: configuration, commonConfig: commonConfig, dataItem: dataItem, x: x, y: y, stacking: stacking)
            }
        }
    }
}

@available(iOS 16, *)
extension ChartContent {
    @ChartContentBuilder
    func applyCommonConfig(commonConfig: ChartComponentCommonConfig, datumDictionary: [String: Any]) -> some ChartContent {
        let foregroundStyleBy: (String, String)? = {
            if let foregroundStyleField = commonConfig.foregroundStyleField {
                if let data = datumDictionary[foregroundStyleField] as? String {
                    return (foregroundStyleField, data)
                } else if let data = datumDictionary[foregroundStyleField] as? Int {
                    return (foregroundStyleField, String(data))
                }
            } else if let foregroundStyleValue = commonConfig.foregroundStyleValue {
                return (foregroundStyleValue, foregroundStyleValue)
            }
            return nil
        }()

        let foregroundStyleColor: Color = {
            if let color = commonConfig.foregroundStyleColor?.toSwiftUIColor() {
                return color
            } else if let colorMap = commonConfig.foregroundStyleColorMap {
                for map in colorMap {
                    if let datumValue = datumDictionary[map.field] {
                        let datumValue = toSwiftType(datumValue)
                        if let datumValueInt = datumValue as? Int,
                           let targetValueInt = map.value.strictInt,
                           datumValueInt == targetValueInt {
                            return map.color.toSwiftUIColor()
                        } else if let datumValueInt = datumValue as? Double,
                                  let targetValueInt = map.value.strictDouble,
                                  datumValueInt == targetValueInt {
                            return map.color.toSwiftUIColor()
                        } else if let datumValueInt = datumValue as? Date,
                                  let targetValueInt = map.value.date,
                                  datumValueInt == targetValueInt {
                            return map.color.toSwiftUIColor()
                        } else if let datumValueInt = datumValue as? String,
                                  let targetValueInt = map.value.string,
                                  datumValueInt == targetValueInt {
                            return map.color.toSwiftUIColor()
                        }
                    }
                }
            }

            return .blue
        }()

        let result: AnyChartContent = {
            switch foregroundStyleBy {
            case .none:
                return AnyChartContent(self)
            case let .some(foregroundStyleBy):
                let (foregroundStyleLabel, foregroundStyleValue) = foregroundStyleBy
                return AnyChartContent(self.foregroundStyle(by: .value(foregroundStyleLabel, foregroundStyleValue)))
            }
        }()

        result
            .foregroundStyle(foregroundStyleColor)
            .cornerRadius(commonConfig.cornerRadius ?? 2)
    }
}
