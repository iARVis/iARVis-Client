//
//  ViewElementComponent+Example3+AreaChart.swift
//  iARVis
//
//  Created by Anonymous on 2022/9/4.
//

import Foundation

extension ViewElementComponent {
    static let example3_BabyNamesAreaChartAshleyJSONStr = """
    {
        "vStack": {
            "elements": [
                {
                    "chart": \(ChartConfigurationExample.chartConfigurationExample3_BabyNamesAreaChartAshley)
                }
            ]
        }
    }
    """

    static let example3BabyNamesAreaChartAshleyViewElementComponent: ViewElementComponent = try! JSONDecoder().decode(ViewElementComponent.self, from: example3_BabyNamesAreaChartAshleyJSONStr.data(using: .utf8)!)

    static let example3_BabyNamesAreaChartPatriciaJSONStr = """
    {
        "vStack": {
            "elements": [
                {
                    "chart": \(ChartConfigurationExample.chartConfigurationExample3_BabyNamesAreaChartPatricia)
                }
            ]
        }
    }
    """

    static let example3BabyNamesAreaChartPatriciaViewElementComponent: ViewElementComponent = try! JSONDecoder().decode(ViewElementComponent.self, from: example3_BabyNamesAreaChartPatriciaJSONStr.data(using: .utf8)!)

    static let example3_BabyNamesAreaChartJessicaJSONStr = """
    {
        "vStack": {
            "elements": [
                {
                    "chart": \(ChartConfigurationExample.chartConfigurationExample3_BabyNamesAreaChartJessica)
                }
            ]
        }
    }
    """

    static let example3BabyNamesAreaChartJessicaViewElementComponent: ViewElementComponent = try! JSONDecoder().decode(ViewElementComponent.self, from: example3_BabyNamesAreaChartJessicaJSONStr.data(using: .utf8)!)

    static let example3_BabyNamesAreaChartDeborahJSONStr = """
    {
        "vStack": {
            "elements": [
                {
                    "chart": \(ChartConfigurationExample.chartConfigurationExample3_BabyNamesAreaChartDeborah)
                }
            ]
        }
    }
    """

    static let example3BabyNamesAreaChartDeborahViewElementComponent: ViewElementComponent = try! JSONDecoder().decode(ViewElementComponent.self, from: example3_BabyNamesAreaChartDeborahJSONStr.data(using: .utf8)!)

    static let example3_BabyNamesAreaChartLindaJSONStr = """
    {
        "vStack": {
            "elements": [
                {
                    "chart": \(ChartConfigurationExample.chartConfigurationExample3_BabyNamesAreaChartLinda)
                }
            ]
        }
    }
    """

    static let example3BabyNamesAreaChartLindaViewElementComponent: ViewElementComponent = try! JSONDecoder().decode(ViewElementComponent.self, from: example3_BabyNamesAreaChartLindaJSONStr.data(using: .utf8)!)

    static let example3_BabyNamesAreaChartDorothyJSONStr = """
    {
        "vStack": {
            "elements": [
                {
                    "chart": \(ChartConfigurationExample.chartConfigurationExample3_BabyNamesAreaChartDorothy)
                }
            ]
        }
    }
    """

    static let example3BabyNamesAreaChartDorothyViewElementComponent: ViewElementComponent = try! JSONDecoder().decode(ViewElementComponent.self, from: example3_BabyNamesAreaChartDorothyJSONStr.data(using: .utf8)!)

    static let example3_BabyNamesAreaChartBettyJSONStr = """
    {
        "vStack": {
            "elements": [
                {
                    "chart": \(ChartConfigurationExample.chartConfigurationExample3_BabyNamesAreaChartBetty)
                }
            ]
        }
    }
    """

    static let example3BabyNamesAreaChartBettyViewElementComponent: ViewElementComponent = try! JSONDecoder().decode(ViewElementComponent.self, from: example3_BabyNamesAreaChartBettyJSONStr.data(using: .utf8)!)

    static let example3_BabyNamesAreaChartAmandaJSONStr = """
    {
        "vStack": {
            "elements": [
                {
                    "chart": \(ChartConfigurationExample.chartConfigurationExample3_BabyNamesAreaChartAmanda)
                }
            ]
        }
    }
    """

    static let example3BabyNamesAreaChartAmandaViewElementComponent: ViewElementComponent = try! JSONDecoder().decode(ViewElementComponent.self, from: example3_BabyNamesAreaChartAmandaJSONStr.data(using: .utf8)!)

    static let example3_BabyNamesAreaChartHelenJSONStr = """
    {
        "vStack": {
            "elements": [
                {
                    "chart": \(ChartConfigurationExample.chartConfigurationExample3_BabyNamesAreaChartHelen)
                }
            ]
        }
    }
    """

    static let example3BabyNamesAreaChartHelenViewElementComponent: ViewElementComponent = try! JSONDecoder().decode(ViewElementComponent.self, from: example3_BabyNamesAreaChartHelenJSONStr.data(using: .utf8)!)
}
