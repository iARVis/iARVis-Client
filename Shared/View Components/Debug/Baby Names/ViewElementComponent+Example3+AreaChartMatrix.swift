//
//  ViewElementComponent+Example3+AreaChartMatrix.swift
//  iARVis
//
//  Created by Anonymous on 2022/9/5.
//

import Foundation

extension ViewElementComponent {
    static let example3_AreaChartMatrix: ViewElementComponent = .vStack(elements: [
        .grid(rows: [
            .gridRow(rowElements: [
                example3BabyNamesAreaChartAshleyViewElementComponent,
                example3BabyNamesAreaChartAmandaViewElementComponent,
                example3BabyNamesAreaChartBettyViewElementComponent,
            ]),
            .gridRow(rowElements: [
                example3BabyNamesAreaChartDeborahViewElementComponent,
                example3BabyNamesAreaChartDorothyViewElementComponent,
                example3BabyNamesAreaChartHelenViewElementComponent,
            ]),
            .gridRow(rowElements: [
                example3BabyNamesAreaChartJessicaViewElementComponent,
                example3BabyNamesAreaChartLindaViewElementComponent,
                example3BabyNamesAreaChartPatriciaViewElementComponent,
            ]),
        ]),
    ])
}
