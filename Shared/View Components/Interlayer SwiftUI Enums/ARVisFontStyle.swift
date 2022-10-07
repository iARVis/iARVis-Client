//
//  ARVisFontStyle.swift
//  iARVis (iOS)
//
//  Created by Anonymous on 2022/8/10.
//

import Foundation
import SwiftUI

struct ARVisFontStyle: Codable, Equatable, Hashable {
    let size: CGFloat
    let weight: Weight?
    let design: Design?
    let color: ARVisColor?

    init(size: CGFloat, weight: ARVisFontStyle.Weight? = nil, design: ARVisFontStyle.Design? = nil, color: ARVisColor? = nil) {
        self.size = size
        self.weight = weight
        self.design = design
        self.color = color
    }
}

extension SwiftUI.Font {
    init?(_ fontStyle: ARVisFontStyle?) {
        if let fontStyle = fontStyle {
            self = .system(size: fontStyle.size,
                           weight: fontStyle.weight != nil ? .init(fontStyle.weight!) : .regular,
                           design: fontStyle.design != nil ? .init(fontStyle.design!) : .rounded)
        } else {
            return nil
        }
    }
}

extension ARVisFontStyle {
    enum Weight: String, Codable, Equatable {
        case black
        case bold
        case heavy
        case light
        case medium
        case regular
        case semibold
        case thin
        case ultraLight

        fileprivate func toSwiftUIFontWeight() -> SwiftUI.Font.Weight {
            switch self {
            case .black:
                return .black
            case .bold:
                return .bold
            case .heavy:
                return .heavy
            case .light:
                return .light
            case .medium:
                return .medium
            case .regular:
                return .regular
            case .semibold:
                return .semibold
            case .thin:
                return .thin
            case .ultraLight:
                return .ultraLight
            }
        }
    }
}

extension SwiftUI.Font.Weight {
    init(_ weight: ARVisFontStyle.Weight) {
        self = weight.toSwiftUIFontWeight()
    }
}

extension ARVisFontStyle {
    enum Design: String, Codable, Equatable {
        case `default`
        case monospaced
        case rounded
        case serif

        fileprivate func toSwiftUIFontDesign() -> SwiftUI.Font.Design {
            switch self {
            case .default:
                return .default
            case .monospaced:
                return .monospaced
            case .rounded:
                return .rounded
            case .serif:
                return .serif
            }
        }
    }
}

extension SwiftUI.Font.Design {
    init(_ design: ARVisFontStyle.Design) {
        self = design.toSwiftUIFontDesign()
    }
}
