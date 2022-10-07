//
//  ViewElementComponent+Example1+Chart.swift
//  iARVis (iOS)
//
//  Created by Anonymous on 2022/8/29.
//

import Foundation

extension ViewElementComponent {
    static let example1_ProvenanceChartViewElementComponentJSONStr = """
    {
        "vStack": {
            "elements": [
                {
                    "chart": \(ChartConfigurationExample.chartConfigurationExample1_ProvenanceChart)
                },
                {
                    "text": {
                        "content": "History of this Artwork - Provenance",
                        "fontStyle" : {
                            "size": 15,
                            "weight": "light"
                        }
                    }
                }
            ]
        }
    }
    """

    static let example1_HistoricalPriceChartViewElementComponentJSONStr = """
    {
        "vStack": {
            "elements": [
                {
                    "chart": \(ChartConfigurationExample.chartConfigurationExample1_HistoricalPriceChart)
                },
                {
                    "text": {
                        "content": "History of this Artwork - Historical Price",
                        "fontStyle" : {
                            "size": 15,
                            "weight": "light"
                        }
                    }
                }
            ]
        }
    }
    """

    static let example1_ProvenanceChartViewElementComponent: ViewElementComponent = try! JSONDecoder().decode(ViewElementComponent.self, from: example1_ProvenanceChartViewElementComponentJSONStr.data(using: .utf8)!)

    static let example1_HistoricalPriceChartViewElementComponent: ViewElementComponent = try! JSONDecoder().decode(ViewElementComponent.self, from: example1_HistoricalPriceChartViewElementComponentJSONStr.data(using: .utf8)!)

    static let example1_JamesEnsorLifeChartViewElementComponent: ViewElementComponent = try! JSONDecoder().decode(ViewElementComponent.self, from: """
    {"chart":\(ChartConfigurationExample.chartConfigurationExample1_JamesEnsorChart)}
    """.data(using: .utf8)!)
}
