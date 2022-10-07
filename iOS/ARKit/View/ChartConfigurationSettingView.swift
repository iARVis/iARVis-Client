//
//  ChartConfigurationSettingView.swift
//  iARVis (iOS)
//
//  Created by Anonymous on 2022/9/15.
//

import Combine
import SwiftUI
import SwiftyJSON

@available(iOS 16, *)
class ChartConfigurationSettingViewController: UIViewController {
    private var hostingViewController: UIHostingController<AnyView>!
    private var chartConfiguration: ChartConfiguration = .init()

    override func viewDidLoad() {
        super.viewDidLoad()

        overrideUserInterfaceStyle = .light

        let chartConfigurationSettingViewController = UIHostingController(rootView: AnyView(ChartConfigurationSettingView(chartConfiguration: chartConfiguration).id(UUID())), ignoreSafeArea: true)
        chartConfigurationSettingViewController.overrideUserInterfaceStyle = .light
        hostingViewController = chartConfigurationSettingViewController
        addChildViewController(chartConfigurationSettingViewController, addConstrains: true)
        chartConfigurationSettingViewController.view.backgroundColor = .clear
    }

    func update(chartConfiguration: ChartConfiguration) {
        if self.chartConfiguration != chartConfiguration {
            self.chartConfiguration = chartConfiguration
            hostingViewController.rootView = AnyView(ChartConfigurationSettingView(chartConfiguration: chartConfiguration).id(UUID()))
        }
    }
}

@available(iOS 16, *)
struct ChartConfigurationSettingView: View {
    init(chartConfiguration: ChartConfiguration) {
        self.chartConfiguration = chartConfiguration
    }

    @ObservedObject private var chartConfiguration: ChartConfiguration

    @State private var subscriptions: Set<AnyCancellable> = []
    @State private var publisher: PassthroughSubject<Void, Never> = .init()

    var body: some View {
        NavigationStack {
            List {
                chartConfigurationView
                componentsConfigurationView
            }
            .navigationDestination(for: ColorMapDestination.self) { colorMapDestination in
                if let colorMap = colorMapDestination.colorMap {
                    List {
                        ForEach(0 ..< colorMap.count, id: \.self) { index in
                            let colorMapItem = colorMap[index]
                            Section("Item \(index + 1)") {
                                textLabel(title: "Field", content: colorMapItem.field)
                                textLabel(title: "Value", content: colorMapItem.value.description)
                                HStack {
                                    textLabel(title: "Color", content: colorMapItem.color.toSwiftUIColor().hexString)
                                    Spacer()
                                    ColorPicker(selection: .init(get: { () -> Color in
                                        colorMapItem.color.toSwiftUIColor()
                                    }, set: { newValue in
                                        colorMapItem.color = .init(newValue)
                                        publisher.send()
                                    }), label: {})
                                        .fixedSize()
                                }
                            }
                        }
                    }
                    .navigationTitle("Color Map")
                    .navigationBarTitleDisplayMode(.inline)
                } else {
                    List {
                        Text("No Color Map Specified")
                            .foregroundColor(.gray)
                    }
                    .navigationTitle("Color Map")
                    .navigationBarTitleDisplayMode(.inline)
                }
            }
            .navigationDestination(for: LineStyleDestination.self) { lineStyleDestination in
                let lineStyle = lineStyleDestination.lineStyle
                List {
                    HStack {
                        textLabel(title: "Line Width", content: {
                            if let lineWidth = lineStyle?.lineWidth {
                                return String(format: ".2f", lineWidth)
                            } else {
                                return "Not set"
                            }
                        }())
                        Spacer()
                        Stepper {} onIncrement: {} onDecrement: {}
                            .fixedSize()
                    }
                }
                .navigationTitle("Line Style")
                .navigationBarTitleDisplayMode(.inline)
            }
            .navigationDestination(for: AnnotationsDestination.self) { annotationsDestination in
                let annotations = annotationsDestination.annotations ?? []
                List {
                    if annotations.count == 0 {
                        Text("No Annotations")
                            .foregroundColor(.gray)
                    }

                    ForEach(0 ..< annotations.count, id: \.self) { index in
                        let annotation = annotations[index]
                        Section("Annotation \(index + 1)") {
                            Picker("Position", selection: .init(get: { () -> ARVisAnnotationPosition in
                                annotation.position
                            }, set: { newValue in
                                annotation.position = newValue
                                publisher.send()
                            })) {
                                ForEach(ARVisAnnotationPosition.allCases) { position in
                                    Text(position.rawValue.capitalized).tag(position)
                                }
                            }

                            annotation.content.view()
                        }
                    }
                }
                .navigationTitle("Annotations")
                .navigationBarTitleDisplayMode(.inline)
            }
            .navigationDestination(for: ConditionalAnnotationsDestination.self) { conditionalAnnotationsDestination in
                let conditionalAnnotations = conditionalAnnotationsDestination.conditionalAnnotations ?? []
                List {
                    if conditionalAnnotations.count == 0 {
                        Text("No Conditional Annotations")
                            .foregroundColor(.gray)
                    }

                    ForEach(0 ..< conditionalAnnotations.count, id: \.self) { index in
                        let conditionalAnnotation = conditionalAnnotations[index]
                        Section("Conditional Annotation \(index + 1)") {
                            textLabel(title: "Field", content: conditionalAnnotation.field)
                            textLabel(title: "Value", content: conditionalAnnotation.value.stringValue)
                            Picker("Position", selection: .init(get: { () -> ARVisAnnotationPosition in
                                conditionalAnnotation.annotation.position
                            }, set: { newValue in
                                conditionalAnnotation.annotation.position = newValue
                                publisher.send()
                            })) {
                                ForEach(ARVisAnnotationPosition.allCases) { position in
                                    Text(position.rawValue.capitalized).tag(position)
                                }
                            }
                            conditionalAnnotation.annotation.content.view()
                        }
                    }
                }
                .navigationTitle("Conditional Annotations")
                .navigationBarTitleDisplayMode(.inline)
            }
            .safeAreaInset(edge: .bottom) {
                Color.clear.frame(height: 8)
            }
            .navigationTitle("Chart Configuration")
            .navigationBarTitleDisplayMode(.inline)
        }
        .frame(width: 400, height: 700)
        .cornerRadius(16, style: .continuous)
        .onLoad {
            publisher
                .throttle(for: .milliseconds(100), scheduler: DispatchQueue.main, latest: true)
                .sink {
                    chartConfiguration.objectWillChange.send()
                }
                .store(in: &subscriptions)
        }
    }

