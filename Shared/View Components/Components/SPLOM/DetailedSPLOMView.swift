//
//  DetailedSPLOMView.swift
//  iARVis (iOS)
//
//  Created by Anonymous on 2022/9/8.
//

import Charts
import Combine
import SwiftUI

private struct Range {
    var xStart: CGFloat
    var xEnd: CGFloat
    var yStart: CGFloat
    var yEnd: CGFloat
}

private class ViewModel: ObservableObject {
    @Published var selectionRange: Range?
    @Published var selectionData: [[String: Any]] = []
}

@available(iOS 16, *)
struct DetailedSPLOMView: View {
    init(datumArray: [[String: Any]], chartDataItem: ChartDataItem, xField: String, yField: String, config: ChartComponentCommonConfig, showXAxis: Bool = true, showYAxis: Bool = false, isPreview: Bool = true) {
        self.datumArray = datumArray
        self.chartDataItem = chartDataItem
        self.xField = xField
        self.yField = yField
        self.showXAxis = showXAxis
        self.showYAxis = showYAxis

        let _config = config
        if !isPreview {
            if let symbolSize = _config.symbolSize {
                _config.symbolSize?.width = max(5, symbolSize.width)
                _config.symbolSize?.height = max(5, symbolSize.height)
            }
        }
        self.config = _config
        self.isPreview = isPreview
    }

    let datumArray: [[String: Any]]
    let chartDataItem: ChartDataItem
    let xField: String
    let yField: String
    let config: ChartComponentCommonConfig
    let showXAxis: Bool
    let showYAxis: Bool
    let isPreview: Bool
    @ObservedObject private var config: ChartComponentCommonConfig

    private var viewModel = ViewModel()

    @State private var subscriptions: Set<AnyCancellable> = []
    @State private var publisher: CurrentValueSubject<(proxy: ChartProxy, range: Range)?, Never> = .init(nil)

    @ChartContentBuilder
    @inlinable
    func pointMark<X: Plottable, Y: Plottable>(x: X, y: Y) -> some ChartContent {
        PointMark(x: .value("x", x), y: .value("y", y))
    }

    @ChartContentBuilder
    @inlinable
    func mark(x: Any, y: Any) -> some ChartContent {
        if let xIntValue = x as? Int {
            if let yIntValue = y as? Int {
                pointMark(x: xIntValue, y: yIntValue)
            } else if let yDoubleValue = y as? Double {
                pointMark(x: xIntValue, y: yDoubleValue)
            }
        } else if let xDoubleValue = x as? Double {
            if let yIntValue = y as? Int {
                pointMark(x: xDoubleValue, y: yIntValue)
            } else if let yDoubleValue = y as? Double {
                pointMark(x: xDoubleValue, y: yDoubleValue)
            }
        }
    }

