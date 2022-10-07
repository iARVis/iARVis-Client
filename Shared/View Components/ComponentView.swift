//
//  ComponentView.swift
//  iARVis
//
//  Created by Anonymous on 2022/8/11.
//

import Foundation
import SwiftUI

struct ComponentView: View {
    let component: ViewElementComponent
    let isScrollEnabled: Bool
    let padding: [CGFloat]

    init(_ component: ViewElementComponent, isScrollEnabled: Bool = true, padding: [CGFloat] = PaddingDefaultValueProvider.default) {
        self.component = component
        self.isScrollEnabled = isScrollEnabled
        self.padding = padding
    }

    init(_ components: [ViewElementComponent], isScrollEnabled: Bool = true, padding: [CGFloat] = PaddingDefaultValueProvider.default) {
        if components.count == 1 {
            component = components[0]
        } else {
            component = .vStack(elements: components, alignment: .center)
        }
        self.isScrollEnabled = isScrollEnabled
        self.padding = padding
    }

    var body: some View {
        let padding: (CGFloat, CGFloat, CGFloat, CGFloat) = (padding[safe: 0] ?? 16, padding[safe: 1] ?? 16, padding[safe: 2] ?? 16, padding[safe: 3] ?? 16)

        ScrollView(isScrollEnabled ? .vertical : []) {
            component.view()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding(.leading, padding.0)
                .padding(.top, padding.1)
                .padding(.trailing, padding.2)
                .padding(.bottom, padding.3)
        }
        .coordinateSpace(name: "Widget")
    }
}

struct ComponentView_Previews: PreviewProvider {
    static var previews: some View {
        let componentView = ComponentView(.vStack(elements: [
            .text(content: "Putuo", fontStyle: ARVisFontStyle(size: 17, weight: .medium)),
            .text(content: "Sep 5, 2022", fontStyle: ARVisFontStyle(size: 12, weight: .light)),
            .hStack(elements: [
                .sfSymbol(name: "sun.max.fill", size: 24),
                .vStack(elements: [
                    .hStack(elements: [
                        .text(content: "23°", fontStyle: ARVisFontStyle(size: 20, weight: .medium)),
                    ]),
                ]),
            ]),
            .text(content: "H:26° L:22°", fontStyle: ARVisFontStyle(size: 12)),
        ], spacing: 4, modifiers: [.padding(leading: 8, trailing: 8, top: 8, bottom: 8), .background(color: .white), .roundedCorner(radius: 8)]))
        
        
        ComponentView(.example3_AreaChartMatrix)
//            .background(.blue)
            .previewLayout(.fixed(width: 2048, height: 1536))
    }
}
