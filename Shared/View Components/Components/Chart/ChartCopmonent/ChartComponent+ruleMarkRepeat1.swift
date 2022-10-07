//
//  ChartComponent+ruleMarkRepeat1.swift
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
    @ChartContentBuilder
    @inlinable
    func ruleMarkRepeat1(configuration _: ChartConfiguration, commonConfig: ChartComponentCommonConfig, dataItem: ChartDataItem, x: ARVisPlottableValueFieldPair, yStart: ARVisPlottableValueFieldPair?, yEnd: ARVisPlottableValueFieldPair?) -> some ChartContent {
        let datumArray = dataItem.datumArray
        ForEach(0 ..< dataItem.length, id: \.self) { index in
            let datum = datumArray[index]
            ChartGroup {
                if let xJSONValue = datum[x.field] {
                    // Possible case:
                    // Int, nil; Int, Int; Int, Double; Int, Date;
                    // Double, nil; Double, Int; Double, Double; Double, Date;
                    // Date, nil; Date, Int; Date, Double; Date, Date;
                    // String, nil; String, Int; String, Double; String, Date;
                    if let xIntValue = x.plottableInt(xJSONValue) {
                        if yStart == nil || yEnd == nil {
                            ruleMark(x: xIntValue)
                        } else if let yStart = yStart,
                                  let yEnd = yEnd,
                                  let yStartJSONValue = datum[yStart.field],
                                  let yEndJSONValue = datum[yEnd.field] {
                            if let yStartIntValue = yStart.plottableInt(yStartJSONValue), let yEndIntValue = yEnd.plottableInt(yEndJSONValue) {
                                ruleMark(x: xIntValue, yStart: yStartIntValue, yEnd: yEndIntValue)
                            } else if let yStartDoubleValue = yStart.plottableDouble(yStartJSONValue), let yEndDoubleValue = yEnd.plottableDouble(yEndJSONValue) {
                                ruleMark(x: xIntValue, yStart: yStartDoubleValue, yEnd: yEndDoubleValue)
                            } else if let yStartDateValue = yStart.plottableDate(yStartJSONValue), let yEndDateValue = yEnd.plottableDate(yEndJSONValue) {
                                ruleMark(x: xIntValue, yStart: yStartDateValue, yEnd: yEndDateValue)
                            }
                        }
                    } else if let xDoubleValue = x.plottableDouble(xJSONValue) {
                        if yStart == nil || yEnd == nil {
                            ruleMark(x: xDoubleValue)
                        } else if let yStart = yStart,
                                  let yEnd = yEnd,
                                  let yStartJSONValue = datum[yStart.field],
                                  let yEndJSONValue = datum[yEnd.field] {
                            if let yStartIntValue = yStart.plottableInt(yStartJSONValue), let yEndIntValue = yEnd.plottableInt(yEndJSONValue) {
                                ruleMark(x: xDoubleValue, yStart: yStartIntValue, yEnd: yEndIntValue)
                            } else if let yStartDoubleValue = yStart.plottableDouble(yStartJSONValue), let yEndDoubleValue = yEnd.plottableDouble(yEndJSONValue) {
                                ruleMark(x: xDoubleValue, yStart: yStartDoubleValue, yEnd: yEndDoubleValue)
                            } else if let yStartDateValue = yStart.plottableDate(yStartJSONValue), let yEndDateValue = yEnd.plottableDate(yEndJSONValue) {
                                ruleMark(x: xDoubleValue, yStart: yStartDateValue, yEnd: yEndDateValue)
                            }
                        }
                    } else if let xDateValue = x.plottableDate(xJSONValue) {
                        if yStart == nil || yEnd == nil {
                            ruleMark(x: xDateValue)
                        } else if let yStart = yStart,
                                  let yEnd = yEnd,
                                  let yStartJSONValue = datum[yStart.field],
                                  let yEndJSONValue = datum[yEnd.field] {
                            if let yStartIntValue = yStart.plottableInt(yStartJSONValue), let yEndIntValue = yEnd.plottableInt(yEndJSONValue) {
                                ruleMark(x: xDateValue, yStart: yStartIntValue, yEnd: yEndIntValue)
                            } else if let yStartDoubleValue = yStart.plottableDouble(yStartJSONValue), let yEndDoubleValue = yEnd.plottableDouble(yEndJSONValue) {
                                ruleMark(x: xDateValue, yStart: yStartDoubleValue, yEnd: yEndDoubleValue)
                            } else if let yStartDateValue = yStart.plottableDate(yStartJSONValue), let yEndDateValue = yEnd.plottableDate(yEndJSONValue) {
                                ruleMark(x: xDateValue, yStart: yStartDateValue, yEnd: yEndDateValue)
                            }
                        }
                    } else if let xStringValue = x.plottableString(xJSONValue) {
                        if yStart == nil || yEnd == nil {
                            ruleMark(x: xStringValue)
                        } else if let yStart = yStart,
                                  let yEnd = yEnd,
                                  let yStartJSONValue = datum[yStart.field],
                                  let yEndJSONValue = datum[yEnd.field] {
                            if let yStartIntValue = yStart.plottableInt(yStartJSONValue), let yEndIntValue = yEnd.plottableInt(yEndJSONValue) {
                                ruleMark(x: xStringValue, yStart: yStartIntValue, yEnd: yEndIntValue)
                            } else if let yStartDoubleValue = yStart.plottableDouble(yStartJSONValue), let yEndDoubleValue = yEnd.plottableDouble(yEndJSONValue) {
                                ruleMark(x: xStringValue, yStart: yStartDoubleValue, yEnd: yEndDoubleValue)
                            } else if let yStartDateValue = yStart.plottableDate(yStartJSONValue), let yEndDateValue = yEnd.plottableDate(yEndJSONValue) {
                                ruleMark(x: xStringValue, yStart: yStartDateValue, yEnd: yEndDateValue)
                            }
                        }
                    }
                }
            }
            .applyCommonConfig(commonConfig: commonConfig, datumDictionary: datum)
        }
    }
}
