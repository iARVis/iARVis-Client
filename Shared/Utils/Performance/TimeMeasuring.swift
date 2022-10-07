//
//  TimeMeasuring.swift
//  iARVis (iOS)
//
//  Created by Anonymous on 2022/8/28.
//

import Foundation

func timeMeasuring(file: String = #file, line: Int = #line, function: String = #function, _ exec: () -> Void) {
    let start = CFAbsoluteTimeGetCurrent()
    exec()
    let diff = CFAbsoluteTimeGetCurrent() - start
    printDebug(file: file, line: line, function: function, "Took \(diff) seconds")
}

func timeMeasuring<T>(file: String = #file, line: Int = #line, function: String = #function, _ exec: () -> T) -> T {
    let start = CFAbsoluteTimeGetCurrent()
    let result = exec()
    let diff = CFAbsoluteTimeGetCurrent() - start
    printDebug(file: file, line: line, function: function, "Took \(diff) seconds")
    return result
}
