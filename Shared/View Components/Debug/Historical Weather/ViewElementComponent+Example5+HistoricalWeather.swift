//
//  ViewElementComponent+Example5+HistoricalWeather.swift
//  iARVis
//
//  Created by Anonymous on 2022/9/6.
//

import Foundation

extension ViewElementComponent {
    static let example5_HistoricalWeatherPointChartJSONStr = """
    {
        "vStack": {
            "elements": [
                {
                    "chart": \(ChartConfigurationExample.chartConfigurationExample5_WeatherHistoryChart)
                },
            ]
        }
    }
    """
    
    static let example5_HistoricalWeatherPointChartJSONStr_1 = """
    {
        "vStack": {
            "elements": [
                {
                    "chart": \(ChartConfigurationExample.chartConfigurationExample5_WeatherHistoryChart_1)
                },
            ]
        }
    }
    """
    
    static let example5_HistoricalWeatherPointChartJSONStr_2 = """
    {
        "vStack": {
            "elements": [
                {
                    "chart": \(ChartConfigurationExample.chartConfigurationExample5_WeatherHistoryChart_2)
                },
            ]
        }
    }
    """

    static let example5_HistoricalWeatherPointChartViewElementComponent: ViewElementComponent = try! JSONDecoder().decode(ViewElementComponent.self, from: example5_HistoricalWeatherPointChartJSONStr_1.data(using: .utf8)!)

    static let example5_HistoricalWeatherPointChartViewElementComponent_1: ViewElementComponent = try! JSONDecoder().decode(ViewElementComponent.self, from: example5_HistoricalWeatherPointChartJSONStr_1.data(using: .utf8)!)
    
    static let example5_HistoricalWeatherPointChartViewElementComponent_2: ViewElementComponent = try! JSONDecoder().decode(ViewElementComponent.self, from: example5_HistoricalWeatherPointChartJSONStr_2.data(using: .utf8)!)
}
