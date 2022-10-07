//
//  ARVisPlottableValueFieldPair.swift
//  iARVis
//
//  Created by Anonymous on 2022/8/14.
//

import Charts
import Foundation
import SwiftyJSON

enum ARVisPlottableValueTypeInformation: Hashable {
    case date(format: String)
    
    static func extract(from json: JSON?) -> ARVisPlottableValueTypeInformation? {
        if let json = json {
            if json["type"].string == "date",
               let dateFormat = json["dateFormat"].string {
                return .date(format: dateFormat)
            }
        }
        return nil
    }
}

@available(iOS 16, *)
struct ARVisPlottableValueFieldPair: Hashable {
    var label: String
    var field: String
//    TODO: var unit: ... to support date unit

    static func value(_ label: String, _ field: String) -> Self {
        ARVisPlottableValueFieldPair(label: label, field: field)
    }

    static func value(_ field: String) -> Self {
        ARVisPlottableValueFieldPair(label: field, field: field)
    }
    
    func plottableInt(_ any: Any) -> PlottableValue<Int>? {
        if let int = any as? Int {
            return PlottableValue.value(label, int)
        }
        return nil
    }

    func plottableDouble(_ any: Any) -> PlottableValue<Double>? {
        if let double = any as? Double {
            return PlottableValue.value(label, double)
        }
        return nil
    }

    func plottableDate(_ any: Any) -> PlottableValue<Date>? {
        if let date = any as? Date {
            return PlottableValue.value(label, date)
        }
        return nil
    }

    func plottableString(_ any: Any) -> PlottableValue<String>? {
        if let string = any as? String {
            return PlottableValue.value(label, string)
        }
        return nil
    }
}

extension JSON {
    var strictInt: Int? {
        if let number = number,
           let int = number.toSwiftType() as? Int {
            return int
        }
        return nil
    }

    var strictDouble: Double? {
        if let number = number,
           let double = number.toSwiftType() as? Double {
            return double
        }
        return nil
    }
}
