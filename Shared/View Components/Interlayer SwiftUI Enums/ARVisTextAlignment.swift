//
//  ARVisTextAlignment.swift
//  iARVis (iOS)
//
//  Created by Anonymous on 2022/8/10.
//

import Foundation
import SwiftUI

enum ARVisTextAlignment: String, Codable, Hashable {
    case center
    case leading
    case trailing

    fileprivate func toSwiftUITextAlignment() -> SwiftUI.TextAlignment {
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

extension SwiftUI.TextAlignment {
    init(_ textAlignment: ARVisTextAlignment?) {
        self = textAlignment?.toSwiftUITextAlignment() ?? .leading
    }
}
