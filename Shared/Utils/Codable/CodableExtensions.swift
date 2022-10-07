//
//  CodableExtensions.swift
//  mastering-codable
//
//  Created by Anonymous on 09/05/21.
//

import Foundation

struct JSONCodingKeys: CodingKey {
    var stringValue: String
    var intValue: Int?

    init?(stringValue: String) {
        self.stringValue = stringValue
    }

    init?(intValue: Int) {
        self.init(stringValue: "\(intValue)")
        self.intValue = intValue
    }
}

// MARK: - Decoding Extensions

extension KeyedDecodingContainer {
    func decode(_ type: [String: Any].Type, forKey key: K) throws -> [String: Any] {
        let container = try nestedContainer(keyedBy: JSONCodingKeys.self, forKey: key)
        return try container.decode(type)
    }

    func decode(_ type: [[String: Any]].Type, forKey key: K) throws -> [[String: Any]] {
        var container = try nestedUnkeyedContainer(forKey: key)
        if let decodedData = try container.decode([Any].self) as? [[String: Any]] {
            return decodedData
        } else {
            return []
        }
    }

    func decodeIfPresent(_ type: [String: Any].Type, forKey key: K) throws -> [String: Any]? {
        guard contains(key) else {
            return nil
        }
        guard try decodeNil(forKey: key) == false else {
            return nil
        }
        return try decode(type, forKey: key)
    }

    func decode(_ type: [Any].Type, forKey key: K) throws -> [Any] {
        var container = try nestedUnkeyedContainer(forKey: key)
        return try container.decode(type)
    }

    func decodeIfPresent(_ type: [Any].Type, forKey key: K) throws -> [Any]? {
        guard contains(key) else {
            return nil
        }
        guard try decodeNil(forKey: key) == false else {
            return nil
        }
        return try decode(type, forKey: key)
    }

    func decode(_ type: [String: Any].Type) throws -> [String: Any] {
        var dictionary = [String: Any]()
        for key in allKeys {
            if let boolValue = try? decode(Bool.self, forKey: key) {
                dictionary[key.stringValue] = boolValue
            } else if let stringValue = try? decode(String.self, forKey: key) {
                dictionary[key.stringValue] = stringValue
            } else if let intValue = try? decode(Int.self, forKey: key) {
                dictionary[key.stringValue] = intValue
            } else if let doubleValue = try? decode(Double.self, forKey: key) {
                dictionary[key.stringValue] = doubleValue
            } else if let nestedDictionary = try? decode([String: Any].self, forKey: key) {
                dictionary[key.stringValue] = nestedDictionary
            } else if let nestedArray = try? decode([Any].self, forKey: key) {
                dictionary[key.stringValue] = nestedArray
            }
        }
        return dictionary
    }
}

extension UnkeyedDecodingContainer {
    mutating func decode(_ type: [Any].Type) throws -> [Any] {
        var array: [Any] = []
        while isAtEnd == false {
            // See if the current value in the JSON array is `null` first and prevent infinite recursion with nested arrays.
            if try decodeNil() {
                continue
            } else if let value = try? decode(Bool.self) {
                array.append(value)
            } else if let value = try? decode(Double.self) {
                array.append(value)
            } else if let value = try? decode(String.self) {
                array.append(value)
            } else if let nestedDictionary = try? decode([String: Any].self) {
                array.append(nestedDictionary)
            } else if let nestedArray = try? decode([Any].self) {
                array.append(nestedArray)
            }
        }
        return array
    }

    mutating func decode(_ type: [String: Any].Type) throws -> [String: Any] {
        let nestedContainer = try self.nestedContainer(keyedBy: JSONCodingKeys.self)
        return try nestedContainer.decode(type)
    }
}

// MARK: - Encoding Extensions

