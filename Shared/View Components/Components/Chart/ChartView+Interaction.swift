//
//  ChartView+Interaction.swift
//  iARVis
//
//  Created by Anonymous on 2022/8/23.
//

import Charts
import Foundation
import SwiftUI
import SwiftyJSON

@available(iOS 16, *)
extension ChartView {
    private func updateInteractionData(component: ChartComponent,
                                       location: CGPoint,
                                       proxy: ChartProxy,
                                       geo: GeometryProxy,
                                       xStartField: String?,
                                       xEndField: String?,
                                       yStartField: String?,
                                       yEndField: String?,
                                       isClick: Bool,
                                       modeX: GetElementMode = .accurate,
                                       modeY: GetElementMode = .accurate) {
        var dataItemsRangeX: [JSON] = []
        if let xStartField = xStartField,
           let xEndField = xEndField {
            dataItemsRangeX = getElementInRangeX(proxy: proxy,
                                                 location: location,
                                                 geo: geo,
                                                 chartData: chartConfiguration.chartData.dataItems[component.dataKey],
                                                 xStartField: xStartField,
                                                 xEndField: xEndField,
                                                 mode: modeX)
            if dataItemsRangeX.count == 0 {
                chartConfiguration.interactionData.componentSelectedElementInRangeX[component] = nil
            } else {
                if isClick,
                   let selected = chartConfiguration.interactionData.componentSelectedElementInRangeX[component],
                   dataItemsRangeX.contains(selected) {
                    chartConfiguration.interactionData.componentSelectedElementInRangeX[component] = nil
                } else {
                    chartConfiguration.interactionData.componentSelectedElementInRangeX[component] = dataItemsRangeX.first
                }
            }
        } else {
            chartConfiguration.interactionData.componentSelectedElementInRangeX[component] = dataItemsRangeX.first
        }

        var dataItemsRangeY: [JSON] = []
        if let yStartField = yStartField,
           let yEndField = yEndField {
            dataItemsRangeY = getElementInRangeY(proxy: proxy,
                                                 location: location,
                                                 geo: geo,
                                                 chartData: chartConfiguration.chartData.dataItems[component.dataKey],
                                                 yStartField: yStartField,
                                                 yEndField: yEndField,
                                                 mode: modeY)
            if dataItemsRangeY.count == 0 {
                chartConfiguration.interactionData.componentSelectedElementInRangeY[component] = nil
            } else {
                if isClick,
                   let selected = chartConfiguration.interactionData.componentSelectedElementInRangeY[component],
                   dataItemsRangeY.contains(selected) {
                    chartConfiguration.interactionData.componentSelectedElementInRangeY[component] = nil
                } else {
                    chartConfiguration.interactionData.componentSelectedElementInRangeY[component] = dataItemsRangeY.first
                }
            }
        } else {
            chartConfiguration.interactionData.componentSelectedElementInRangeY[component] = dataItemsRangeX.first
        }

        var found = false
        outerLoop: for jsonX in dataItemsRangeX {
            for jsonY in dataItemsRangeY {
                if jsonX == jsonY {
                    found = true
                    if isClick,
                       let selected = chartConfiguration.interactionData.componentSelectedElementInXY[component],
                       selected == jsonX {
                        chartConfiguration.interactionData.componentSelectedElementInXY[component] = nil
                    } else {
                        chartConfiguration.interactionData.componentSelectedElementInXY[component] = jsonX
                    }
                    break outerLoop
                }
            }
        }

        if !found {
            chartConfiguration.interactionData.componentSelectedElementInXY[component] = nil
        }
    }

