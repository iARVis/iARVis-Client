//
//  ViewElementComponent+Example3+LineChart.swift
//  iARVis
//
//  Created by Anonymous on 2022/9/4.
//

import Foundation

extension ViewElementComponent {
    static let example3_BabyNamesLineChartJSONStr = """
    {
        "vStack": {
            "elements": [
                {
                    "chart": \(ChartConfigurationExample.chartConfigurationExample3_BabyNamesLineChart)
                },
            ]
        }
    }
    """
    
    static let example3BabyNamesLineChartViewElementComponent: ViewElementComponent = try! JSONDecoder().decode(ViewElementComponent.self, from: example3_BabyNamesLineChartJSONStr.data(using: .utf8)!)
}
