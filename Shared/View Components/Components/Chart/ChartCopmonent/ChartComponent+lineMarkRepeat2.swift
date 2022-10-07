//
//  ChartComponent+lineMarkRepeat2.swift
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
    func lineMarkRepeat2(configuration: ChartConfiguration, commonConfig: ChartComponentCommonConfig, dataItem: ChartDataItem, x: ARVisPlottableValueFieldPair, ySeries: [ARVisPlottableValueFieldPair]) -> some ChartContent {
        let datumArray = dataItem.datumArray
        ForEach(0 ..< ySeries.count, id: \.self) { ySeriesIndex in
            let y: ARVisPlottableValueFieldPair = ySeries[ySeriesIndex]
            ForEach(0 ..< dataItem.length, id: \.self) { index in
                let datum = datumArray[index]
                ChartGroup {
                    if let xJSONValue = datum[x.field],
                       let yJSONValue = datum[y.field] {
                        if let xIntValue = x.plottableInt(xJSONValue) {
                            if let yIntValue = y.plottableInt(yJSONValue) {
                                lineMark(x: xIntValue, y: yIntValue)
                            } else if let yDoubleValue = y.plottableDouble(yJSONValue) {
                                lineMark(x: xIntValue, y: yDoubleValue)
                            } else if let yDateValue = y.plottableDate(yJSONValue) {
                                lineMark(x: xIntValue, y: yDateValue)
                            }
                        } else if let xDoubleValue = x.plottableDouble(xJSONValue) {
                            if let yIntValue = y.plottableInt(yJSONValue) {
                                lineMark(x: xDoubleValue, y: yIntValue)
                            } else if let yDoubleValue = y.plottableDouble(yJSONValue) {
                                lineMark(x: xDoubleValue, y: yDoubleValue)
                            } else if let yDateValue = y.plottableDate(yJSONValue) {
                                lineMark(x: xDoubleValue, y: yDateValue)
                            }
                        } else if let xDateValue = x.plottableDate(xJSONValue) {
                            if let yIntValue = y.plottableInt(yJSONValue) {
                                lineMark(x: xDateValue, y: yIntValue)
                            } else if let yDoubleValue = y.plottableDouble(yJSONValue) {
                                lineMark(x: xDateValue, y: yDoubleValue)
                            } else if let yDateValue = y.plottableDate(yJSONValue) {
                                lineMark(x: xDateValue, y: yDateValue)
                            }
                        } else if let xStringValue = x.plottableString(xJSONValue) {
                            if let yIntValue = y.plottableInt(yJSONValue) {
                                lineMark(x: xStringValue, y: yIntValue)
                            } else if let yDoubleValue = y.plottableDouble(yJSONValue) {
                                lineMark(x: xStringValue, y: yDoubleValue)
                            } else if let yDateValue = y.plottableDate(yJSONValue) {
                                lineMark(x: xStringValue, y: yDateValue)
                            }
                        }
                    }
                }
                .foregroundStyle(by: .value(y.field, y.field))
                .applyCommonConfig(commonConfig: commonConfig, datumDictionary: datum)
            }
        }
    }
}