    func selectedData(proxy: ChartProxy, xStart: CGFloat, xEnd: CGFloat, yStart: CGFloat, yEnd: CGFloat) -> [[String: Any]] {
        if let _ = datumArray[safe: 0]?[xField] as? Int {
            if let _ = datumArray[safe: 0]?[yField] as? Int {
                if let xStart: Int = proxy.value(atX: xStart),
                   let xEnd: Int = proxy.value(atX: xEnd),
                   let yStart: Int = proxy.value(atY: yStart),
                   let yEnd: Int = proxy.value(atY: yEnd) {
                    return datumArray.filter { element in
                        if let xValue = element[xField] as? Int,
                           let yValue = element[yField] as? Int {
                            if xValue >= min(xStart, xEnd), xValue <= max(xStart, xEnd),
                               yValue >= min(yStart, yEnd), yValue <= max(yStart, yEnd) {
                                return true
                            }
                        }
                        return false
                    }
                }
            } else if let _ = datumArray[safe: 0]?[yField] as? Double {
                if let xStart: Int = proxy.value(atX: xStart),
                   let xEnd: Int = proxy.value(atX: xEnd),
                   let yStart: Double = proxy.value(atY: yStart),
                   let yEnd: Double = proxy.value(atY: yEnd) {
                    return datumArray.filter { element in
                        if let xValue = element[xField] as? Int,
                           let yValue = element[yField] as? Double {
                            if xValue >= min(xStart, xEnd), xValue <= max(xStart, xEnd),
                               yValue >= min(yStart, yEnd), yValue <= max(yStart, yEnd) {
                                return true
                            }
                        }
                        return false
                    }
                }
            }
        } else if let _ = datumArray[safe: 0]?[xField] as? Double {
            if let _ = datumArray[safe: 0]?[yField] as? Int {
                if let xStart: Double = proxy.value(atX: xStart),
                   let xEnd: Double = proxy.value(atX: xEnd),
                   let yStart: Int = proxy.value(atY: yStart),
                   let yEnd: Int = proxy.value(atY: yEnd) {
                    return datumArray.filter { element in
                        if let xValue = element[xField] as? Double,
                           let yValue = element[yField] as? Int {
                            if xValue >= min(xStart, xEnd), xValue <= max(xStart, xEnd),
                               yValue >= min(yStart, yEnd), yValue <= max(yStart, yEnd) {
                                return true
                            }
                        }
                        return false
                    }
                }
            } else if let _ = datumArray[safe: 0]?[yField] as? Double {
                if let xStart: Double = proxy.value(atX: xStart),
                   let xEnd: Double = proxy.value(atX: xEnd),
                   let yStart: Double = proxy.value(atY: yStart),
                   let yEnd: Double = proxy.value(atY: yEnd) {
                    return datumArray.filter { element in
                        if let xValue = element[xField] as? Double,
                           let yValue = element[yField] as? Double {
                            if xValue >= min(xStart, xEnd), xValue <= max(xStart, xEnd),
                               yValue >= min(yStart, yEnd), yValue <= max(yStart, yEnd) {
                                return true
                            }
                        }
                        return false
                    }
                }
            }
        }
        return []
    }