    var chartConfigurationView: some View {
        Section("Chart Configuration") {
            Toggle("Show X-Axis", isOn: .init(get: {
                !(chartConfiguration.swiftChartConfiguration.chartXAxis?.hidden ?? false)
            }, set: { newValue in
                let hidden = !newValue
                if chartConfiguration.swiftChartConfiguration.chartXAxis == nil {
                    chartConfiguration.swiftChartConfiguration.chartXAxis = ChartXAxis(hidden: hidden)
                }
                chartConfiguration.swiftChartConfiguration.chartXAxis?.hidden = hidden
                publisher.send()
            }))

            Toggle("Show Y-Axis", isOn: .init(get: {
                !(chartConfiguration.swiftChartConfiguration.chartYAxis?.hidden ?? false)
            }, set: { newValue in
                let hidden = !newValue
                if chartConfiguration.swiftChartConfiguration.chartYAxis == nil {
                    chartConfiguration.swiftChartConfiguration.chartYAxis = ChartYAxis(hidden: hidden)
                }
                chartConfiguration.swiftChartConfiguration.chartYAxis?.hidden = hidden
                publisher.send()
            }))

            Toggle("Show Legend", isOn: .init(get: {
                !(chartConfiguration.swiftChartConfiguration.chartLegend?.hidden ?? false)
            }, set: { newValue in
                let hidden = !newValue
                if chartConfiguration.swiftChartConfiguration.chartLegend == nil {
                    chartConfiguration.swiftChartConfiguration.chartLegend = ChartLegend(hidden: hidden)
                }
                chartConfiguration.swiftChartConfiguration.chartLegend?.hidden = hidden
                publisher.send()
            }))
        }
    }

