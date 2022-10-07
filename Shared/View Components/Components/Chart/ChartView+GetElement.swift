//
//  ChartView+GetElement.swift
//  iARVis
//
//  Created by Anonymous on 2022/8/15.
//

import Charts
import Foundation
import SwiftUI
import SwiftyJSON

enum GetElementMode {
    case accurate
    case nearest
}

@available(iOS 16, *)
func getElementInRangeX(proxy: ChartProxy, location: CGPoint, geo: GeometryProxy, chartData: ChartDataItem?, xStartField: String, xEndField: String, mode: GetElementMode = .accurate) -> [JSON] {
    guard let chartData = chartData else { return [] }
    let relativeX = location.x - geo[proxy.plotAreaFrame].origin.x
    // Int, Double, Date, String(only equal)
    if chartData.data[xStartField].array?[safe: 0]?.strictInt != nil {
        if let intValue: Int = proxy.value(atX: relativeX) {
            switch mode {
            case .accurate:
                for i in 0 ..< chartData.length {
                    if let xStartInt = chartData.data[xStartField].array?[safe: i]?.int,
                       let xEndInt = chartData.data[xEndField].array?[safe: i]?.int {
                        if intValue >= xStartInt, intValue <= xEndInt {
                            return [chartData.datum(at: i)]
                        }
                    }
                }
            case .nearest:
                var nearestItems: [JSON] = []
                var minDiff: Int = .max
                for i in 0 ..< chartData.length {
                    if let xStartInt = chartData.data[xStartField].array?[safe: i]?.int {
                        if let positionX = proxy.position(forX: xStartInt) {
                            let diff = abs(xStartInt - intValue)
                            if diff == minDiff {
                                nearestItems.append(chartData.datum(at: i))
                            } else if diff < minDiff, abs(positionX - relativeX) < 50.0 {
                                nearestItems = [chartData.datum(at: i)]
                                minDiff = diff
                            }
                        }
                    }
                }
                return nearestItems
            }
        }
    } else if chartData.data[xStartField].array?[safe: 0]?.strictDouble != nil {
        if let doubleValue: Double = proxy.value(atX: relativeX) {
            switch mode {
            case .accurate:
                for i in 0 ..< chartData.length {
                    if let xStartDouble = chartData.data[xStartField].array?[safe: i]?.double,
                       let xEndDouble = chartData.data[xEndField].array?[safe: i]?.double {
                        if doubleValue >= xStartDouble, doubleValue <= xEndDouble {
                            return [chartData.datum(at: i)]
                        }
                    }
                }
            case .nearest:
                var nearestItems: [JSON] = []
                var minDiff: Double = .infinity
                for i in 0 ..< chartData.length {
                    if let xStartDouble = chartData.data[xStartField].array?[safe: i]?.double {
                        if let positionX = proxy.position(forX: xStartDouble) {
                            let diff = abs(xStartDouble - doubleValue)
                            if diff == minDiff {
                                nearestItems.append(chartData.datum(at: i))
                            } else if diff < minDiff, abs(positionX - relativeX) < 50.0 {
                                nearestItems = [chartData.datum(at: i)]
                                minDiff = diff
                            }
                        }
                    }
                }
                return nearestItems
            }
        }
    } else if chartData.data[xStartField].array?[safe: 0]?.date != nil {
        if let dateValue: Date = proxy.value(atX: relativeX) {
            switch mode {
            case .accurate:
                for i in 0 ..< chartData.length {
                    if let xStartDate = chartData.data[xStartField].array?[safe: i]?.date,
                       let xEndDate = chartData.data[xEndField].array?[safe: i]?.date {
                        if dateValue >= xStartDate, dateValue <= xEndDate {
                            return [chartData.datum(at: i)]
                        }
                    }
                }
            case .nearest:
                var nearestItems: [JSON] = []
                var minDiff: TimeInterval = .infinity
                for i in 0 ..< chartData.length {
                    if let xStartDate = chartData.data[xStartField].array?[safe: i]?.date {
                        if let positionX = proxy.position(forX: xStartDate) {
                            let diff = abs(xStartDate.distance(to: dateValue))
                            if diff == minDiff {
                                nearestItems.append(chartData.datum(at: i))
                            } else if diff < minDiff, abs(positionX - relativeX) < 50.0 {
                                nearestItems = [chartData.datum(at: i)]
                                minDiff = diff
                            }
                        }
                    }
                }
                return nearestItems
            }
        }
    } else if chartData.data[xStartField].array?[safe: 0]?.string != nil {
        if let stringValue: String = proxy.value(atX: relativeX) {
            for i in 0 ..< chartData.length {
                if stringValue == chartData.data[xStartField].array?[safe: i]?.string,
                   stringValue == chartData.data[xEndField].array?[safe: i]?.string {
                    return [chartData.datum(at: i)]
                }
            }
        }
    }

    return []
}

