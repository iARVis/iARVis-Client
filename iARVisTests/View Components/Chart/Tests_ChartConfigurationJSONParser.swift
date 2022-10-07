//
//  Tests_ChartConfigurationJSONParser.swift
//  Tests_ChartConfigurationJSONParser
//
//  Created by Anonymous on 2022/8/14.
//

@testable import iARVis
import XCTest
import SwiftyJSON

final class Tests_ChartConfigurationJSONParser: XCTestCase {
    func testParseExample1() {
        let res = ChartConfigurationJSONParser.default.parse(JSON(ChartConfigurationJSONParser.exampleJSONString1.data(using: .utf8)!))
        print(res)
    }
}