    @ViewBuilder
    func componentConfigView(componentConfig: ChartComponentConfiguration) -> some View {
        switch componentConfig.component {
        case let .lineMarkRepeat1(dataKey, x, y):
            textLabel(title: "Data Key", content: dataKey)
            textLabel(title: "X Field", content: x.field)
            textLabel(title: "Y Field", content: y.field)
        case let .barMarkRepeat1(dataKey, xStart, xEnd, y, height):
            textLabel(title: "Data Key", content: dataKey)
            textLabel(title: "X Start Field", content: xStart.field)
            textLabel(title: "X End Field", content: xEnd.field)
            textLabel(title: "Y Field", content: y.field)
        case let .barMarkRepeat2(dataKey, x, y, height):
            textLabel(title: "Data Key", content: dataKey)
            textLabel(title: "X Field", content: x.field)
            textLabel(title: "Y Field", content: y.field)
        case let .lineMarkRepeat2(dataKey, x, ySeries):
            textLabel(title: "Data Key", content: dataKey)
            textLabel(title: "X Field", content: x.field)
        case let .rectangleMarkRepeat1(dataKey, xStart, xEnd, yStart, yEnd):
            textLabel(title: "Data Key", content: dataKey)
            textLabel(title: "X Start Field", content: xStart.field)
            textLabel(title: "X End Field", content: xEnd.field)
            textLabel(title: "Y Start Field", content: yStart.field)
            textLabel(title: "Y End Field", content: yEnd.field)
        case let .ruleMarkRepeat1(dataKey, x, yStart, yEnd):
            textLabel(title: "Data Key", content: dataKey)
            textLabel(title: "X Field", content: x.field)
            if let yStart = yStart {
                textLabel(title: "Y Start Field", content: yStart.field)
            }
            if let yEnd = yEnd {
                textLabel(title: "Y End Field", content: yEnd.field)
            }
        case let .pointMarkRepeat1(dataKey, x, y):
            textLabel(title: "Data Key", content: dataKey)
            textLabel(title: "X Field", content: x.field)
            textLabel(title: "Y Field", content: y.field)
        case let .areaMarkRepeat1(dataKey, x, y, stacking):
            textLabel(title: "Data Key", content: dataKey)
            textLabel(title: "X Field", content: x.field)
            textLabel(title: "Y Field", content: y.field)
            if let stacking = stacking {
                textLabel(title: "Stacking", content: stacking.rawValue)
            }
        }
    }