    func updateInteractionOverlay(component: ChartComponent, isClick: Bool) {
        if let interactions = chartConfiguration.interactionData.componentInteraction[component] {
            for interaction in interactions {
                switch interaction {
                case let .click(action):
                    if isClick {
                        switch action {
                        case let .openURL(url):
                            if let _ = chartConfiguration.interactionData.componentSelectedElementInXY[component] {
                                UIApplication.shared.open(url)
                            }
                        }
                    }
                case let .hover(tooltip):
                    switch tooltip {
                    case .auto:
                        fatalErrorDebug("Not implemented yet.")
                    case let .manual(contents):
                        switch component.hoverType {
                        case .rangeX:
                            if let dataItem = chartConfiguration.interactionData.componentSelectedElementInRangeX[component] {
                                var found = false
                                for content in contents {
                                    if dataItem[content.field] == content.value {
                                        chartConfiguration.interactionData.componentSelectedElementView[component] = content.content
                                        found = true
                                        break
                                    }
                                }
                                if !found {
                                    chartConfiguration.interactionData.componentSelectedElementView[component] = nil
                                }
                            } else {
                                chartConfiguration.interactionData.componentSelectedElementView[component] = nil
                            }
                        case .rangeY:
                            if let dataItem = chartConfiguration.interactionData.componentSelectedElementInRangeY[component] {
                                var found = false
                                for content in contents {
                                    if dataItem[content.field] == content.value {
                                        chartConfiguration.interactionData.componentSelectedElementView[component] = content.content
                                        found = true
                                        break
                                    }
                                }
                                if !found {
                                    chartConfiguration.interactionData.componentSelectedElementView[component] = nil
                                }
                            } else {
                                chartConfiguration.interactionData.componentSelectedElementView[component] = nil
                            }
                        case .xy:
                            if let dataItem = chartConfiguration.interactionData.componentSelectedElementInXY[component] {
                                var found = false
                                for content in contents {
                                    if dataItem[content.field] == content.value {
                                        chartConfiguration.interactionData.componentSelectedElementView[component] = content.content
                                        found = true
                                        break
                                    }
                                }
                                if !found {
                                    chartConfiguration.interactionData.componentSelectedElementView[component] = nil
                                }
                            } else {
                                chartConfiguration.interactionData.componentSelectedElementView[component] = nil
                            }
                        }
                    }
                }
            }
        }
    }

