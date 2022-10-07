//
//  ChartGroup.swift
//  iARVis
//
//  Created by Anonymous on 2022/9/2.
//

import Foundation
import Charts

@available(iOS 16, *)
struct ChartGroup<Content: ChartContent>: ChartContent {
    @ChartContentBuilder
    let content: () -> Content

    var body: some ChartContent {
        content()
    }
}
