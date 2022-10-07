//
//  ChartInteractionData.swift
//  iARVis
//
//  Created by Anonymous on 2022/8/27.
//

import Foundation
import SwiftyJSON

@available(iOS 16, *)
struct ChartInteractionHoverTooltipManualConfig: Hashable {
    var field: String
    var value: JSON
    var content: ViewElementComponent
}

enum ChartInteractionHoverTooltipType: String, RawRepresentable {
    case manual = "Manual"
    case auto = "Auto"
}

@available(iOS 16, *)
enum ChartInteractionHoverTooltip: Hashable {
    case manual(contents: [ChartInteractionHoverTooltipManualConfig])
    case auto(content: ViewElementComponent)
}

enum ChartInteractionClickActionType: String, RawRepresentable {
    case openURL = "OpenURL"
}

enum ChartInteractionClickAction: Hashable {
    case openURL(url: URL)
}

enum ChartInteractionType: String, RawRepresentable {
    case hover = "Hover"
    case click = "Click"
}

@available(iOS 16, *)
enum ChartInteraction: Hashable {
    case hover(tooltip: ChartInteractionHoverTooltip)
    case click(action: ChartInteractionClickAction)
}

@available(iOS 16, *)
class ChartInteractionData: Hashable, ObservableObject {
    static func == (lhs: ChartInteractionData, rhs: ChartInteractionData) -> Bool {
        lhs.componentSelectedElementInRangeX == rhs.componentSelectedElementInRangeX &&
            lhs.componentSelectedElementInRangeY == rhs.componentSelectedElementInRangeY &&
            lhs.componentSelectedElementInXY == rhs.componentSelectedElementInXY &&
            lhs.componentInteraction == rhs.componentInteraction &&
            lhs.componentSelectedElementView == rhs.componentSelectedElementView
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(componentSelectedElementInRangeX)
        hasher.combine(componentSelectedElementInRangeY)
        hasher.combine(componentSelectedElementInXY)
        hasher.combine(componentInteraction)
        hasher.combine(componentSelectedElementView)
    }

    @Published var componentSelectedElementInRangeX: [ChartComponent: JSON] = [:]
    @Published var componentSelectedElementInRangeY: [ChartComponent: JSON] = [:]
    @Published var componentSelectedElementInXY: [ChartComponent: JSON] = [:]
    @Published var componentInteraction: [ChartComponent: [ChartInteraction]] = [:]
    @Published var componentSelectedElementView: [ChartComponent: ViewElementComponent] = [:]

    init() {}

    init(componentInteraction: [ChartComponent: [ChartInteraction]]) {
        self.componentInteraction = componentInteraction
    }
}
