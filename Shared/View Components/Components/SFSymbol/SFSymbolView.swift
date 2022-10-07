//
//  SFSymbolView.swift
//  iARVis (iOS)
//
//  Created by Anonymous on 2022/9/5.
//

import SwiftUI

struct SFSymbolView: View {
    let name: String
    let size: CGFloat?

    init(name: String, size: CGFloat? = nil) {
        self.name = name
        self.size = size
    }

    var body: some View {
        let imageView = Image(systemName: name)
            .symbolRenderingMode(.multicolor)
            .font(.system(size: size ?? 17))
        if #available(iOS 16, *) {
            let renderer = ImageRenderer(content: imageView, scale: 3.0)
            if let image = renderer.cgImage {
                Image(cgImage: image)
                    .resizable(true)
                    .frame(width: CGFloat(image.width) / 3, height: CGFloat(image.height) / 3)
            }
        } else {
            imageView
        }
    }
}

struct SFSymbolView_Previews: PreviewProvider {
    static var previews: some View {
        SFSymbolView(name: "sum.max.fill")
    }
}

@available(iOS 16, *)
extension ImageRenderer {
    @MainActor
    convenience init(content: Content, scale: CGFloat) {
        self.init(content: content)
        self.scale = scale
    }
}
