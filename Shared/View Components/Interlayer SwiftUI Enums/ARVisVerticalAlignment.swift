//
//  ARVisVerticalAlignment.swift
//  iARVis (iOS)
//
//  Created by Anonymous on 2022/8/11.
//

import Foundation
import SwiftUI

enum ARVisVerticalAlignment: String, Codable, Hashable {
    case center
    case top
    case bottom

    fileprivate func toSwiftUIVerticalAlignment() -> SwiftUI.VerticalAlignment {
        switch self {
        case .center:
            return .center
        case .top:
            return .top
        case .bottom:
            return .bottom
        }
    }
}

extension SwiftUI.VerticalAlignment {
    init(_ verticalAlignment: ARVisVerticalAlignment?) {
        self = verticalAlignment?.toSwiftUIVerticalAlignment() ?? .center
    }
}
