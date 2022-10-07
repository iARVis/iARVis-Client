//
//  ChartComponent+pointMarkRepeat1.swift
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
    func pointMarkRepeat1(configuration _: ChartConfiguration, commonConfig: ChartComponentCommonConfig, dataItem: ChartDataItem, x: ARVisPlottableValueFieldPair, y: ARVisPlottableValueFieldPair) -> some ChartContent {
        let datumArray = dataItem.datumArray
        ForEach(0 ..< dataItem.length, id: \.self) { index in
            let datum = datumArray[index]
            ChartGroup {
                if let xJSONValue = datum[x.field],
                   let yJSONValue = datum[y.field] {
                    // Possible case:
                    //  Int, Int; Int, Double; Int, Date;
                    //  Double, Int; Double, Double; Double, Date;
                    //  Date, Int; Date, Double; Date, Date;
                    //  String, Int; String, Double; String, Date;
                    if let xIntValue = x.plottableInt(xJSONValue) {
                        if let yIntValue = y.plottableInt(yJSONValue) {
                            pointMark(x: xIntValue, y: yIntValue)
                        } else if let yDoubleValue = y.plottableDouble(yJSONValue) {
                            pointMark(x: xIntValue, y: yDoubleValue)
                        } else if let yDateValue = y.plottableDate(yJSONValue) {
                            pointMark(x: xIntValue, y: yDateValue)
                        }
                    } else if let xDoubleValue = x.plottableDouble(xJSONValue) {
                        if let yIntValue = y.plottableInt(yJSONValue) {
                            pointMark(x: xDoubleValue, y: yIntValue)
                        } else if let yDoubleValue = y.plottableDouble(yJSONValue) {
                            pointMark(x: xDoubleValue, y: yDoubleValue)
                        } else if let yDateValue = y.plottableDate(yJSONValue) {
                            pointMark(x: xDoubleValue, y: yDateValue)
                        }
                    } else if let xDateValue = x.plottableDate(xJSONValue) {
                        if let yIntValue = y.plottableInt(yJSONValue) {
                            pointMark(x: xDateValue, y: yIntValue)
                        } else if let yDoubleValue = y.plottableDouble(yJSONValue) {
                            pointMark(x: xDateValue, y: yDoubleValue)
                        } else if let yDateValue = y.plottableDate(yJSONValue) {
                            pointMark(x: xDateValue, y: yDateValue)
                        }
                    } else if let xStringValue = x.plottableString(xJSONValue) {
                        if let yIntValue = y.plottableInt(yJSONValue) {
                            pointMark(x: xStringValue, y: yIntValue)
                        } else if let yDoubleValue = y.plottableDouble(yJSONValue) {
                            pointMark(x: xStringValue, y: yDoubleValue)
                        } else if let yDateValue = y.plottableDate(yJSONValue) {
                            pointMark(x: xStringValue, y: yDateValue)
                        }
                    }
                }
            }
            .applyCommonConfig(commonConfig: commonConfig, datumDictionary: datum)
        }
    }
}
