//
//  Date.swift
//  iARVis
//
//  Created by Anonymous on 2022/8/14.
//

import Foundation

func date(year: Int, month: Int, day: Int = 1) -> Date {
    var calendar = Calendar.current
    calendar.timeZone = .init(identifier: "UTC")!
    return calendar.date(from: DateComponents(year: year, month: month, day: day)) ?? Date()
}
