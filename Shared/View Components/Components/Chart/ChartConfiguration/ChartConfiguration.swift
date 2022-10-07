//
//  ChartConfiguration.swift
//  iARVis
//
//  Created by Anonymous on 2022/8/14.
//

import Charts
import Combine
import Foundation
import SwiftUI
import SwiftyJSON

class ChartConfiguration: ObservableObject {
    @available(iOS 16, *)
    init() {
        chartData = ChartData()
        componentConfigs = [ChartComponentConfiguration]()
        interactionData = ChartInteractionData()
        swiftChartConfiguration = SwiftChartConfiguration()
    }

    init(_chartData _: Any? = nil, _componentConfigs _: Any? = nil, _interactionData _: Any? = nil, _swiftChartConfiguration _: Any? = nil) {
        _chartData = nil
        _componentConfigs = nil
        _interactionData = nil
        _swiftChartConfiguration = nil
    }

    @available(iOS 16, *)
    var chartData: ChartData {
        get {
            _chartData as! ChartData
        }
        set {
            _chartData = newValue
        }
    }

    private var _chartData: Any?

    @available(iOS 16, *)
    var componentConfigs: [ChartComponentConfiguration] {
        get {
            _componentConfigs as! [ChartComponentConfiguration]
        }
        set {
            _componentConfigs = newValue
        }
    }

    private var _componentConfigs: Any?

    @available(iOS 16, *)
    var interactionData: ChartInteractionData {
        get {
            _interactionData as! ChartInteractionData
        }
        set {
            _interactionData = newValue
            anyCancellable = newValue.objectWillChange.sink { [weak self] _ in
                self?.objectWillChange.send()
            }
        }
    }

    private var _interactionData: Any?

    @available(iOS 16, *)
    var swiftChartConfiguration: SwiftChartConfiguration {
        get {
            _swiftChartConfiguration as! SwiftChartConfiguration
        }
        set {
            _swiftChartConfiguration = newValue
        }
    }

    private var _swiftChartConfiguration: Any?

    var anyCancellable: AnyCancellable?
}

extension ChartConfiguration: Equatable {
    static func == (lhs: ChartConfiguration, rhs: ChartConfiguration) -> Bool {
        if #available(iOS 16, *) {
            return lhs.chartData == rhs.chartData &&
                lhs.componentConfigs == rhs.componentConfigs &&
                lhs.interactionData == rhs.interactionData &&
                lhs.swiftChartConfiguration == rhs.swiftChartConfiguration
        } else {
            return true
        }
    }
}

extension ChartConfiguration: Hashable {
    func hash(into hasher: inout Hasher) {
        if #available(iOS 16, *) {
            hasher.combine(chartData)
            hasher.combine(componentConfigs)
            hasher.combine(interactionData)
            hasher.combine(swiftChartConfiguration)
        }
    }
}
