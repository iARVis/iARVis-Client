//
//  ChartTooltipView.swift
//  iARVis
//
//  Created by Anonymous on 2022/8/16.
//

import SwiftUI
import SwiftUIX

@available(iOS 16, *)
struct ChartTooltipView: View {
    @OptionalEnvironmentObject var widgetConfiguration: WidgetConfiguration?
    let component: ViewElementComponent

    init(_ component: ViewElementComponent) {
        self.component = component
    }

    init(_ components: [ViewElementComponent]) {
        if components.count == 0 {
            component = components[0]
        } else {
            component = .vStack(elements: components, alignment: .center)
        }
    }

    var body: some View {
        component.view()
            .padding(.horizontal)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .stroke(Asset.DynamicColors.dynamicWhite.swiftUIColor, lineWidth: 1)
                    .background(Asset.DynamicColors.dynamicWhite.swiftUIColor)
            )
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .shadow(color: .primary.opacity(0.1), radius: 15)
            .overlay(alignment: .topLeading) {
                Button {
                    UIApplication.shared.presentOnTop(ChartTooltipPresentationViewController(widgetConfiguration: widgetConfiguration, component: component), detents: [
                        .custom { context in
                            context.maximumDetentValue * 0.3
                        },
                        .custom { context in
                            context.maximumDetentValue * 0.5
                        },
                        .large(),
                    ])
                } label: {
                    Image(systemName: "arrow.up.left.and.arrow.down.right")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                        .padding(.all, 6)
                        .background(
                            Circle()
                                .stroke(Asset.DynamicColors.dynamicWhite.swiftUIColor, lineWidth: 1)
                                .background(Asset.DynamicColors.dynamicWhite.swiftUIColor)
                        )
                        .clipShape(Circle())
                        .shadow(color: .primary.opacity(0.1), radius: 5)
                        .offset(x: 6, y: 6)
                }
            }
    }
}
