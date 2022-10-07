//
//  ChartComponent+areaMarkRepeat1.swift
//  iARVis
//
//  Created by Anonymous on 2022/9/4.
//

import Charts
import Foundation
import SwiftUI
import SwiftyJSON

@available(iOS 16, *)
extension ChartComponent {
    @ChartContentBuilder
    @inlinable
    func areaMarkRepeat1(configuration _: ChartConfiguration, commonConfig: ChartComponentCommonConfig, dataItem: ChartDataItem, x: ARVisPlottableValueFieldPair, y: ARVisPlottableValueFieldPair, stacking: ARVisMarkStackingMethod?) -> some ChartContent {
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
                            areaMark(x: xIntValue, y: yIntValue, stacking: stacking)
                        } else if let yDoubleValue = y.plottableDouble(yJSONValue) {
                            areaMark(x: xIntValue, y: yDoubleValue, stacking: stacking)
                        } else if let yDateValue = y.plottableDate(yJSONValue) {
                            areaMark(x: xIntValue, y: yDateValue, stacking: stacking)
                        }
                    } else if let xDoubleValue = x.plottableDouble(xJSONValue) {
                        if let yIntValue = y.plottableInt(yJSONValue) {
                            areaMark(x: xDoubleValue, y: yIntValue, stacking: stacking)
                        } else if let yDoubleValue = y.plottableDouble(yJSONValue) {
                            areaMark(x: xDoubleValue, y: yDoubleValue, stacking: stacking)
                        } else if let yDateValue = y.plottableDate(yJSONValue) {
                            areaMark(x: xDoubleValue, y: yDateValue, stacking: stacking)
                        }
                    } else if let xDateValue = x.plottableDate(xJSONValue) {
                        if let yIntValue = y.plottableInt(yJSONValue) {
                            areaMark(x: xDateValue, y: yIntValue, stacking: stacking)
                        } else if let yDoubleValue = y.plottableDouble(yJSONValue) {
                            areaMark(x: xDateValue, y: yDoubleValue, stacking: stacking)
                        } else if let yDateValue = y.plottableDate(yJSONValue) {
                            areaMark(x: xDateValue, y: yDateValue, stacking: stacking)
                        }
                    } else if let xStringValue = x.plottableString(xJSONValue) {
                        if let yIntValue = y.plottableInt(yJSONValue) {
                            areaMark(x: xStringValue, y: yIntValue, stacking: stacking)
                        } else if let yDoubleValue = y.plottableDouble(yJSONValue) {
                            areaMark(x: xStringValue, y: yDoubleValue, stacking: stacking)
                        } else if let yDateValue = y.plottableDate(yJSONValue) {
                            areaMark(x: xStringValue, y: yDateValue, stacking: stacking)
                        }
                    }
                }
            }
            .applyCommonConfig(commonConfig: commonConfig, datumDictionary: datum)
        }
    }
}
