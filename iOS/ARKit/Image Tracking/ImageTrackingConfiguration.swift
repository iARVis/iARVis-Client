//
//  ImageTrackingConfiguration.swift
//  iARVis (iOS)
//
//  Created by Anonymous on 2022/7/31.
//

import Foundation
import SceneKit

class ImageTrackingConfiguration: Codable, Equatable {
    static func == (lhs: ImageTrackingConfiguration, rhs: ImageTrackingConfiguration) -> Bool {
        lhs.imageURL == rhs.imageURL &&
            lhs.relationships == rhs.relationships
    }

    var imageURL: URL
    var relationships: [WidgetImageRelationship] = []

    init(imageURL: URL, relationships: [WidgetImageRelationship] = []) {
        self.imageURL = imageURL
        self.relationships = relationships
    }
}

class WidgetImageRelationship: Codable, Hashable {
    static func == (lhs: WidgetImageRelationship, rhs: WidgetImageRelationship) -> Bool {
        lhs.widgetConfiguration == rhs.widgetConfiguration
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(widgetConfiguration)
    }

    var widgetConfiguration: WidgetConfiguration

    init(widgetConfiguration: WidgetConfiguration) {
        self.widgetConfiguration = widgetConfiguration
    }
}

enum WidgetAnchorPoint: String, Codable, Equatable, CaseIterable {
    case center
    case leading
    case trailing
    case top
    case bottom
    case cover
    case auto
}

extension ImageTrackingConfiguration {
    static let example1 = ImageTrackingExample.exampleConfiguration1
    static let example2 = ImageTrackingExample.exampleConfiguration2
    static let example3 = ImageTrackingExample.exampleConfiguration3
    static let example4 = ImageTrackingExample.exampleConfiguration4
    static let example5 = ImageTrackingExample.exampleConfiguration5
    static let example6 = ImageTrackingExample.exampleConfiguration6
}
