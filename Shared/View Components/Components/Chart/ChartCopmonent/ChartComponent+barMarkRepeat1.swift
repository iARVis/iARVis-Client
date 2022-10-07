//
//  ChartComponent+ToComponent.swift
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
    func barMarkRepeat1(configuration _: ChartConfiguration, commonConfig: ChartComponentCommonConfig, dataItem: ChartDataItem, xStart: ARVisPlottableValueFieldPair, xEnd: ARVisPlottableValueFieldPair, y: ARVisPlottableValueFieldPair, height: CGFloat?) -> some ChartContent {
        let datumArray = dataItem.datumArray
        ForEach(0 ..< dataItem.length, id: \.self) { index in
            let datum = datumArray[index]
            ChartGroup {
                if let xStartJSONValue = datum[xStart.field],
                   let xEndJSONValue = datum[xEnd.field],
                   let yJSONValue = datum[y.field] {
                    // Possible case:
                    // Int, String; Int, Int; Int, Double; Int, Date;
                    // Double, String; Double, Int; Double, Double; Double, Date;
                    // Date, String; Date, Int; Date, Double; Date, Date;
                    if let xStartIntValue = xStart.plottableInt(xStartJSONValue), let xEndIntValue = xEnd.plottableInt(xEndJSONValue) {
                        if let yIntValue = y.plottableInt(yJSONValue) {
                            barMark(xStart: xStartIntValue, xEnd: xEndIntValue, y: yIntValue, height: height)
                        } else if let yDoubleValue = y.plottableDouble(yJSONValue) {
                            barMark(xStart: xStartIntValue, xEnd: xEndIntValue, y: yDoubleValue, height: height)
                        } else if let yDateValue = y.plottableDate(yJSONValue) {
                            barMark(xStart: xStartIntValue, xEnd: xEndIntValue, y: yDateValue, height: height)
                        } else if let yStringValue = y.plottableString(yJSONValue) {
                            barMark(xStart: xStartIntValue, xEnd: xEndIntValue, y: yStringValue, height: height)
                        }
                    } else if let xStartDoubleValue = xStart.plottableDouble(xStartJSONValue), let xEndDoubleValue = xEnd.plottableDouble(xEndJSONValue) {
                        if let yIntValue = y.plottableInt(yJSONValue) {
                            barMark(xStart: xStartDoubleValue, xEnd: xEndDoubleValue, y: yIntValue, height: height)
                        } else if let yDoubleValue = y.plottableDouble(yJSONValue) {
                            barMark(xStart: xStartDoubleValue, xEnd: xEndDoubleValue, y: yDoubleValue, height: height)
                        } else if let yDateValue = y.plottableDate(yJSONValue) {
                            barMark(xStart: xStartDoubleValue, xEnd: xEndDoubleValue, y: yDateValue, height: height)
                        } else if let yStringValue = y.plottableString(yJSONValue) {
                            barMark(xStart: xStartDoubleValue, xEnd: xEndDoubleValue, y: yStringValue, height: height)
                        }
                    } else if let xStartDateValue = xStart.plottableDate(xStartJSONValue), let xEndDateValue = xEnd.plottableDate(xEndJSONValue) {
                        if let yIntValue = y.plottableInt(yJSONValue) {
                            barMark(xStart: xStartDateValue, xEnd: xEndDateValue, y: yIntValue, height: height)
                        } else if let yDoubleValue = y.plottableDouble(yJSONValue) {
                            barMark(xStart: xStartDateValue, xEnd: xEndDateValue, y: yDoubleValue, height: height)
                        } else if let yDateValue = y.plottableDate(yJSONValue) {
                            barMark(xStart: xStartDateValue, xEnd: xEndDateValue, y: yDateValue, height: height)
                        } else if let yStringValue = y.plottableString(yJSONValue) {
                            barMark(xStart: xStartDateValue, xEnd: xEndDateValue, y: yStringValue, height: height)
                        }
                    }
                }
            }
            .applyCommonConfig(commonConfig: commonConfig, datumDictionary: datum)
        }
    }
}