    @ViewBuilder
    func componentCommonConfigView(componentConfig: ChartComponentConfiguration, commonConfig: ChartComponentCommonConfig) -> some View {
        Group {
            Picker("Interpolation", selection: .init(get: { () -> ARVisInterpolationMethod? in
                commonConfig.interpolationMethod
            }, set: { newValue in
                commonConfig.interpolationMethod = newValue
                publisher.send()
            })) {
                Text("Not set")
                    .tag(nil as ARVisInterpolationMethod?)
                ForEach(ARVisInterpolationMethod.allCases) { interpolationMethod in
                    Text(interpolationMethod.rawValue.capitalized).tag(interpolationMethod as ARVisInterpolationMethod?)
                }
            }

            Picker("Symbol", selection: .init(get: { () -> ARVisSymbolType? in
                commonConfig.symbol?.type
            }, set: { newValue in
                if let newValue = newValue {
                    commonConfig.symbol = ARVisSymbol(type: newValue)
                    publisher.send()
                } else {
                    commonConfig.symbol = nil
                }
            })) {
                Text("Not set")
                    .tag(nil as ARVisSymbolType?)
                ForEach(ARVisSymbolType.allCases) { symbol in
                    Text(symbol.rawValue.capitalized).tag(symbol as ARVisSymbolType?)
                }
            }

            HStack {
                textLabel(title: "Symbol Size", content: {
                    if let symbolSize = commonConfig.symbolSize {
                        return "(\(String(format: "%.2f", symbolSize.width)), \(String(format: "%.2f", symbolSize.height)))"
                    } else {
                        return "Not set"
                    }
                }())
                Spacer()
                Stepper {} onIncrement: {} onDecrement: {}
                    .fixedSize()
            }

            HStack {
                textLabel(title: "Foreground Color", content: {
                    if let foregroundStyleColor = commonConfig.foregroundStyleColor {
                        return foregroundStyleColor.toSwiftUIColor().hexString
                    } else {
                        return "Not set"
                    }
                }())
                Spacer()
                ColorPicker(selection: .init(get: { () -> Color in
                    commonConfig.foregroundStyleColor?.toSwiftUIColor() ?? Color.red
                }, set: { newValue in
                    commonConfig.foregroundStyleColor = .init(newValue)
                    publisher.send()
                }), label: {})
                    .fixedSize()
                    .opacity(commonConfig.foregroundStyleColor == nil ? 0.3 : 1.0)
                    .animation(.default, value: commonConfig.foregroundStyleColor == nil)
            }

            NavigationLink(value: ColorMapDestination(colorMap: commonConfig.foregroundStyleColorMap)) {
                textLabel(title: "Foreground Color Map", content: "\(commonConfig.foregroundStyleColorMap?.count ?? 0)")
            }

            let fields = chartConfiguration.chartData.dataItems[componentConfig.component.dataKey]?.titles ?? []

            Picker("Foreground Field", selection: .init(get: { () -> String? in
                commonConfig.foregroundStyleField
            }, set: { newValue in
                if let newValue = newValue {
                    commonConfig.foregroundStyleField = newValue
                    publisher.send()
                } else {
                    commonConfig.foregroundStyleField = nil
                }
            })) {
                Text("Not set")
                    .tag(nil as String?)
                ForEach(0 ..< fields.count, id: \.self) { index in
                    let field = fields[index]
                    Text(field).tag(field as String?)
                }
            }

            textLabel(title: "Foreground Value", content: {
                if let foregroundStyleValue = commonConfig.foregroundStyleValue {
                    return foregroundStyleValue
                } else {
                    return "Not set"
                }
            }())

            textLabel(title: "Position By Value", content: {
                if let positionByValue = commonConfig.positionByValue {
                    return positionByValue
                } else {
                    return "Not set"
                }
            }())

            HStack {
                textLabel(title: "Corner Radius", content: {
                    if let cornerRadius = commonConfig.cornerRadius {
                        return String(format: ".2f", cornerRadius)
                    } else {
                        return "Not set"
                    }
                }())
                Spacer()
                Stepper {} onIncrement: {} onDecrement: {}
                    .fixedSize()
            }

            NavigationLink("Line Stroke", value: LineStyleDestination(lineStyle: commonConfig.lineStyle))
        }

        Group {
            NavigationLink(value: AnnotationsDestination(annotations: commonConfig.annotations)) {
                textLabel(title: "Annotations", content: "\(commonConfig.annotations?.count ?? 0)")
            }

            NavigationLink(value: ConditionalAnnotationsDestination(conditionalAnnotations: commonConfig.conditionalAnnotations)) {
                textLabel(title: "Conditional Annotations", content: "\(commonConfig.conditionalAnnotations?.count ?? 0)")
            }
        }
    }

    var componentsConfigurationView: some View {
        ForEach(0 ..< chartConfiguration.componentConfigs.count, id: \.self) { index in
            let componentConfig = chartConfiguration.componentConfigs[index]

            Section("Components Configuration - \(componentConfig.component.typeDescription)") {
                componentConfigView(componentConfig: componentConfig)
                componentCommonConfigView(componentConfig: componentConfig, commonConfig: componentConfig.commonConfig)
            }
        }
    }

    @ViewBuilder
    func textLabel(title: String, content: String) -> some View {
        HStack {
            Text(title)
            Spacer()
            Text(content)
                .foregroundColor(.gray)
        }
    }
}

@available(iOS 16, *)
struct ChartConfigurationSetting_Previews: PreviewProvider {
    static var previews: some View {
        let chartConfiguration = ChartConfiguration()
        let data: JSON = [
            "label": "default",
            "data": [
                "x": [1, 2, 3],
                "y": [4, 5, 6],
            ],
        ]
        chartConfiguration.chartData = ChartData([data])
        let chartComponent: ChartComponent = .lineMarkRepeat1(dataKey: "default", x: .value("X"), y: .value("Y"))
        chartConfiguration.componentConfigs = [.init(component: chartComponent, commonConfig: .init())]
        return ChartConfigurationSettingView(chartConfiguration: chartConfiguration)
            .previewLayout(.sizeThatFits)
    }
}

private struct ColorMapDestination: Codable, Hashable {
    var colorMap: [ColorMap]?
}

private struct LineStyleDestination: Codable, Hashable {
    var lineStyle: ARVisLineStyle?
}

private struct AnnotationsDestination: Codable, Hashable {
    var annotations: [ARVisAnnotation]?
}

private struct ConditionalAnnotationsDestination: Codable, Hashable {
    var conditionalAnnotations: [ARVisConditionalAnnotation]?
}
