//
//  View+if.swift
//  iARVis
//
//  Created by Anonymous on 2022/8/14.
//

import Charts
import SwiftUI

extension View {
    @ViewBuilder
    func `if`<Content: View>(_ condition: @autoclosure () -> Bool, @ViewBuilder transform: (Self) -> Content) -> some View {
        if condition() {
            transform(self)
        } else {
            self
        }
    }
}

@available(iOS 16, *)
extension ChartContent {
    @ChartContentBuilder
    func `if`<Content: ChartContent>(_ condition: @autoclosure () -> Bool, @ChartContentBuilder transform: (Self) -> Content) -> some ChartContent {
        if condition() {
            transform(self)
        } else {
            self
        }
    }
}
