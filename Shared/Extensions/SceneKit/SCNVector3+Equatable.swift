//
//  SCNVector3+Equatable.swift
//  iARVis
//
//  Created by Anonymous on 2022/9/3.
//

import SceneKit

extension SCNVector3: Equatable {
    public static func == (lhs: SCNVector3, rhs: SCNVector3) -> Bool {
        lhs.x == rhs.x &&
        lhs.y == rhs.y &&
        lhs.z == rhs.z
    }
}
