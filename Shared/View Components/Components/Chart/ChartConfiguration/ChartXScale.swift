//
//  ChartXScale.swift
//  iARVis
//
//  Created by Anonymous on 2022/8/27.
//

import Foundation
import SwiftyJSON

struct ChartXScale: Codable, Hashable {
    var includingZero: Bool?
    var domain: [JSON]?
}

struct ChartYScale: Codable, Hashable {
    var includingZero: Bool?
    var domain: [JSON]?
}
