//
//  ChartView.swift
//  iARVis
//
//  Created by Anonymous on 2022/8/14.
//

import Charts
import SwiftUI
import SwiftyJSON

@available(iOS 16, *)
struct ChartView: View {
    @ObservedObject var chartConfiguration: ChartConfiguration

    @Environment(\.chartFocusAction) var chartFocusAction: ChartFocusAction

    var body: some View {
        let padding: (CGFloat?, CGFloat?, CGFloat?, CGFloat?) = {
            if let padding = chartConfiguration.swiftChartConfiguration.styleConfiguration?.padding {
                return (padding[safe: 0], padding[safe: 1], padding[safe: 2], padding[safe: 3])
            }
            return (0, 16, 0, 16)
        }()

        let xAxisDomain: AnyScaleDomain = {
            if let includingZero = chartConfiguration.swiftChartConfiguration.chartXScale?.includingZero {
                return AnyScaleDomain(.automatic(includesZero: includingZero))
            } else if let domain = chartConfiguration.swiftChartConfiguration.chartXScale?.domain, domain.count >= 2 {
                if let xStart = domain[0].int, let xEnd = domain[1].int {
                    return AnyScaleDomain(min(xStart, xEnd) ... max(xStart, xEnd))
                } else if let xStart = domain[0].double, let xEnd = domain[1].double {
                    return AnyScaleDomain(min(xStart, xEnd) ... max(xStart, xEnd))
                } else if let xStart = domain[0].date, let xEnd = domain[1].date {
                    return AnyScaleDomain(min(xStart, xEnd) ... max(xStart, xEnd))
                }
            }

            return AnyScaleDomain(.automatic)
        }()

        let yAxisDomain: AnyScaleDomain = {
            if let includingZero = chartConfiguration.swiftChartConfiguration.chartYScale?.includingZero {
                return AnyScaleDomain(.automatic(includesZero: includingZero))
            } else if let domain = chartConfiguration.swiftChartConfiguration.chartYScale?.domain, domain.count >= 2 {
                if let yStart = domain[0].int, let yEnd = domain[1].int {
                    return AnyScaleDomain(min(yStart, yEnd) ... max(yStart, yEnd))
                } else if let yStart = domain[0].double, let yEnd = domain[1].double {
                    return AnyScaleDomain(min(yStart, yEnd) ... max(yStart, yEnd))
                } else if let yStart = domain[0].date, let yEnd = domain[1].date {
                    return AnyScaleDomain(min(yStart, yEnd) ... max(yStart, yEnd))
                }
            }

            return AnyScaleDomain(.automatic)
        }()

        Chart {
            ForEach(0 ..< chartConfiguration.componentConfigs.count, id: \.self) { index in
                let componentConfig = chartConfiguration.componentConfigs[index]
                componentConfig.toChartContent(configuration: chartConfiguration)
            }
        }
        .onAppear {
            chartFocusAction.focus(chartConfiguration)
        }
        .chartLegend(chartConfiguration.swiftChartConfiguration.chartLegend?.hidden == true ? .hidden : .automatic)
        .chartXAxis(chartConfiguration.swiftChartConfiguration.chartXAxis?.hidden == true ? .hidden : .automatic)
        .chartXAxis {
            let values: AxisMarkValues? = {
                if let axisMarks = chartConfiguration.swiftChartConfiguration.chartXAxis?.axisMarks {
                    switch axisMarks.axisMarksValues {
                    case let .strideByDateComponent(component, count):
                        return AxisMarkValues.stride(by: .init(component), count: count)
                    }
                }
                return nil
            }()
            AxisMarks(values: values == nil ? .automatic : values!) { _ in
                AxisGridLine()
                AxisTick()
                switch chartConfiguration.swiftChartConfiguration.chartXAxis?.axisMarks?.axisValueLabel.format {
                case let .year(format):
                    switch format {
                    case .defaultDigits:
                        AxisValueLabel(format: .dateTime.year(.defaultDigits))
                    }
                case .none:
                    AxisValueLabel()
                }
            }
        }
        .chartYAxis(chartConfiguration.swiftChartConfiguration.chartYAxis?.hidden == true ? .hidden : .automatic)
        .chartYAxis {
            let values: AxisMarkValues? = {
                if let axisMarks = chartConfiguration.swiftChartConfiguration.chartYAxis?.axisMarks {
                    switch axisMarks.axisMarksValues {
                    case let .strideByDateComponent(component, count):
                        return AxisMarkValues.stride(by: .init(component), count: count)
                    }
                }
                return nil
            }()
            AxisMarks(values: values == nil ? .automatic : values!) { _ in
                AxisGridLine()
                AxisTick()

                switch chartConfiguration.swiftChartConfiguration.chartYAxis?.axisMarks?.axisValueLabel.format {
                case let .year(format):
                    switch format {
                    case .defaultDigits:
                        AxisValueLabel(format: .dateTime.year(.defaultDigits))
                    }
                case .none:
                    AxisValueLabel()
                }
            }
        }
        .chartXScale(domain: xAxisDomain)
        .chartYScale(domain: yAxisDomain)
        .chartOverlay { proxy in
            chartInteractionHandler(proxy: proxy)
//                .onTouch {
//                    chartFocusAction.focus(chartConfiguration)
//                }
        }
        .chartOverlay { proxy in
            chartAnnotationHandler(proxy: proxy, chartConfiguration: chartConfiguration)
        }
        .chartOverlay { proxy in
            chartTooltipHandler(proxy: proxy)
        }
//        .chartOverlay { _ in
//            #if DEBUG
//                GeometryReader { _ in
//                    ForEach(0 ..< chartConfiguration.components.count, id: \.self) { index in
//                        let component = chartConfiguration.components[index]
//                        if let selectedElement = chartConfiguration.interactionData.componentSelectedElementInRangeX[component] {
//                            Text(selectedElement.description)
//                        }
//                    }
//                }
//            #endif
//        }
        .frame(width: chartConfiguration.swiftChartConfiguration.styleConfiguration?.maxWidth, height: chartConfiguration.swiftChartConfiguration.styleConfiguration?.maxHeight)
        .frame(maxHeight: chartConfiguration.swiftChartConfiguration.styleConfiguration?.maxHeight == nil ? 200 : nil)
        .padding(.leading, padding.0)
        .padding(.top, padding.1)
        .padding(.trailing, padding.2)
        .padding(.bottom, padding.3)
    }
}

@available(iOS 16, *)
struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        let chartConfiguration = ChartConfigurationJSONParser.default.parse(JSON(ChartConfigurationExample.chartConfigurationExample1_ProvenanceChart.data(using: .utf8)!))
        ChartView(chartConfiguration: chartConfiguration)
            .previewLayout(.fixed(width: 720, height: 540))
    }
}

@available(iOS 16, *)
struct AnyScaleDomain: ScaleDomain {
    private var domain: ScaleDomain

    init<Domain: ScaleDomain>(_ domain: Domain) {
        self.domain = domain
    }

    func _makeScaleDomain() -> _ScaleDomainOutputs {
        domain._makeScaleDomain()
    }
}
