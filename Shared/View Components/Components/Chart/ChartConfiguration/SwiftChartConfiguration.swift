//
//  SwiftChartConfiguration.swift
//  iARVis
//
//  Created by Anonymous on 2022/8/31.
//

import Foundation

@available(iOS 16, *)
struct SwiftChartConfiguration: Codable, Hashable {
    var chartXScale: ChartXScale?
    var chartYScale: ChartYScale?
    var chartXAxis: ChartXAxis?
    var chartYAxis: ChartYAxis?
    var styleConfiguration: ChartStyleConfiguration?
    var chartLegend: ChartLegend?
    var annotations: [ARVisAnnotation]?
}
