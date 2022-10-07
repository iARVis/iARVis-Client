//
//  ARVisHorizontalAlignment.swift
//  iARVis (iOS)
//
//  Created by Anonymous on 2022/8/10.
//

import Foundation
import SwiftUI

enum ARVisHorizontalAlignment: String, Codable, Hashable {
    case center
    case leading
    case trailing

    fileprivate func toSwiftUIHorizontalAlignment() -> SwiftUI.HorizontalAlignment {
        switch self {
        case .center:
            return .center
        case .leading:
            return .leading
        case .trailing:
            return .trailing
        }
    }
}

extension SwiftUI.HorizontalAlignment {
    init(_ horizontalAlignment: ARVisHorizontalAlignment?) {
        self = horizontalAlignment?.toSwiftUIHorizontalAlignment() ?? .center
    }
}
