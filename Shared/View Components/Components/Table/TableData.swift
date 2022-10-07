//
//  TableData.swift
//  iARVis
//
//  Created by Anonymous on 2022/8/12.
//

import Foundation
import SwiftyJSON

struct TableData: Codable, Hashable {
    let data: JSON
    let titles: [String]
    let length: Int
    
    init(data: JSON, titles: [String]? = nil) {

        if let titles = titles {
            self.titles = titles
        } else {
            if let keys = data.dictionary?.keys {
                self.titles = Array(keys).sorted()
            } else {
                self.titles = []
            }
        }
        
        var processedData = data
        for title in self.titles {
            if let _ = data[title].array {
                continue
            } else if data[title] != .null {
                processedData[title] = [data[title]]
            }
        }
        self.data = processedData

        var maxLength = 0
        for title in self.titles {
            if let array = self.data[title].array {
                maxLength = max(maxLength, array.count)
            }
        }
        length = maxLength
    }
}

extension TableData {
    static let example1 = TableData(data: [
        "Given Name": ["Juan", "Mei", "Tom", "Gita"],
        "Family Name": ["Chavez", "Chen", "Clark", "Kumar"],
        "E-Mail Address": ["juanchavez@icloud.com", "meichen@icloud.com", "tomclark@icloud.com", "gitakumar@icloud.com"],
        "Age": [21, 22, 29, 32],
        "Description": ["No description", "No description", "[Personal homepage](https://google.com)", "No description"],
    ])
}
