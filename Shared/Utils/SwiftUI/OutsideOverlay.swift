//
//  OutsideOverlay.swift
//  iARVis
//
//  Created by Anonymous on 2022/9/1.
//

import Foundation
import SwiftUI

struct OutsideOverlay<OverlayContent: View>: ViewModifier {
    var alignment: Alignment
    var overlayContent: () -> OverlayContent

    func body(content: Content) -> some View {
        content
            .overlay(alignment: alignment) {
                Rectangle()
                    .fill(.clear)
                    .frame(width: 0.01, height: 0.01)
                    .overlay(alignment: alignment.secondLayerAlignment) {
                        overlayContent()
                            .fixedSize()
                            .padding(2)
                    }
            }
    }
}

extension View {
    func outsideOverlay<Content: View>(alignment: Alignment, @ViewBuilder overlayContent: @escaping () -> Content) -> some View {
        modifier(OutsideOverlay(alignment: alignment, overlayContent: overlayContent))
    }
}

private extension Alignment {
    var secondLayerAlignment: Alignment {
        if self == .leading {
            return .trailing
        } else if self == .topLeading {
            return .bottomTrailing
        } else if self == .bottomLeading {
            return .topTrailing
        } else if self == .trailing {
            return .leading
        } else if self == .topTrailing {
            return .bottomLeading
        } else if self == .bottomTrailing {
            return .topLeading
        } else if self == .top {
            return .bottom
        } else if self == .bottom {
            return .top
        } else {
            return .center
        }
    }
}
