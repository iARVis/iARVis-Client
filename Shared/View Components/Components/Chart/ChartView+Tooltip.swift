//
//  ChartView+Tooltip.swift
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
    @ViewBuilder
    func chartTooltipHandler(proxy: ChartProxy) -> some View {
        GeometryReader { geoProxy in
            let topOffset = min(0, -geoProxy.frame(in: .named("Widget")).origin.y)
            ForEach(0 ..< chartConfiguration.componentConfigs.count, id: \.self) { index in
                let component = chartConfiguration.componentConfigs[index].component
                let viewComponent: ViewElementComponent? = chartConfiguration.interactionData.componentSelectedElementView[component]
                if let viewComponent = viewComponent {
                    switch component {
                    case let .barMarkRepeat1(_, xStart, xEnd, y, _):
                        let selectedElement: JSON? = chartConfiguration.interactionData.componentSelectedElementInRangeX[component]
                        if let selectedElement = selectedElement {
                            if let leftPoint = proxy.position(at: (selectedElement[xStart.field], selectedElement[y.field])),
                               let rightPoint = proxy.position(at: (selectedElement[xEnd.field], selectedElement[y.field])) {
                                let centerPoint: CGPoint = (leftPoint + rightPoint) / 2
                                let targetSize: CGSize = ChartTooltipView(viewComponent).adaptiveSizeThatFits(in: .init(width: 250, height: 140), for: .regular)
                                let maxTooltipX: CGFloat = geoProxy.size.width - targetSize.width
                                let offsetX: CGFloat = min(maxTooltipX, max(0, centerPoint.x - targetSize.width / 2))
                                let offsetY: CGFloat = max(topOffset + 8, centerPoint.y - targetSize.height - 8)
                                ChartTooltipView(viewComponent)
                                    .frame(width: targetSize.width, height: targetSize.height)
                                    .offset(x: offsetX, y: offsetY)
                                    .id(selectedElement.rawString(options: []))
                            }
                        }
                    case let .barMarkRepeat2(_, x, y, height):
                        // TODO: barMarkRepeat1
                        EmptyView()
                    case let .lineMarkRepeat1(_, x, y):
                        let selectedElement: JSON? = chartConfiguration.interactionData.componentSelectedElementInRangeX[component]
                        if let selectedElement = selectedElement {
                            if let centerPoint = proxy.position(at: (selectedElement[x.field], selectedElement[y.field])) {
                                let targetSize: CGSize = ChartTooltipView(viewComponent).adaptiveSizeThatFits(in: .init(width: 250, height: 140), for: .regular)
                                let maxTooltipX: CGFloat = geoProxy.size.width - targetSize.width
                                let offsetX: CGFloat = min(maxTooltipX, max(0, centerPoint.x - targetSize.width / 2))
                                let offsetY: CGFloat = max(topOffset + 8, centerPoint.y - targetSize.height - 8)
                                ChartTooltipView(viewComponent)
                                    .frame(width: targetSize.width, height: targetSize.height)
                                    .offset(x: offsetX, y: offsetY)
                                    .id(selectedElement.rawString(options: []))
                            }
                        }
                    case let .rectangleMarkRepeat1(_, xStart, xEnd, _, yEnd):
                        let selectedElement: JSON? = chartConfiguration.interactionData.componentSelectedElementInRangeX[component]
                        if let selectedElement = selectedElement {
                            if let leftPoint = proxy.position(at: (selectedElement[xStart.field], selectedElement[yEnd.field])),
                               let rightPoint = proxy.position(at: (selectedElement[xEnd.field], selectedElement[yEnd.field])) {
                                let centerPoint: CGPoint = (leftPoint + rightPoint) / 2
                                let targetSize: CGSize = ChartTooltipView(viewComponent).adaptiveSizeThatFits(in: .init(width: 250, height: 140), for: .regular)
                                let maxTooltipX: CGFloat = geoProxy.size.width - targetSize.width
                                let offsetX: CGFloat = min(maxTooltipX, max(0, centerPoint.x - targetSize.width / 2))
                                let offsetY: CGFloat = max(topOffset + 8, centerPoint.y - targetSize.height - 8)
                                ChartTooltipView(viewComponent)
                                    .frame(width: targetSize.width, height: targetSize.height)
                                    .offset(x: offsetX, y: offsetY)
                                    .id(selectedElement.rawString(options: []))
                            }
                        }
                    case .ruleMarkRepeat1:
                        EmptyView()
                    case let .pointMarkRepeat1(_, x, y):
                        let selectedElement: JSON? = chartConfiguration.interactionData.componentSelectedElementInRangeX[component]
                        if let selectedElement = selectedElement {
                            if let centerPoint = proxy.position(at: (selectedElement[x.field], selectedElement[y.field])) {
                                let targetSize: CGSize = ChartTooltipView(viewComponent).adaptiveSizeThatFits(in: .init(width: 250, height: 140), for: .regular)
                                let maxTooltipX: CGFloat = geoProxy.size.width - targetSize.width
                                let offsetX: CGFloat = min(maxTooltipX, max(0, centerPoint.x - targetSize.width / 2))
                                let offsetY: CGFloat = max(topOffset + 8, centerPoint.y - targetSize.height - 8)
                                ChartTooltipView(viewComponent)
                                    .frame(width: targetSize.width, height: targetSize.height)
                                    .offset(x: offsetX, y: offsetY)
                                    .id(selectedElement.rawString(options: []))
                            }
                        }
                    case let .lineMarkRepeat2(_, x, ySeries):
                        // TODO: lineMarkRepeat2
                        EmptyView()
                    case let .areaMarkRepeat1(dataKey, x, y, stacking):
                        EmptyView()
                    }
                }
            }
        }
        .animation(.default, value: UUID())
        .transition(.opacity)
    }
}