extension KeyedEncodingContainer {
    mutating func encodeIfPresent(_ value: [String: Any]?, forKey key: KeyedEncodingContainer<K>.Key) throws {
        guard let safeValue = value, !safeValue.isEmpty else {
            return
        }
        var container = nestedContainer(keyedBy: JSONCodingKeys.self, forKey: key)
        for item in safeValue {
            if let nsNumberVal = item.value as? NSNumber {
                if let val = nsNumberVal.toSwiftType() as? Int {
                    try container.encodeIfPresent(val, forKey: JSONCodingKeys(stringValue: item.key)!)
                } else if let val = nsNumberVal.toSwiftType() as? Double {
                    try container.encodeIfPresent(val, forKey: JSONCodingKeys(stringValue: item.key)!)
                } else if let val = nsNumberVal.toSwiftType() as? Float {
                    try container.encodeIfPresent(val, forKey: JSONCodingKeys(stringValue: item.key)!)
                } else if let val = nsNumberVal.toSwiftType() as? Bool {
                    try container.encodeIfPresent(val, forKey: JSONCodingKeys(stringValue: item.key)!)
                }
            } else if let val = item.value as? String {
                try container.encodeIfPresent(val, forKey: JSONCodingKeys(stringValue: item.key)!)
            } else if let val = item.value as? [Any] {
                try container.encodeIfPresent(val, forKey: JSONCodingKeys(stringValue: item.key)!)
            } else if let val = item.value as? [String: Any] {
                try container.encodeIfPresent(val, forKey: JSONCodingKeys(stringValue: item.key)!)
            }
        }
    }

    mutating func encodeIfPresent(_ value: [Any]?, forKey key: KeyedEncodingContainer<K>.Key) throws {
        guard let safeValue = value else {
            return
        }
        if let val = safeValue as? [Int] {
            try encodeIfPresent(val, forKey: key)
        } else if let val = safeValue as? [String] {
            try encodeIfPresent(val, forKey: key)
        } else if let val = safeValue as? [Double] {
            try encodeIfPresent(val, forKey: key)
        } else if let val = safeValue as? [Float] {
            try encodeIfPresent(val, forKey: key)
        } else if let val = safeValue as? [Bool] {
            try encodeIfPresent(val, forKey: key)
        } else if let val = value as? [[String: Any]] {
            var container = nestedUnkeyedContainer(forKey: key)
            try container.encode(contentsOf: val)
        }
    }
}

extension UnkeyedEncodingContainer {
    mutating func encode(contentsOf sequence: [[String: Any]]) throws {
        for dict in sequence {
            try encodeIfPresent(dict)
        }
    }

    mutating func encodeIfPresent(_ value: [String: Any]) throws {
        var container = nestedContainer(keyedBy: JSONCodingKeys.self)
        for item in value {
            if let nsNumberVal = item.value as? NSNumber {
                if let val = nsNumberVal.toSwiftType() as? Int {
                    try container.encodeIfPresent(val, forKey: JSONCodingKeys(stringValue: item.key)!)
                } else if let val = nsNumberVal.toSwiftType() as? Double {
                    try container.encodeIfPresent(val, forKey: JSONCodingKeys(stringValue: item.key)!)
                } else if let val = nsNumberVal.toSwiftType() as? Float {
                    try container.encodeIfPresent(val, forKey: JSONCodingKeys(stringValue: item.key)!)
                } else if let val = nsNumberVal.toSwiftType() as? Bool {
                    try container.encodeIfPresent(val, forKey: JSONCodingKeys(stringValue: item.key)!)
                }
            } else if let val = item.value as? String {
                try container.encodeIfPresent(val, forKey: JSONCodingKeys(stringValue: item.key)!)
            } else if let val = item.value as? [Any] {
                try container.encodeIfPresent(val, forKey: JSONCodingKeys(stringValue: item.key)!)
            } else if let val = item.value as? [String: Any] {
                try container.encodeIfPresent(val, forKey: JSONCodingKeys(stringValue: item.key)!)
            }
        }
    }
}

// MARK: - Extra extensions for managing data easily

extension Decodable {
    init?(dictionary: [String: Any]) {
        do {
            let data = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
            if let decodedData = Utility.decode(Self.self, from: data) {
                self = decodedData
            } else {
                return nil
            }
        } catch _ {
            return nil
        }
    }
}

extension Encodable {
    var dictionary: [String: Any]? {
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }

    var prettyJSON: String {
        if let data = try? JSONEncoder().encode(self) {
            return String(data: data, encoding: .utf8) ?? "{}"
        }
        return "{}"
    }
}

extension Dictionary {
    var prettyJSON: String {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: [.prettyPrinted])
            guard let jsonString = String(data: jsonData, encoding: String.Encoding.utf8) else {
                print("Can't create string with data.")
                return "{}"
            }
            return jsonString
        } catch let parseError {
            print("json serialization error: \(parseError)")
            return "{}"
        }
    }
}
