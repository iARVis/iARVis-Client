//
//  ChartComponentConfiguration.swift
//  iARVis
//
//  Created by Anonymous on 2022/8/27.
//

import Charts
import Foundation
import SwiftUI

@available(iOS 16, *)
struct ChartComponentConfiguration: Hashable {
    var component: ChartComponent
    var commonConfig: ChartComponentCommonConfig

    @ChartContentBuilder
    func toChartContent(configuration: ChartConfiguration) -> some ChartContent {
        component.toChartContent(configuration: configuration, commonConfig: commonConfig)
            .applyCommonConfig(commonConfig: commonConfig)
    }
}

@available(iOS 16, *)
extension ChartContent {
    @ChartContentBuilder
    func applyCommonConfig(commonConfig: ChartComponentCommonConfig) -> some ChartContent {
        self.interpolationMethod(commonConfig.interpolationMethod != nil ? InterpolationMethod(commonConfig.interpolationMethod!) : InterpolationMethod.linear)
            .symbol(commonConfig.symbol != nil ? commonConfig.symbol!.type.symbol : ARVisSymbol.circle.type.symbol)
            .symbolSize(commonConfig.symbolSize != nil ? CGSize(commonConfig.symbolSize!) : commonConfig.symbol != nil ? CGSize(width: 5, height: 5) : CGSize(width: 0, height: 0))
            .lineStyle(commonConfig.lineStyle != nil ? .init(commonConfig.lineStyle!) : StrokeStyle())
            .position(by: .value(commonConfig.positionByValue != nil ? commonConfig.positionByValue! : "position", commonConfig.positionByValue != nil ? commonConfig.positionByValue! : ""))
    }
}
