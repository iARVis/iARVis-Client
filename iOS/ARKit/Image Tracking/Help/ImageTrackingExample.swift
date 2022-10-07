//
//  ImageTrackingExample.swift
//  iARVis (iOS)
//
//  Created by Anonymous on 2022/7/31.
//

import Foundation
import SceneKit

struct ImageTrackingExample {
    private static let exampleImageURL1: URL = .init(string: "https://media.getty.edu/iiif/image/ce4d5a1f-ee25-44b3-afa2-d597d43056ff/full/1024,/0/default.jpg?download=ce4d5a1f-ee25-44b3-afa2-d597d43056ff_1024.jpg&size=small")!
    
    private static let exampleImageURL2: URL = .init(string: "https://media.getty.edu/iiif/image/ce4d5a1f-ee25-44b3-afa2-d597d43056ff/full/1024,/0/default.jpg?download=ce4d5a1f-ee25-44b3-afa2-d597d43056ff_1024.jpg&size=small")!
//    private static let exampleImageURL2: URL = .init(string: "https://cdn.jsdelivr.net/gh/JJAYCHEN1e/Image@2022/default/jasper-gribble-TgQUt4fz9s8-unsplash.jpg")!

    private static let exampleImageURL3: URL = .init(string: "https://cdn.jsdelivr.net/gh/JJAYCHEN1e/Image@2022/default/Ridgeline%20Chart.jpg")!

    private static let exampleImageURL4: URL = .init(string: "https://cdn.jsdelivr.net/gh/JJAYCHEN1e/Image@2022/default/Shanghai.png")!

    private static let exampleImageURL5: URL = .init(string: "https://cdn.jsdelivr.net/gh/JJAYCHEN1e/Image@2022/default/Example5.2.jpg")!

    private static let exampleImageURL6: URL = .init(string: "https://cdn.jsdelivr.net/gh/JJAYCHEN1e/Image@2022/default/example6-qrcode.png")!

    static let exampleConfiguration1: ImageTrackingConfiguration = .init(
        imageURL: exampleImageURL1,
        relationships: [
            .init(widgetConfiguration: .init(component: .example1_ArtworkWidget,
                                             relativeAnchorPoint: .leading,
                                             relativePosition: SCNVector3(0.005, 0, 0))),
        ]
    )

    static let exampleConfiguration2: ImageTrackingConfiguration = .init(
        imageURL: exampleImageURL2,
        relationships: [
            .init(widgetConfiguration: .init(component: .example2_MacBookPro,
                                             relativeAnchorPoint: .trailing,
                                             relativePosition: SCNVector3(0.005, 0, 0))),
        ]
    )

    static let exampleConfiguration3: ImageTrackingConfiguration = .init(
        imageURL: exampleImageURL3,
        relationships: [
            .init(widgetConfiguration: .init(component: .example3_AreaChartMatrix,
                                             relativeAnchorPoint: .trailing,
                                             relativePosition: SCNVector3(0, 0, 0),
                                             isScrollEnabled: false,
                                             scale: ScaleDefaultValueProvider.level_3,
                                             size: CGSize(width: 2048, height: 1536))),
        ]
    )

    static let exampleConfiguration4: ImageTrackingConfiguration = .init(
        imageURL: exampleImageURL4,
        relationships: [
            .init(widgetConfiguration: .init(component: .example4_ShanghaiWeatherPointChartViewElementComponent,
                                             relativeAnchorPoint: .cover,
                                             relativePosition: SCNVector3(0, 0, 0),
                                             isOpaque: false,
                                             isScrollEnabled: false,
                                             showExpandButton: false,
                                             padding: [0, 0, 0, 0],
                                             size: CGSize(width: 1000, height: 1000))),
        ]
    )

    static let exampleConfiguration5: ImageTrackingConfiguration = .init(
        imageURL: exampleImageURL5,
        relationships: [
            .init(widgetConfiguration: .init(component: .example5_HistoricalWeatherPointChartViewElementComponent_1,
                                             relativeAnchorPoint: .leading,
                                             relativePosition: SCNVector3(0, 0, 0),
                                             alignedToTarget: true,
                                             isOpaque: false,
                                             isScrollEnabled: false,
                                             showExpandButton: false,
                                             padding: [16, 12, 0, 0],
                                             size: CGSize(width: 550, height: 330))),
            .init(widgetConfiguration: .init(component: .example5_HistoricalWeatherPointChartViewElementComponent_2,
                                             relativeAnchorPoint: .trailing,
                                             relativePosition: SCNVector3(0, 0, 0),
                                             alignedToTarget: true,
                                             isOpaque: false,
                                             isScrollEnabled: false,
                                             showExpandButton: false,
                                             padding: [16, 12, 0, 0],
                                             size: CGSize(width: 550, height: 330))),
        ]
    )

    static let exampleConfiguration6: ImageTrackingConfiguration = .init(
        imageURL: exampleImageURL6,
        relationships: [
            .init(widgetConfiguration: .init(component: .example6_SPLOMViewElementComponent,
                                             relativeAnchorPoint: .trailing,
                                             relativePosition: SCNVector3(0, 0, 0),
                                             isScrollEnabled: false,
                                             size: CGSize(width: 1000, height: 1000))),
        ]
    )
}
