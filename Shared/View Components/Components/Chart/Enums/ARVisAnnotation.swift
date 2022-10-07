//
//  ARVisAnnotation.swift
//  iARVis
//
//  Created by Anonymous on 2022/8/26.
//

import Charts
import Foundation
import SwiftUI

enum ARVisAnnotationPosition: String, RawRepresentable, Codable, Hashable, CaseIterable, Identifiable {
    case topLeading
    case topTrailing
    case bottomTrailing
    case bottomLeading
    case leading
    case trailing
    case top
    case bottom
    case center

    var id: Self {
        self
    }
}

class ARVisAnnotation: Codable, Hashable {
    var position: ARVisAnnotationPosition
    var content: ViewElementComponent

    static func == (lhs: ARVisAnnotation, rhs: ARVisAnnotation) -> Bool {
        lhs.position == rhs.position &&
            lhs.content == rhs.content
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(position)
        hasher.combine(content.prettyJSON)
    }
}

@available(iOS 16, *)
extension AnnotationPosition {
    init(_ annotationPosition: ARVisAnnotationPosition) {
        switch annotationPosition {
        case .topLeading:
            self = .topLeading
        case .topTrailing:
            self = .topTrailing
        case .bottomTrailing:
            self = .bottomTrailing
        case .bottomLeading:
            self = .bottomLeading
        case .leading:
            self = .leading
        case .trailing:
            self = .trailing
        case .top:
            self = .top
        case .bottom:
            self = .bottom
        case .center:
            self = .overlay
        }
    }
}

@available(iOS 16, *)
extension Alignment {
    init(_ annotationPosition: ARVisAnnotationPosition) {
        switch annotationPosition {
        case .topLeading:
            self = .topLeading
        case .topTrailing:
            self = .topTrailing
        case .bottomTrailing:
            self = .bottomTrailing
        case .bottomLeading:
            self = .bottomLeading
        case .leading:
            self = .leading
        case .trailing:
            self = .trailing
        case .top:
            self = .top
        case .bottom:
            self = .bottom
        case .center:
            self = .center
        }
    }
}
