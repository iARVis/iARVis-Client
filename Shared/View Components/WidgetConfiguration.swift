//
//  WidgetConfiguration.swift
//  iARVis
//
//  Created by Anonymous on 2022/8/19.
//

import DefaultCodable
import Foundation
import SceneKit
import SwiftUI

struct AdditionalWidgetConfiguration: Codable, Hashable {
    @Default<False>
    var hidden: Bool
    var key: String
    var widgetConfiguration: WidgetConfiguration
}

class WidgetConfiguration: Codable, Hashable, ObservableObject {
    var component: ViewElementComponent
    var relativeAnchorPoint: WidgetAnchorPoint
    var relativePosition: SCNVector3
    var positionOffset: SCNVector3
    @Default<False>
    var alignedToTarget: Bool
    @Default<True>
    var isOpaque: Bool
    @Default<True>
    var isScrollEnabled: Bool
    @Default<True>
    var showExpandButton: Bool
    @Default<PaddingDefaultValueProvider>
    var padding: [CGFloat]
    @Default<ScaleDefaultValueProvider>
    var scale: CGFloat
    @Default<SizeDefaultValueProvider>
    var size: CGSize
    @Default<AdditionalWidgetConfigurationDefaultValueProvider>
    var additionalWidgetConfiguration: [String: AdditionalWidgetConfiguration]
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(component)
        hasher.combine(relativeAnchorPoint)
        hasher.combine(relativePosition)
        hasher.combine(positionOffset)
        hasher.combine(alignedToTarget)
        hasher.combine(isOpaque)
        hasher.combine(isScrollEnabled)
        hasher.combine(showExpandButton)
        hasher.combine(padding)
        hasher.combine(scale)
        hasher.combine(size)
        hasher.combine(additionalWidgetConfiguration)
    }
    
    init(component: ViewElementComponent,
         relativeAnchorPoint: WidgetAnchorPoint,
         relativePosition: SCNVector3,
         positionOffset: SCNVector3 = .zero,
         alignedToTarget: Bool = false,
         isOpaque: Bool = true,
         isScrollEnabled: Bool = true,
         showExpandButton: Bool = true,
         padding: [CGFloat] = PaddingDefaultValueProvider.default,
         scale: CGFloat = ScaleDefaultValueProvider.default,
         size: CGSize = SizeDefaultValueProvider.default,
         additionalWidgetConfiguration: [String: AdditionalWidgetConfiguration] = AdditionalWidgetConfigurationDefaultValueProvider.default) {
        self.component = component
        self.relativeAnchorPoint = relativeAnchorPoint
        self.relativePosition = relativePosition
        self.positionOffset = positionOffset
        self.alignedToTarget = alignedToTarget
        self.isOpaque = isOpaque
        self.isScrollEnabled = isScrollEnabled
        self.showExpandButton = showExpandButton
        self.padding = padding
        self.scale = scale
        self.size = size
        self.additionalWidgetConfiguration = additionalWidgetConfiguration
    }

    static func == (lhs: WidgetConfiguration, rhs: WidgetConfiguration) -> Bool {
        lhs.component == rhs.component &&
            lhs.relativeAnchorPoint == rhs.relativeAnchorPoint &&
            lhs.relativePosition == rhs.relativePosition &&
            lhs.positionOffset == rhs.positionOffset &&
            lhs.alignedToTarget == rhs.alignedToTarget &&
            lhs.isOpaque == rhs.isOpaque &&
            lhs.isScrollEnabled == rhs.isScrollEnabled &&
            lhs.showExpandButton == rhs.showExpandButton &&
            lhs.padding == rhs.padding &&
            lhs.scale == rhs.scale &&
            lhs.size == rhs.size &&
            lhs.additionalWidgetConfiguration == rhs.additionalWidgetConfiguration
    }
}

enum AdditionalWidgetConfigurationDefaultValueProvider: DefaultValueProvider {
    typealias Value = [String: AdditionalWidgetConfiguration]

    static let `default`: [String: AdditionalWidgetConfiguration] = [:]
}

enum PaddingDefaultValueProvider: DefaultValueProvider {
    typealias Value = [CGFloat]

    static let `default`: [CGFloat] = [16, 16, 16, 16]
}

enum ScaleDefaultValueProvider: DefaultValueProvider {
    typealias Value = CGFloat

    static let `default`: CGFloat = level_0
    static let level_0: CGFloat = 0.4 / 1024
    static let level_1: CGFloat = 0.4 / 1600
    static let level_2: CGFloat = 0.4 / 2048
    static let level_3: CGFloat = 0.4 / 3200
}

enum SizeDefaultValueProvider: DefaultValueProvider {
    typealias Value = CGSize

    static let `default`: CGSize = .init(width: 1024, height: 768)
}

struct WidgetConfigurationEnvironmentKey: EnvironmentKey {
    static let defaultValue: WidgetConfiguration? = nil
}

extension EnvironmentValues {
    var widgetConfiguration: WidgetConfiguration? {
        get { self[WidgetConfigurationEnvironmentKey.self] }
        set { self[WidgetConfigurationEnvironmentKey.self] = newValue }
    }
}