@available(iOS 16, *)
func getElementInRangeY(proxy: ChartProxy, location: CGPoint, geo: GeometryProxy, chartData: ChartDataItem?, yStartField: String, yEndField: String, mode: GetElementMode = .accurate) -> [JSON] {
    guard let chartData = chartData else { return [] }
    let relativeY = location.y - geo[proxy.plotAreaFrame].origin.y
    // Int, Double, Date, String(only equal)
    if chartData.data[yStartField].array?[safe: 0]?.strictInt != nil {
        if let intValue: Int = proxy.value(atY: relativeY) {
            switch mode {
            case .accurate:
                for i in 0 ..< chartData.length {
                    if let yStartInt = chartData.data[yStartField].array?[safe: i]?.int,
                       let yEndInt = chartData.data[yEndField].array?[safe: i]?.int {
                        if intValue >= yStartInt, intValue <= yEndInt {
                            return [chartData.datum(at: i)]
                        }
                    }
                }
            case .nearest:
                var nearestItems: [JSON] = []
                var minDiff: Int = .max
                for i in 0 ..< chartData.length {
                    if let yStartInt = chartData.data[yStartField].array?[safe: i]?.int {
                        if let positionY = proxy.position(forY: yStartInt) {
                            let diff = abs(yStartInt - intValue)
                            if diff == minDiff {
                                nearestItems.append(chartData.datum(at: i))
                            } else if diff < minDiff, abs(positionY - relativeY) < 50.0 {
                                nearestItems = [chartData.datum(at: i)]
                                minDiff = diff
                            }
                        }
                    }
                }
                return nearestItems
            }
        }
    } else if chartData.data[yStartField].array?[safe: 0]?.strictDouble != nil {
        if let doubleValue: Double = proxy.value(atY: relativeY) {
            switch mode {
            case .accurate:
                for i in 0 ..< chartData.length {
                    if let yStartDouble = chartData.data[yStartField].array?[safe: i]?.double,
                       let yEndDouble = chartData.data[yEndField].array?[safe: i]?.double {
                        if doubleValue >= yStartDouble, doubleValue <= yEndDouble {
                            return [chartData.datum(at: i)]
                        }
                    }
                }
            case .nearest:
                var nearestItems: [JSON] = []
                var minDiff: Double = .infinity
                for i in 0 ..< chartData.length {
                    if let yStartDouble = chartData.data[yStartField].array?[safe: i]?.double {
                        if let positionY = proxy.position(forY: yStartDouble) {
                            let diff = abs(yStartDouble - doubleValue)
                            if diff == minDiff {
                                nearestItems.append(chartData.datum(at: i))
                            } else if diff < minDiff, abs(positionY - relativeY) < 50.0 {
                                nearestItems = [chartData.datum(at: i)]
                                minDiff = diff
                            }
                        }
                    }
                }
                return nearestItems
            }
        }
    } else if chartData.data[yStartField].array?[safe: 0]?.date != nil {
        if let dateValue: Date = proxy.value(atY: relativeY) {
            switch mode {
            case .accurate:
                for i in 0 ..< chartData.length {
                    if let yStartDate = chartData.data[yStartField].array?[safe: i]?.date,
                       let yEndDate = chartData.data[yEndField].array?[safe: i]?.date {
                        if dateValue >= yStartDate, dateValue <= yEndDate {
                            return [chartData.datum(at: i)]
                        }
                    }
                }
            case .nearest:
                var nearestItems: [JSON] = []
                var minDiff: TimeInterval = .infinity
                for i in 0 ..< chartData.length {
                    if let yStartDate = chartData.data[yStartField].array?[safe: i]?.date {
                        if let positionY = proxy.position(forY: yStartDate) {
                            let diff = abs(yStartDate.distance(to: dateValue))
                            if diff == minDiff {
                                nearestItems.append(chartData.datum(at: i))
                            } else if diff < minDiff, abs(positionY - relativeY) < 50.0 {
                                nearestItems = [chartData.datum(at: i)]
                                minDiff = diff
                            }
                        }
                    }
                }
                return nearestItems
            }
        }
    } else if chartData.data[yStartField].array?[safe: 0]?.string != nil {
        if let stringValue: String = proxy.value(atY: relativeY) {
            for i in 0 ..< chartData.length {
                if stringValue == chartData.data[yStartField].array?[safe: i]?.string,
                   stringValue == chartData.data[yEndField].array?[safe: i]?.string {
                    return [chartData.datum(at: i)]
                }
            }
        }
    }
    return []
}

