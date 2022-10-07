//
//  Debug.swift
//  iARVis (iOS)
//
//  Created by Anonymous on 2022/7/31.
//

import Foundation

// 📗
// 📘
// 📔
enum DebugLogLevel: CustomStringConvertible {
    case normal
    case warning
    case error

    var description: String {
        switch self {
        case .normal:
            return "📓"
        case .warning:
            return "📙"
        case .error:
            return "📕"
        }
    }
}

private let debugLogPrefix = "\t[Debug log] "

func printDebug(level: DebugLogLevel = .normal, file: String = #file, line: Int = #line, function: String = #function, _ message: CustomStringConvertible = "") {
    #if DEBUG
        let processedMessage = message.description.split(separator: "\n").enumerated().map { $0 == 0 ? $1 : "\t\t\t\t\($1)" }.joined(separator: "\n")
        print("\(level)\(debugLogPrefix)\(URL(fileURLWithPath: file).lastPathComponent)(line \(line)), `\(function)`:\n\(debugLogPrefix)\(processedMessage)")
    #endif
}

func fatalErrorDebug(file: String = #file, line: Int = #line, function: String = #function, _ message: CustomStringConvertible = "") {
    #if DEBUG
    let processedMessage = message.description.split(separator: "\n").enumerated().map { $0 == 0 ? $1 : "\t\t\t\t\($1)" }.joined(separator: "\n")
        fatalError("\(DebugLogLevel.error)\(debugLogPrefix)\(URL(fileURLWithPath: file).lastPathComponent)(line \(line)), `\(function)`:\n\(debugLogPrefix)\(processedMessage)")
    #endif
}

func assertDebug(_ condition: @autoclosure () -> Bool, _ message: @autoclosure () -> String = String(), file: StaticString = #file, line: UInt = #line) {
    #if DEBUG
        assert(condition(), message(), file: file, line: line)
    #endif
}

func debugExecution(_ body: () -> Void) {
    #if DEBUG
        body()
    #endif
}
