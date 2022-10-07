//
//  ChartAxisMarks.swift
//  iARVis
//
//  Created by Anonymous on 2022/8/27.
//

import Charts
import Foundation

struct ChartAxisMarks: Codable, Hashable {
    var axisMarksValues: AxisMarksValues
    var axisValueLabel: AxisMarksValueLabel

    enum AxisMarksValues: Codable, Hashable {
        case strideByDateComponent(component: Component, count: Int = 1)

        public enum Component: String, RawRepresentable, Codable, Equatable {
            case era
            case year
            case month
            case day
            case hour
            case minute
            case second
            case weekday
            case weekdayOrdinal
            case quarter
            case weekOfMonth
            case weekOfYear
            case yearForWeekOfYear
            case nanosecond
            case calendar
            case timeZone
        }
    }

    struct AxisMarksValueLabel: Codable, Hashable {
        var format: Format

        enum Format: Codable, Hashable {
            case year(format: YearFormat = .defaultDigits)

            enum YearFormat: String, RawRepresentable, Codable, Equatable, CaseIterable {
                case defaultDigits
            }
        }
    }
}

extension Calendar.Component {
    init(_ component: ChartAxisMarks.AxisMarksValues.Component) {
        switch component {
        case .era:
            self = .era
        case .year:
            self = .year
        case .month:
            self = .month
        case .day:
            self = .day
        case .hour:
            self = .hour
        case .minute:
            self = .minute
        case .second:
            self = .second
        case .weekday:
            self = .weekday
        case .weekdayOrdinal:
            self = .weekdayOrdinal
        case .quarter:
            self = .quarter
        case .weekOfMonth:
            self = .weekOfMonth
        case .weekOfYear:
            self = .weekOfYear
        case .yearForWeekOfYear:
            self = .yearForWeekOfYear
        case .nanosecond:
            self = .nanosecond
        case .calendar:
            self = .calendar
        case .timeZone:
            self = .timeZone
        }
    }
}
