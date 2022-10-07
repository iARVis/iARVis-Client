//
//  ARVisContentMode.swift
//  iARVis (iOS)
//
//  Created by Anonymous on 2022/8/11.
//

import Foundation
import SwiftUI

enum ARVisContentMode: String, Codable, Hashable {
    case fit
    case fill

    fileprivate func toSwiftUIContentMode() -> SwiftUI.ContentMode {
        switch self {
        case .fit:
            return .fit
        case .fill:
            return .fill
        }
    }
}

extension SwiftUI.ContentMode {
    init(_ contentMode: ARVisContentMode) {
        self = contentMode.toSwiftUIContentMode()
    }
}

extension View {
    func aspectRatio(_ aspectRatio: CGFloat? = nil, contentMode: ARVisContentMode) -> some View {
        self.aspectRatio(aspectRatio, contentMode: .init(contentMode))
    }
}
