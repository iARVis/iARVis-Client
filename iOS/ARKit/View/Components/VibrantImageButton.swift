//
//  VibrantImageButton.swift
//  iARVis (iOS)
//
//  Created by Anonymous on 2022/9/15.
//

import SwiftUI

struct VibrantImageButton: View {
    let systemName: String
    let action: (() -> Void)

    init(systemName: String, action: @escaping () -> Void) {
        self.systemName = systemName
        self.action = action
    }

    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: systemName)
                .font(.system(size: 23, weight: .medium))
                .foregroundColor(.white)
                .frame(minWidth: 70, minHeight: 45)
                .background(.ultraThinMaterial)
                .cornerRadius(12, style: .continuous)
        }
    }
}

func vibrantButton(systemImage: String, action: @escaping () -> Void) -> UIViewController {
    let viewController = UIHostingController(rootView: VibrantImageButton(systemName: systemImage, action: action), ignoreSafeArea: true)
    viewController.view.backgroundColor = .clear
    return viewController
}

struct VibrantImageButton_Previews: PreviewProvider {
    static var previews: some View {
        VibrantImageButton(systemName: "arrow.up.left.and.arrow.down.right", action: {})
    }
}
