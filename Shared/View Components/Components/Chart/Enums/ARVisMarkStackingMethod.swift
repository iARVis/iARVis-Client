//
//  ARVisMarkStackingMethod.swift
//  iARVis
//
//  Created by Anonymous on 2022/9/4.
//

import Charts
import Foundation

enum ARVisMarkStackingMethod: String, RawRepresentable, Codable {
    case standard
    case center
    case normalized
    case unstacked
}

@available(iOS 16, *)
extension MarkStackingMethod {
    init(_ stacking: ARVisMarkStackingMethod?) {
        if let stacking = stacking {
            switch stacking {
            case .standard:
                self = .standard
            case .center:
                self = .center
            case .normalized:
                self = .normalized
            case .unstacked:
                self = .unstacked
            }
        } else {
            self = .standard
        }
    }
}
