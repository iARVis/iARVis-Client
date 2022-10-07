//
//  SCNVector3+Hashable.swift
//  iARVis (iOS)
//
//  Created by Anonymous on 2022/9/28.
//

import Foundation
import SceneKit

extension SCNVector3: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
        hasher.combine(z)
    }
}
