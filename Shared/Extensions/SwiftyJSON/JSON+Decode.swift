//
//  JSON+Decode.swift
//  iARVis
//
//  Created by Anonymous on 2022/8/14.
//

import Foundation
import SwiftyJSON

extension JSON {
    func decode<T>(_ type: T.Type) -> T? where T: Decodable {
        if let data = try? rawData() {
            #if DEBUG
                do {
                    return try JSONDecoder().decode(type, from: data)
                } catch {
                    print(String(data: data, encoding: .utf8) ?? "Failed to parse.")
                    _ = try! JSONDecoder().decode(type, from: data)
                }
            #else
                return try? JSONDecoder().decode(type, from: data)
            #endif
        }
        return nil
    }
}
