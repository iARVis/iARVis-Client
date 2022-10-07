//
//  KeyedCodable.swift
//  iARVis
//
//  Created by Anonymous on 2022/8/28.
//

import Foundation

protocol KeyedCodableSource {
    static func encode(_: Self) -> [String: Any]
    static func decode(_: [String: Any]) -> Self?
}

@propertyWrapper
struct KeyedCodable<T: KeyedCodableSource>: Codable {
    enum KeyedCodableError: Error {
        case failed
    }

    var wrappedValue: T?
    
    init(wrappedValue: T? = nil) {
        self.wrappedValue = wrappedValue
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: JSONCodingKeys.self)
        let json = try container.decode([String: Any].self)
        if let decoded = T.decode(json) {
            wrappedValue = decoded
        } else {
            self.wrappedValue = nil
        }
    }

    func encode(to encoder: Encoder) throws {}
}

extension KeyedCodable: Equatable where T: Equatable {}
