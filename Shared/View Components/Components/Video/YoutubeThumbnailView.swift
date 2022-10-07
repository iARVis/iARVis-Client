//
//  YoutubeThumbnailView.swift
//  iARVis (iOS)
//
//  Created by Anonymous on 2022/8/24.
//

import Foundation
import Kingfisher
import SwiftUI
import UIKit
import WebKit

struct YoutubeThumbnailView: View {
    @State var url: String

    var body: some View {
        if let videoId = url.youtubeVideoID {
            KFImage(URL(string: "https://i3.ytimg.com/vi/\(videoId)/maxresdefault.jpg"))
                .placeholder {
                    Image(systemName: "arrow.2.circlepath.circle")
                        .font(.largeTitle)
                        .opacity(0.3)
                }
                .resizable()
                .aspectRatio(contentMode: ContentMode.fit)
                .overlay {
                    Button {
                        UIApplication.shared.presentOnTop(YoutubeVideoViewController(url: url))
                    } label: {
                        Circle()
                            .frame(width: 50, height: 50)
                            .background(.ultraThinMaterial)
                            .clipShape(Circle())
                            .overlay {
                                Image(systemName: "play.fill")
                                    .imageScale(.large)
                            }
                    }
                    .buttonStyle(.plain)
                }
        }
    }
}

struct YoutubeThumbnailView_Previews: PreviewProvider {
    static var previews: some View {
        YoutubeThumbnailView(url: "https://youtu.be/D7WdO4DcHaA")
    }
}
