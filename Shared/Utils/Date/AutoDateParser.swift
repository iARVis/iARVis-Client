//
//  AutoDateParser.swift
//  iARVis (iOS)
//
//  Created by Anonymous on 2022/9/4.
//

import Foundation

class AutoDateParser {
    static let shared = AutoDateParser()

    private static let iARVisAutoFormats: [String] = [
        "yyyy-MM-dd'T'HH:mm:ssZZZZZ",
        "yyyy'-'MM'-'dd'T'HH':'mm':'ssZ",
        "yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'SSSZ",
        "yyyy-MM-dd'T'HH:mm:ss.SSSZ",
        "yyyy-MM-dd HH:mm:ss",
        "yyyy-MM-dd HH:mm",
        "yyyy-MM-dd",
        "h:mm:ss A",
        "h:mm A",
        "MM/dd/yyyy",
        "MMMM d, yyyy",
        "MMMM d, yyyy LT",
        "dddd, MMMM D, yyyy LT",
        "yyyyyy-MM-dd",
        "yyyy-MM-dd",
        "yyyy-'W'ww-E",
        "GGGG-'['W']'ww-E",
        "yyyy-'W'ww",
        "GGGG-'['W']'ww",
        "yyyy'W'ww",
        "yyyy-ddd",
        "HH:mm:ss.SSSS",
        "HH:mm:ss",
        "HH:mm",
    ]

    private var formatters: [DateFormatter] = AutoDateParser.iARVisAutoFormats.map { format in
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter
    }
    
    private var cachedCustomFormatters: [String:DateFormatter] = [:]

    func parse(_ string: String) -> Date? {
        for formatter in formatters {
            if let date = formatter.date(from: string) {
                return date
            }
        }
        return nil
    }
    
    func parse(_ string: String, format: String) -> Date? {
        var formatter: DateFormatter! = cachedCustomFormatters[format]
        if formatter == nil {
            let _formatter = DateFormatter()
            _formatter.dateFormat = format
            cachedCustomFormatters[format] = _formatter
            formatter = _formatter
        }
        
        return formatter.date(from: string)
    }
}