    var body: some View {
        if isPreview {
            Chart {
                ChartGroup {
                    ForEach(0 ..< chartDataItem.length, id: \.self) { index in
                        if let datum = datumArray[safe: index] {
                            if let x = datum[xField], let y = datum[yField] {
                                mark(x: x, y: y)
                                    .applyCommonConfig(commonConfig: config, datumDictionary: datum)
                            }
                        }
                    }
                }
                .applyCommonConfig(commonConfig: config)
            }
            .chartXAxis {
                AxisMarks(position: .bottom, values: .automatic) { _ in
                    if showXAxis {
                        AxisValueLabel()
                    }
                    AxisGridLine()
                    AxisTick()
                }
            }
            .chartYAxis {
                AxisMarks(position: .leading, values: .automatic) { _ in
                    if showYAxis {
                        AxisValueLabel()
                    }
                    AxisGridLine()
                    AxisTick()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else {
            GeometryReader { proxy in
                let availableSize = proxy.size
                let padding: CGFloat = 32
                Color.clear
                    .frame(width: max(0, availableSize.width - padding * 2), height: max(0, availableSize.height - padding * 2))
                    .overlay {
                        GeometryReader { proxy in
                            let availableSize = proxy.size
                            ZStack {
                                Chart {
                                    ChartGroup {
                                        ForEach(0 ..< chartDataItem.length, id: \.self) { index in
                                            if let datum = datumArray[safe: index] {
                                                if let x = datum[xField], let y = datum[yField] {
                                                    mark(x: x, y: y)
                                                        .applyCommonConfig(commonConfig: config, datumDictionary: datum)
                                                }
                                            }
                                        }
                                    }
                                    .applyCommonConfig(commonConfig: config)
                                }
                                .chartOverlay { proxy in
                                    GeometryReader { geoProxy in
                                        Rectangle().fill(.clear).contentShape(Rectangle())
                                            .gesture(DragGesture()
                                                .onChanged { value in
                                                    let xStart = value.startLocation.x - geoProxy[proxy.plotAreaFrame].origin.x
                                                    let xCurrent = value.location.x - geoProxy[proxy.plotAreaFrame].origin.x
                                                    let yStart = value.startLocation.y - geoProxy[proxy.plotAreaFrame].origin.y
                                                    let yCurrent = value.location.y - geoProxy[proxy.plotAreaFrame].origin.y
                                                    viewModel.selectionRange = Range(xStart: xStart, xEnd: xCurrent, yStart: yStart, yEnd: yCurrent)
                                                    publisher.send((proxy: proxy, range: Range(xStart: xStart, xEnd: xCurrent, yStart: yStart, yEnd: yCurrent)))
                                                }
                                            )
                                    }
                                }
                                .outsideOverlay(alignment: .top) {
                                    Text("Scatterplot between \(xField) and \(yField)")
                                        .font(.system(size: 24, weight: .medium, design: .rounded))
                                        .padding(.bottom, 16)
                                }
                                .outsideOverlay(alignment: .bottom) {
                                    Text(xField)
                                        .font(.system(size: 12, weight: .light, design: .rounded))
                                }
                                .overlay(alignment: .leading) {
                                    Rectangle()
                                        .fill(.clear)
                                        .frame(width: 0.01, height: 0.01)
                                        .overlay(alignment: .center) {
                                            Text(yField)
                                                .font(.system(size: 12, weight: .light, design: .rounded))
                                                .rotationEffect(Angle.degrees(-90))
                                                .fixedSize()
                                                .offset(x: -15)
                                        }
                                }

                                OverlayRectangle(viewModel: viewModel)
                            }
                            .frame(width: max(0, availableSize.width * 0.8), height: max(0, availableSize.height * 0.8))
                            .offset(x: 0, y: availableSize.height * 0.1)

                            VStack {
                                DataDistributionView(datumArray: datumArray, chartDataItem: chartDataItem, xField: xField, yField: yField, config: config)
                                    .id(UUID())
                                Spacer(minLength: 0)
                                DataSummaryView(viewModel: viewModel, config: config)
                            }
                            .padding(.horizontal, 8)
                            .frame(width: availableSize.width * 0.2, height: availableSize.height * 0.8)
                            .offset(x: availableSize.width * 0.8, y: availableSize.height * 0.1)
                        }
                    }
                    .offset(x: padding, y: padding)
            }
            .onLoad {
                var timeInterval: Int
                if chartDataItem.length <= 60000 {
                    timeInterval = 17
                } else if chartDataItem.length <= 100_000 {
                    timeInterval = 25
                } else {
                    timeInterval = 35
                }

                var lastTime: TimeInterval = 0
                publisher
                    .throttle(for: .milliseconds(timeInterval), scheduler: DispatchQueue.main, latest: true)
                    .map { result in
                        (Date().timeIntervalSince1970, result)
                    }
                    .receive(on: DispatchQueue.global())
                    .map { time, result in
                        if let (proxy, range) = result {
                            return (time, selectedData(proxy: proxy, xStart: range.xStart, xEnd: range.xEnd, yStart: range.yStart, yEnd: range.yEnd))
                        }
                        return (time, [])
                    }
                    .receive(on: DispatchQueue.main)
                    .filter { time, result in
                        lastTime = max(time, lastTime)
                        return time >= lastTime
                    }
                    .sink { _, result in
                        viewModel.selectionData = result
                    }
                    .store(in: &subscriptions)
            }
        }
    }
}

private struct OverlayRectangle: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        GeometryReader { geoProxy in
            if let selectionRange = viewModel.selectionRange {
                let xStart = selectionRange.xStart
                let xEnd = selectionRange.xEnd
                let yStart = selectionRange.yStart
                let yEnd = selectionRange.yEnd
                let width = abs(xEnd - xStart)
                let height = abs(yEnd - yStart)
                Rectangle()
                    .foregroundStyle(.gray.opacity(0.2))
                    .frame(width: width, height: height)
                    .offset(x: min(xStart, xEnd), y: min(yStart, yEnd))
            }
        }
        .allowsHitTesting(false)
    }
}

private struct DataSummaryView: View {
    @ObservedObject var viewModel: ViewModel
    let config: ChartComponentCommonConfig

