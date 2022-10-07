//
//  Tests_ViewElementComponent.swift
//  Tests_ViewElementComponent
//
//  Created by Anonymous on 2022/8/14.
//

import Foundation
@testable import iARVis
import XCTest

class Tests_ViewElementComponent: XCTestCase {
    func testViewElementComponentJsonfyVStack() {
        let elementComponent = ViewElementComponent.exampleVStack
        let data = try! JSONEncoder().encode(elementComponent)
        let string = String(data: data, encoding: .utf8)!
        printDebug(string)
        let target = """
        {"vStack":{"elements":[]}}
        """
        XCTAssertEqual(string, target)
    }

    func testViewElementComponentJsonfyArtworkTimeSheetTooltip() {
        let elementComponent = ViewElementComponent.exampleArtworkTimeSheetTooltip
        let data = try! JSONEncoder().encode(elementComponent)
        let string = String(data: data, encoding: .utf8)!
        printDebug(string)
        let target = """
        {"vStack":{"elements":[{"text":{"content":"Alexandra Daveluy"}},{"text":{"content":"Alexandra Daveluy, who is James Ensor's niece, inherited the painting from James Ensor."}},{"text":{"content":"1949-01-01 to 1950-01-01"}}]}}
        """
        XCTAssertEqual(string, target)
    }

    func testViewElementComponentArtworkTimeSheetTooltip() {
        let jsonData = """
        {
          "vStack": {
            "elements": [
              {
                "text": {
                  "content": "Alexandra Daveluy"
                }
              },
              {
                "text": {
                  "content": "Alexandra Daveluy, who is James Ensor's niece, inherited the painting from James Ensor."
                }
              },
              {
                "text": {
                  "content": "1949-01-01 to 1950-01-01"
                }
              }
            ]
          }
        }
        """.data(using: .utf8)!

        let viewElementComponent = try! JSONDecoder().decode(ViewElementComponent.self, from: jsonData)
        XCTAssertEqual(viewElementComponent, .exampleArtworkTimeSheetTooltip)
    }

    func testViewElementComponentChartConfiguration() {
        XCTAssertNoThrow(ViewElementComponent.example1_ProvenanceChartViewElementComponent)
    }
}
