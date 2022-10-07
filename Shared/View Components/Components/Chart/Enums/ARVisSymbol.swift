//
//  ARVisSymbol.swift
//  iARVis
//
//  Created by Anonymous on 2022/8/23.
//

import Charts
import SwiftUI

/// A square symbol for charts.
struct Square: ChartSymbolShape, InsettableShape {
    let inset: CGFloat

    init(inset: CGFloat = 0) {
        self.inset = inset
    }

    func path(in rect: CGRect) -> Path {
        let cornerRadius: CGFloat = 1
        let minDimension = min(rect.width, rect.height)
        return Path(
            roundedRect: .init(x: rect.midX - minDimension / 2, y: rect.midY - minDimension / 2, width: minDimension, height: minDimension),
            cornerRadius: cornerRadius
        )
    }

    func inset(by amount: CGFloat) -> Square {
        Square(inset: inset + amount)
    }

    var perceptualUnitRect: CGRect {
        // The width of the unit rectangle (square). Adjust this to
        // size the diamond symbol so it perceptually matches with
        // the circle.
        let scaleAdjustment: CGFloat = 0.75
        return CGRect(x: 0.5 - scaleAdjustment / 2, y: 0.5 - scaleAdjustment / 2, width: scaleAdjustment, height: scaleAdjustment)
    }
}

struct ARVisSymbol: Codable, Hashable {
    var type: ARVisSymbolType

    static let circle = ARVisSymbol(type: .circle)
    static let square = ARVisSymbol(type: .square)
}

enum ARVisSymbolType: String, RawRepresentable, Codable, CaseIterable, Identifiable, Hashable {
    case circle = "Circle"
    case square = "Square"
    
    var id: Self {
        self
    }
}

@available(iOS 16, *)
extension ARVisSymbolType {
    var symbol: some ChartSymbolShape {
        switch self {
        case .circle:
            return AnyChartSymbolShape(Circle())
        case .square:
            return AnyChartSymbolShape(Square())
        }
    }
}

struct ARVisSymbolSize: Codable, Hashable {
    var width: CGFloat
    var height: CGFloat
}

extension CGSize {
    init(_ size: ARVisSymbolSize) {
        self = .init(width: size.width, height: size.height)
    }
}