    var body: some View {
        let seriesField: String? = (config.foregroundStyleColorMap?.map { $0.field } ?? [config.foregroundStyleField]).compactMap { $0 }.first
        if let field = seriesField {
            let map: [String: Int] = {
                var map: [String: Int] = [:]
                viewModel.selectionData.forEach { datum in
                    if let intValue = datum[field] as? Int {
                        map[String(intValue), default: 0] += 1
                    } else if let doubleValue = datum[field] as? Double {
                        map[String(doubleValue), default: 0] += 1
                    } else if let stringValue = datum[field] as? String {
                        map[stringValue, default: 0] += 1
                    }
                }
                return map
            }()

            let distributionDescription: String = map.sorted(by: { $0.key < $1.key }).map { key, value in
                "**\(value)** of them's **\(field)** field \(value == 1 ? "is" : "are") **\(key)**(\(String(format: "%.2f", Double(value) / Double(viewModel.selectionData.count) * 100))%)"
            }.joined(separator: ",")

            let description = """
            You've selected **\(viewModel.selectionData.count)** items in **\(map.keys.count)** types.
            \(distributionDescription)\(distributionDescription != "" ? "." : "")
            """

            VStack {
                Text(.init(description))
                    .font(.system(size: 15, weight: .light, design: .rounded))
            }
            .allowsHitTesting(false)
        }
    }
}

@available(iOS 16, *)
private struct DataDistributionView: View {
    let datumArray: [[String: Any]]
    let chartDataItem: ChartDataItem
    let xField: String
    let yField: String
    let config: ChartComponentCommonConfig

    private let colorHelper = ColorHelper()

    class ColorHelper {
        private let colors: [Color] = [
            .blue,
            .green,
            .orange,
        ]

        private var pointer = 0

        private var cache: [String: Color] = [:]

        func color(for series: String) -> Color {
            return cache[series, default: {
                let color = colors[pointer]
                pointer = (pointer + 1) % colors.count
                cache[series] = color
                return color
            }()]
        }
    }

    @ChartContentBuilder
    func mark(x: AnyHashable, series: String, count: Int) -> some ChartContent {
        ChartGroup {
            if let xValue = x as? Int {
                AreaMark(x: .value("x", xValue), y: .value("y", count), stacking: .normalized)
            } else if let xValue = x as? Double {
                AreaMark(x: .value("x", xValue), y: .value("y", count), stacking: .normalized)
            }
        }
//        .interpolationMethod(.cardinal)
        .foregroundStyle(by: .value("foregroundStyleBy", series))
    }

    @ViewBuilder
    func chart(seriesField: String, field: String) -> some View {
        Chart {
            ChartGroup {}
            let map: [AnyHashable: [String: Int]] = {
                var map: [AnyHashable: [String: Int]] = [:]
                datumArray.forEach { datum in
                    if let fieldValue = datum[field] as? AnyHashable {
                        if let intValue = datum[seriesField] as? Int {
                            map[fieldValue, default: [:]][String(intValue), default: 0] += 1
                        } else if let doubleValue = datum[seriesField] as? Double {
                            map[fieldValue, default: [:]][String(doubleValue), default: 0] += 1
                        } else if let stringValue = datum[seriesField] as? String {
                            map[fieldValue, default: [:]][stringValue, default: 0] += 1
                        }
                    }
                }
                return map
            }()

            let sortedMap = map.sorted { l, r in
                if let l = l.key as? Int, let r = r.key as? Int {
                    return l < r
                } else if let l = l.key as? Double, let r = r.key as? Double {
                    return l < r
                }
                return false
            }

            let possibleSeriesSet: Set<String> = Set(sortedMap.flatMap { Array($0.value.keys) })

            ForEach(sortedMap, id: \.key) { x, innerMap in
                ForEach(Array(zip(possibleSeriesSet.indices, possibleSeriesSet)), id: \.0) { index, possibleSeries in
                    mark(x: x, series: possibleSeries, count: innerMap[possibleSeries, default: 0])
                }
            }
        }
        .chartForegroundStyleScale(mapping: { (p: String) in
            colorHelper.color(for: p)
        })
        .height(100)
    }

    var body: some View {
        if let seriesField: String = (config.foregroundStyleColorMap?.map { $0.field } ?? [config.foregroundStyleField]).compactMap({ $0 }).first {
            VStack(alignment: .leading) {
                chart(seriesField: seriesField, field: xField)
                Text(xField)
                    .font(.system(size: 12, weight: .light, design: .rounded))
                chart(seriesField: seriesField, field: yField)
                Text(yField)
                    .font(.system(size: 12, weight: .light, design: .rounded))
            }
        }
    }
}
