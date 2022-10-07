//
//  ChartComponent+barMarkRepeat2.swift
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
    func barMarkRepeat2(configuration _: ChartConfiguration, commonConfig: ChartComponentCommonConfig, dataItem: ChartDataItem, x: ARVisPlottableValueFieldPair, y: ARVisPlottableValueFieldPair, height: CGFloat?) -> some ChartContent {
        let datumArray = dataItem.datumArray
        ForEach(0 ..< dataItem.length, id: \.self) { index in
            let datum = datumArray[index]
            ChartGroup {
                if let xJSONValue = datum[x.field],
                   let yJSONValue = datum[y.field] {
                    // Possible case:
                    // Int, String; Int, Int; Int, Double; Int, Date;
                    // Double, String; Double, Int; Double, Double; Double, Date;
                    // Date, String; Date, Int; Date, Double; Date, Date;
                    // String, String; String, Int; String, Double; String, Date;
                    if let xIntValue = x.plottableInt(xJSONValue) {
                        if let yIntValue = y.plottableInt(yJSONValue) {
                            barMark2(x: xIntValue, y: yIntValue, height: height)
                        } else if let yDoubleValue = y.plottableDouble(yJSONValue) {
                            barMark2(x: xIntValue, y: yDoubleValue, height: height)
                        } else if let yDateValue = y.plottableDate(yJSONValue) {
                            barMark2(x: xIntValue, y: yDateValue, height: height)
                        } else if let yStringValue = y.plottableString(yJSONValue) {
                            barMark2(x: xIntValue, y: yStringValue, height: height)
                        }
                    } else if let xDoubleValue = x.plottableDouble(xJSONValue) {
                        if let yIntValue = y.plottableInt(yJSONValue) {
                            barMark2(x: xDoubleValue, y: yIntValue, height: height)
                        } else if let yDoubleValue = y.plottableDouble(yJSONValue) {
                            barMark2(x: xDoubleValue, y: yDoubleValue, height: height)
                        } else if let yDateValue = y.plottableDate(yJSONValue) {
                            barMark2(x: xDoubleValue, y: yDateValue, height: height)
                        } else if let yStringValue = y.plottableString(yJSONValue) {
                            barMark2(x: xDoubleValue, y: yStringValue, height: height)
                        }
                    } else if let xDateValue = x.plottableDate(xJSONValue) {
                        if let yIntValue = y.plottableInt(yJSONValue) {
                            barMark2(x: xDateValue, y: yIntValue, height: height)
                        } else if let yDoubleValue = y.plottableDouble(yJSONValue) {
                            barMark2(x: xDateValue, y: yDoubleValue, height: height)
                        } else if let yDateValue = y.plottableDate(yJSONValue) {
                            barMark2(x: xDateValue, y: yDateValue, height: height)
                        } else if let yStringValue = y.plottableString(yJSONValue) {
                            barMark2(x: xDateValue, y: yStringValue, height: height)
                        }
                    } else
                    if let xStringValue = x.plottableString(xJSONValue) {
                        if let yIntValue = y.plottableInt(yJSONValue) {
                            barMark2(x: xStringValue, y: yIntValue, height: height)
                        } else if let yDoubleValue = y.plottableDouble(yJSONValue) {
                            barMark2(x: xStringValue, y: yDoubleValue, height: height)
                        } else if let yDateValue = y.plottableDate(yJSONValue) {
                            barMark2(x: xStringValue, y: yDateValue, height: height)
                        } else if let yStringValue = y.plottableString(yJSONValue) {
                            barMark2(x: xStringValue, y: yStringValue, height: height)
                        }
                    }
                }
            }
            .applyCommonConfig(commonConfig: commonConfig, datumDictionary: datum)
        }
    }
}
