//
//  View+SizeThatFits.swift
//  iARVis
//
//  Created by Anonymous on 2022/8/16.
//

import Foundation
import SwiftUI

/// http://defagos.github.io/understanding_swiftui_layout_behaviors/
extension View {
    func adaptiveSizeThatFits(in size: CGSize, for horizontalSizeClass: UIUserInterfaceSizeClass) -> CGSize {
        let hostController = UIHostingController(rootView: environment(\.horizontalSizeClass, UserInterfaceSizeClass(horizontalSizeClass)))
        return hostController.sizeThatFits(in: size)
    }
}
