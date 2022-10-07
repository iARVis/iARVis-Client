//
//  TableConfiguration.swift
//  iARVis
//
//  Created by Anonymous on 2022/8/20.
//

import Foundation

struct TableConfiguration: Codable, Hashable {
    var tableData: TableData
    var orientation: ARVisTableViewOrientation
}
