//
//  ChartCopmonent+rectangleMarkRepeat1.swift
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
    func rectangleMarkRepeat1(configuration _: ChartConfiguration, commonConfig: ChartComponentCommonConfig, dataItem: ChartDataItem, xStart: ARVisPlottableValueFieldPair, xEnd: ARVisPlottableValueFieldPair, yStart: ARVisPlottableValueFieldPair, yEnd: ARVisPlottableValueFieldPair) -> some ChartContent {
        let datumArray = dataItem.datumArray
        ForEach(0 ..< dataItem.length, id: \.self) { index in
            let datum = datumArray[index]
            ChartGroup {
                if let xStartJSONValue = datum[xStart.field],
                   let xEndJSONValue = datum[xEnd.field],
                   let yStartJSONValue = datum[yStart.field],
                   let yEndJSONValue = datum[yEnd.field] {
                    // Possible case:
                    // Int, Int; Int, Double; Int, Date;
                    // Double, Int; Double, Double; Double, Date;
                    //  Date, Int; Date, Double; Date, Date;
                    if let xStartIntValue = xStart.plottableInt(xStartJSONValue), let xEndIntValue = xEnd.plottableInt(xEndJSONValue) {
                        if let yStartIntValue = yStart.plottableInt(yStartJSONValue), let yEndIntValue = yEnd.plottableInt(yEndJSONValue) {
                            rectangleMark(xStart: xStartIntValue, xEnd: xEndIntValue, yStart: yStartIntValue, yEnd: yEndIntValue)
                        } else if let yStartDoubleValue = yStart.plottableDouble(yStartJSONValue), let yEndDoubleValue = yEnd.plottableDouble(yEndJSONValue) {
                            rectangleMark(xStart: xStartIntValue, xEnd: xEndIntValue, yStart: yStartDoubleValue, yEnd: yEndDoubleValue)
                        } else if let yStartDateValue = yStart.plottableDate(yStartJSONValue), let yEndDateValue = yEnd.plottableDate(yEndJSONValue) {
                            rectangleMark(xStart: xStartIntValue, xEnd: xEndIntValue, yStart: yStartDateValue, yEnd: yEndDateValue)
                        }
                    } else if let xStartDoubleValue = xStart.plottableDouble(xStartJSONValue), let xEndDoubleValue = xEnd.plottableDouble(xEndJSONValue) {
                        if let yStartIntValue = yStart.plottableInt(yStartJSONValue), let yEndIntValue = yEnd.plottableInt(yEndJSONValue) {
                            rectangleMark(xStart: xStartDoubleValue, xEnd: xEndDoubleValue, yStart: yStartIntValue, yEnd: yEndIntValue)
                        } else if let yStartDoubleValue = yStart.plottableDouble(yStartJSONValue), let yEndDoubleValue = yEnd.plottableDouble(yEndJSONValue) {
                            rectangleMark(xStart: xStartDoubleValue, xEnd: xEndDoubleValue, yStart: yStartDoubleValue, yEnd: yEndDoubleValue)
                        } else if let yStartDateValue = yStart.plottableDate(yStartJSONValue), let yEndDateValue = yEnd.plottableDate(yEndJSONValue) {
                            rectangleMark(xStart: xStartDoubleValue, xEnd: xEndDoubleValue, yStart: yStartDateValue, yEnd: yEndDateValue)
                        }
                    } else if let xStartDateValue = xStart.plottableDate(xStartJSONValue), let xEndDateValue = xEnd.plottableDate(xEndJSONValue) {
                        if let yStartIntValue = yStart.plottableInt(yStartJSONValue), let yEndIntValue = yEnd.plottableInt(yEndJSONValue) {
                            rectangleMark(xStart: xStartDateValue, xEnd: xEndDateValue, yStart: yStartIntValue, yEnd: yEndIntValue)
                        } else if let yStartDoubleValue = yStart.plottableDouble(yStartJSONValue), let yEndDoubleValue = yEnd.plottableDouble(yEndJSONValue) {
                            rectangleMark(xStart: xStartDateValue, xEnd: xEndDateValue, yStart: yStartDoubleValue, yEnd: yEndDoubleValue)
                        } else if let yStartDateValue = yStart.plottableDate(yStartJSONValue), let yEndDateValue = yEnd.plottableDate(yEndJSONValue) {
                            rectangleMark(xStart: xStartDateValue, xEnd: xEndDateValue, yStart: yStartDateValue, yEnd: yEndDateValue)
                        }
                    }
                }
            }
            .applyCommonConfig(commonConfig: commonConfig, datumDictionary: datum)
        }
    }
}
