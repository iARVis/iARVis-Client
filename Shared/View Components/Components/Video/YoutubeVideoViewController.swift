//
//  YoutubeVideoViewController.swift
//  iARVis (iOS)
//
//  Created by Anonymous on 2022/8/24.
//

import Foundation
import UIKit
import WebKit

class YoutubeVideoViewController: PartialViewController {
    var url: String

    init(url: String) {
        self.url = url
        super.init(direction: .center, viewSize: (.proportion(0.9), .proportion(0.9)))
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = webViewForYoutube()
    }

    private func webViewForYoutube() -> WKWebView {
        let videoWebView = WKWebView()
        videoWebView.scrollView.isScrollEnabled = false
        if let videoID = url.youtubeVideoID {
            let embedHTML = """
            <html>
                <head>
                    <style type="text/css">
                        body {
                            background-color: transparent;
                            color: white;
                        }
                    </style>
                </head>
                <body style="margin: 0">
                    <embed id="yt" src="http://www.youtube.com/v/\(videoID)" type="application/x-shockwave-flash" width="100%" height="100%"></embed>
                </body>
            </html>
            """
            videoWebView.loadHTMLString(embedHTML, baseURL: nil)
        }
        return videoWebView
    }
}

/// - seealso: https://devforums.apple.com/message/705665#705665
/// extractYoutubeVideoID: works for the following URL formats:
/// www.youtube.com/v/VIDEOID
/// www.youtube.com?v=VIDEOID
/// www.youtube.com/watch?v=WHsHKzYOV2E&feature=youtu.be
/// www.youtube.com/watch?v=WHsHKzYOV2E
/// youtu.be/KFPtWedl7wg_U923
/// www.youtube.com/watch?feature=player_detailpage&v=WHsHKzYOV2E#t=31s
/// youtube.googleapis.com/v/WHsHKzYOV2E
extension String {
    var youtubeVideoID: String? {
        let regexString = "(?<=v(=|/))([-a-zA-Z0-9_]+)|(?<=youtu.be/)([-a-zA-Z0-9_]+)"
        var regex: NSRegularExpression?
        do {
            regex = try NSRegularExpression(pattern: regexString, options: .caseInsensitive)
        } catch {}
        let rangeOfFirstMatch = regex?.rangeOfFirstMatch(in: self, options: [], range: NSRange(location: 0, length: count))

        if let rangeOfFirstMatch = rangeOfFirstMatch {
            if !NSEqualRanges(rangeOfFirstMatch, NSRange(location: NSNotFound, length: 0)) {
                let substringForFirstMatch = (self as NSString).substring(with: rangeOfFirstMatch)

                return substringForFirstMatch
            }
        }

        return nil
    }
}
