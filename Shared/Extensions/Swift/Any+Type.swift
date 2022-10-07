//
//  Any+Type.swift
//  iARVis
//
//  Created by Anonymous on 2022/9/2.
//

import Foundation

func toSwiftType(_ any: Any) -> Any {
    if let nsNumber = any as? NSNumber {
        return nsNumber.toSwiftType()
    } else if let string = any as? String, let date =  AutoDateParser.shared.parse(string) {
        return date
    } else {
        return any
    }
}
