//
//  ARVisConditionalAnnotation.swift
//  iARVis
//
//  Created by Anonymous on 2022/8/31.
//

import Foundation
import SwiftyJSON

struct ARVisConditionalAnnotation: Codable, Hashable {
    var field: String
    var value: JSON
    var annotation: ARVisAnnotation
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(field)
        if let int = value.strictInt {
            hasher.combine(int)
        } else if let double = value.strictDouble {
            hasher.combine(double)
        } else if let date = value.date {
            hasher.combine(date)
        } else if let string = value.string {
            hasher.combine(string)
        }
        hasher.combine(annotation)
    }
}
