//
//  ARVisInterpolationMethod.swift
//  iARVis
//
//  Created by Anonymous on 2022/8/23.
//

import Charts
import Foundation

enum ARVisInterpolationMethod: String, RawRepresentable, Codable, CaseIterable, Identifiable, Hashable {
    case linear
    case cardinal
    
    var id: Self {
        self
    }
}

@available(iOS 16, *)
extension InterpolationMethod {
    init(_ interpolationMethod: ARVisInterpolationMethod) {
        switch interpolationMethod {
        case .linear:
            self = .linear
        case .cardinal:
            self = .cardinal
        }
    }
}
