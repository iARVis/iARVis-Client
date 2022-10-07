//
//  View+Execute.swift
//  iARVis
//
//  Created by Anonymous on 2022/8/16.
//

import Charts
import Foundation
import SwiftUI

func execute(closure: () -> Void) -> some View {
    closure()
    return Color.clear.opacity(0)
}

func executeAsync(closure: @escaping () -> Void) -> some View {
    DispatchQueue.main.async {
        closure()
    }
    return Color.clear.opacity(0)
}

@available(iOS 16, *)
func executeChartContent(closure: () -> Void) -> some ChartContent {
    closure()
    return ChartGroup {}
}