@available(iOS 16, *)
func getElementInXY(proxy: ChartProxy, location: CGPoint, geo: GeometryProxy, chartData: ChartDataItem?, xField: String, yField: String) -> JSON? {
    guard let chartData = chartData else { return nil }
    let relativeX = location.x - geo[proxy.plotAreaFrame].origin.x
    let relativeY = location.y - geo[proxy.plotAreaFrame].origin.y
    // Int, Int; Int, Double; Int, Date; Int, String;
    // Double, Int; Double, Double; Double, Date; Double, String;
    // Date, Int; Date, Double; Date, Date; Date, String;
    // String, Int; String, Double; String, Date; String, String;
    if chartData.data[xField].array?[safe: 0]?.int != nil {
        if chartData.data[yField].array?[safe: 0]?.int != nil {
            if let (xIntValue, yIntValue) = proxy.value(at: CGPoint(x: relativeX, y: relativeY), as: (Int, Int).self) {
                for i in 0 ..< chartData.length {
                    if xIntValue == chartData.data[xField].array?[safe: i]?.int,
                       yIntValue == chartData.data[yField].array?[safe: i]?.int {
                        return chartData.datum(at: i)
                    }
                }
            }
        } else if chartData.data[yField].array?[safe: 0]?.double != nil {
            if let (xIntValue, yDoubleValue) = proxy.value(at: CGPoint(x: relativeX, y: relativeY), as: (Int, Double).self) {
                for i in 0 ..< chartData.length {
                    if xIntValue == chartData.data[xField].array?[safe: i]?.int,
                       yDoubleValue == chartData.data[yField].array?[safe: i]?.double {
                        return chartData.datum(at: i)
                    }
                }
            }
        } else if chartData.data[yField].array?[safe: 0]?.date != nil {
            if let (xIntValue, yDateValue) = proxy.value(at: CGPoint(x: relativeX, y: relativeY), as: (Int, Date).self) {
                for i in 0 ..< chartData.length {
                    if xIntValue == chartData.data[xField].array?[safe: i]?.int,
                       yDateValue == chartData.data[yField].array?[safe: i]?.date {
                        return chartData.datum(at: i)
                    }
                }
            }
        } else if chartData.data[yField].array?[safe: 0]?.string != nil {
            if let (xIntValue, yStringValue) = proxy.value(at: CGPoint(x: relativeX, y: relativeY), as: (Int, String).self) {
                for i in 0 ..< chartData.length {
                    if xIntValue == chartData.data[xField].array?[safe: i]?.int,
                       yStringValue == chartData.data[yField].array?[safe: i]?.string {
                        return chartData.datum(at: i)
                    }
                }
            }
        }
    } else if chartData.data[xField].array?[safe: 0]?.double != nil {
        if chartData.data[yField].array?[safe: 0]?.int != nil {
            if let (xDoubleValue, yIntValue) = proxy.value(at: CGPoint(x: relativeX, y: relativeY), as: (Double, Int).self) {
                for i in 0 ..< chartData.length {
                    if xDoubleValue == chartData.data[xField].array?[safe: i]?.double,
                       yIntValue == chartData.data[yField].array?[safe: i]?.int {
                        return chartData.datum(at: i)
                    }
                }
            }
        } else if chartData.data[yField].array?[safe: 0]?.double != nil {
            if let (xDoubleValue, yDoubleValue) = proxy.value(at: CGPoint(x: relativeX, y: relativeY), as: (Double, Double).self) {
                for i in 0 ..< chartData.length {
                    if xDoubleValue == chartData.data[xField].array?[safe: i]?.double,
                       yDoubleValue == chartData.data[yField].array?[safe: i]?.double {
                        return chartData.datum(at: i)
                    }
                }
            }
        } else if chartData.data[yField].array?[safe: 0]?.date != nil {
            if let (xDoubleValue, yDateValue) = proxy.value(at: CGPoint(x: relativeX, y: relativeY), as: (Double, Date).self) {
                for i in 0 ..< chartData.length {
                    if xDoubleValue == chartData.data[xField].array?[safe: i]?.double,
                       yDateValue == chartData.data[yField].array?[safe: i]?.date {
                        return chartData.datum(at: i)
                    }
                }
            }
        } else if chartData.data[yField].array?[safe: 0]?.string != nil {
            if let (xDoubleValue, yStringValue) = proxy.value(at: CGPoint(x: relativeX, y: relativeY), as: (Double, String).self) {
                for i in 0 ..< chartData.length {
                    if xDoubleValue == chartData.data[xField].array?[safe: i]?.double,
                       yStringValue == chartData.data[yField].array?[safe: i]?.string {
                        return chartData.datum(at: i)
                    }
                }
            }
        }
    } else if chartData.data[xField].array?[safe: 0]?.date != nil {
        if chartData.data[yField].array?[safe: 0]?.int != nil {
            if let (xDateValue, yIntValue) = proxy.value(at: CGPoint(x: relativeX, y: relativeY), as: (Date, Int).self) {
                for i in 0 ..< chartData.length {
                    if xDateValue == chartData.data[xField].array?[safe: i]?.date,
                       yIntValue == chartData.data[yField].array?[safe: i]?.int {
                        return chartData.datum(at: i)
                    }
                }
            }
        } else if chartData.data[yField].array?[safe: 0]?.double != nil {
            if let (xDateValue, yDoubleValue) = proxy.value(at: CGPoint(x: relativeX, y: relativeY), as: (Date, Double).self) {
                for i in 0 ..< chartData.length {
                    if xDateValue == chartData.data[xField].array?[safe: i]?.date,
                       yDoubleValue == chartData.data[yField].array?[safe: i]?.double {
                        return chartData.datum(at: i)
                    }
                }
            }
        } else if chartData.data[yField].array?[safe: 0]?.date != nil {
            if let (xDateValue, yDateValue) = proxy.value(at: CGPoint(x: relativeX, y: relativeY), as: (Date, Date).self) {
                for i in 0 ..< chartData.length {
                    if xDateValue == chartData.data[xField].array?[safe: i]?.date,
                       yDateValue == chartData.data[yField].array?[safe: i]?.date {
                        return chartData.datum(at: i)
                    }
                }
            }
        } else if chartData.data[yField].array?[safe: 0]?.string != nil {
            if let (xDateValue, yStringValue) = proxy.value(at: CGPoint(x: relativeX, y: relativeY), as: (Date, String).self) {
                for i in 0 ..< chartData.length {
                    if xDateValue == chartData.data[xField].array?[safe: i]?.date,
                       yStringValue == chartData.data[yField].array?[safe: i]?.string {
                        return chartData.datum(at: i)
                    }
                }
            }
        }
    } else if chartData.data[xField].array?[safe: 0]?.string != nil {
        if chartData.data[yField].array?[safe: 0]?.int != nil {
            if let (xStringValue, yIntValue) = proxy.value(at: CGPoint(x: relativeX, y: relativeY), as: (String, Int).self) {
                for i in 0 ..< chartData.length {
                    if xStringValue == chartData.data[xField].array?[safe: i]?.string,
                       yIntValue == chartData.data[yField].array?[safe: i]?.int {
                        return chartData.datum(at: i)
                    }
                }
            }
        } else if chartData.data[yField].array?[safe: 0]?.double != nil {
            if let (xStringValue, yDoubleValue) = proxy.value(at: CGPoint(x: relativeX, y: relativeY), as: (String, Double).self) {
                for i in 0 ..< chartData.length {
                    if xStringValue == chartData.data[xField].array?[safe: i]?.string,
                       yDoubleValue == chartData.data[yField].array?[safe: i]?.double {
                        return chartData.datum(at: i)
                    }
                }
            }
        } else if chartData.data[yField].array?[safe: 0]?.date != nil {
            if let (xStringValue, yDateValue) = proxy.value(at: CGPoint(x: relativeX, y: relativeY), as: (String, Date).self) {
                for i in 0 ..< chartData.length {
                    if xStringValue == chartData.data[xField].array?[safe: i]?.string,
                       yDateValue == chartData.data[yField].array?[safe: i]?.date {
                        return chartData.datum(at: i)
                    }
                }
            }
        } else if chartData.data[yField].array?[safe: 0]?.string != nil {
            if let (xStringValue, yStringValue) = proxy.value(at: CGPoint(x: relativeX, y: relativeY), as: (String, String).self) {
                for i in 0 ..< chartData.length {
                    if xStringValue == chartData.data[xField].array?[safe: i]?.string,
                       yStringValue == chartData.data[yField].array?[safe: i]?.string {
                        return chartData.datum(at: i)
                    }
                }
            }
        }
    }

    return nil
}
