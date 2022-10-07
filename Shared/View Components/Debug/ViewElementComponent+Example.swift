//
//  ViewElementComponent+Example.swift
//  iARVis
//
//  Created by Anonymous on 2022/8/11.
//
import Foundation

extension ViewElementComponent {
    static let example1: ViewElementComponent = {
        .vStack(elements: [
        ])
    }()

    static let exampleVStack: ViewElementComponent = {
        .vStack(elements: [
        ])
    }()

    static let exampleArtworkTimeSheetTooltip: ViewElementComponent = {
        .vStack(elements: [
            .text(content: "Alexandra Daveluy"),
            .text(content: "Alexandra Daveluy, who is James Ensor's niece, inherited the painting from James Ensor."),
            .text(content: "1949-01-01 to 1950-01-01"),
        ])
    }()
}
