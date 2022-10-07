//
//  ViewElementComponent+Example4+ShanghaiWeather.swift
//  iARVis
//
//  Created by Anonymous on 2022/9/5.
//

import Foundation
extension ViewElementComponent {
    static let example4_ShanghaiWeatherPointChartJSONStr = """
    {
        "vStack": {
            "elements": [
                {
                    "chart": \(ChartConfigurationExample.chartConfigurationExample4_ShanghaiWeatherPointChart)
                },
            ]
        }
    }
    """

    static let example4_ShanghaiWeatherPointChartViewElementComponent: ViewElementComponent = try! JSONDecoder().decode(ViewElementComponent.self, from: example4_ShanghaiWeatherPointChartJSONStr.data(using: .utf8)!)
}
