//
//  NSNumber+Type.swift
//  iARVis
//
//  Created by Anonymous on 2022/8/29.
//

import Foundation

extension NSNumber {
    func toSwiftType() -> Any {
        switch CFNumberGetType(self as CFNumber) {
        case .charType:
            return boolValue
        case .sInt8Type, .sInt16Type, .sInt32Type, .sInt64Type, .shortType, .intType, .longType, .longLongType, .cfIndexType, .nsIntegerType:
            return intValue
        case .float32Type, .float64Type, .floatType, .doubleType, .cgFloatType:
            return doubleValue
        @unknown default:
            return self
        }
    }
}