    @ViewBuilder
    func chartInteractionHandler(proxy: ChartProxy) -> some View {
        GeometryReader { geo in
            Rectangle().fill(.clear).contentShape(Rectangle())
                .gesture(
                    SpatialTapGesture()
                        .onEnded { value in
                            chartFocusAction.focus(chartConfiguration)
                            let location = value.location
                            for componentConfig in chartConfiguration.componentConfigs {
                                switch componentConfig.component {
                                case let .barMarkRepeat1(_, xStart, xEnd, y, _):
                                    updateInteractionData(component: componentConfig.component,
                                                          location: location,
                                                          proxy: proxy,
                                                          geo: geo,
                                                          xStartField: xStart.field,
                                                          xEndField: xEnd.field,
                                                          yStartField: y.field,
                                                          yEndField: y.field,
                                                          isClick: true)
                                case let .barMarkRepeat2(dataKey, x, y, height):
                                    // TODO: barMarkRepeat1
                                    break
                                case let .lineMarkRepeat1(_, x, y):
                                    updateInteractionData(component: componentConfig.component,
                                                          location: location,
                                                          proxy: proxy,
                                                          geo: geo,
                                                          xStartField: x.field,
                                                          xEndField: x.field,
                                                          yStartField: y.field,
                                                          yEndField: y.field,
                                                          isClick: true,
                                                          modeX: .nearest,
                                                          modeY: .accurate)

                                case let .lineMarkRepeat2(dataKey: dataKey, x: x, ySeries: ySeries):
                                    // TODO: lineMarkRepeat2
                                    break
                                case let .rectangleMarkRepeat1(_, xStart, xEnd, yStart, yEnd):
                                    updateInteractionData(component: componentConfig.component,
                                                          location: location,
                                                          proxy: proxy,
                                                          geo: geo,
                                                          xStartField: xStart.field,
                                                          xEndField: xEnd.field,
                                                          yStartField: yStart.field,
                                                          yEndField: yEnd.field,
                                                          isClick: true)
                                case let .ruleMarkRepeat1(_, x, yStart, yEnd):
                                    updateInteractionData(component: componentConfig.component,
                                                          location: location,
                                                          proxy: proxy,
                                                          geo: geo,
                                                          xStartField: x.field,
                                                          xEndField: x.field,
                                                          yStartField: yStart?.field,
                                                          yEndField: yEnd?.field,
                                                          isClick: true)
                                case let .pointMarkRepeat1(_, x, y):
                                    updateInteractionData(component: componentConfig.component,
                                                          location: location,
                                                          proxy: proxy,
                                                          geo: geo,
                                                          xStartField: x.field,
                                                          xEndField: x.field,
                                                          yStartField: y.field,
                                                          yEndField: y.field,
                                                          isClick: true,
                                                          modeX: .nearest,
                                                          modeY: .nearest)
                                case let .areaMarkRepeat1(dataKey, x, y, stacking):
                                    break
                                }
                                updateInteractionOverlay(component: componentConfig.component, isClick: true)
                            }
                        }
                        .exclusively(
                            before: DragGesture(minimumDistance: 0.01)
                                .onChanged { value in
                                    chartFocusAction.focus(chartConfiguration)
                                    let location = value.location
                                    for componentConfig in chartConfiguration.componentConfigs {
                                        switch componentConfig.component {
                                        case let .barMarkRepeat1(_, xStart, xEnd, y, _):
                                            updateInteractionData(component: componentConfig.component,
                                                                  location: location,
                                                                  proxy: proxy,
                                                                  geo: geo,
                                                                  xStartField: xStart.field,
                                                                  xEndField: xEnd.field,
                                                                  yStartField: y.field,
                                                                  yEndField: y.field,
                                                                  isClick: false)
                                        case let .barMarkRepeat2(dataKey, x, y, height):
                                            // TODO: barMarkRepeat1
                                            break
                                        case let .lineMarkRepeat1(_, x, y):
                                            updateInteractionData(component: componentConfig.component,
                                                                  location: location,
                                                                  proxy: proxy,
                                                                  geo: geo,
                                                                  xStartField: x.field,
                                                                  xEndField: x.field,
                                                                  yStartField: y.field,
                                                                  yEndField: y.field,
                                                                  isClick: false,
                                                                  modeX: .nearest,
                                                                  modeY: .accurate)
                                        case let .lineMarkRepeat2(dataKey: dataKey, x: x, ySeries: ySeries):
                                            // TODO: lineMarkRepeat2
                                            break
                                        case let .rectangleMarkRepeat1(_, xStart, xEnd, yStart, yEnd):
                                            updateInteractionData(component: componentConfig.component,
                                                                  location: location,
                                                                  proxy: proxy,
                                                                  geo: geo,
                                                                  xStartField: xStart.field,
                                                                  xEndField: xEnd.field,
                                                                  yStartField: yStart.field,
                                                                  yEndField: yEnd.field,
                                                                  isClick: false)
                                        case let .ruleMarkRepeat1(_, x, yStart, yEnd):
                                            updateInteractionData(component: componentConfig.component,
                                                                  location: location,
                                                                  proxy: proxy,
                                                                  geo: geo,
                                                                  xStartField: x.field,
                                                                  xEndField: x.field,
                                                                  yStartField: yStart?.field,
                                                                  yEndField: yEnd?.field,
                                                                  isClick: false)
                                        case let .pointMarkRepeat1(_, x, y):
                                            updateInteractionData(component: componentConfig.component,
                                                                  location: location,
                                                                  proxy: proxy,
                                                                  geo: geo,
                                                                  xStartField: x.field,
                                                                  xEndField: x.field,
                                                                  yStartField: y.field,
                                                                  yEndField: y.field,
                                                                  isClick: false,
                                                                  modeX: .nearest,
                                                                  modeY: .nearest)
                                        case let .areaMarkRepeat1(dataKey, x, y, stacking):
                                            break
                                        }
                                        updateInteractionOverlay(component: componentConfig.component, isClick: false)
                                    }
                                }
                        )
                )
        }
    }
}
