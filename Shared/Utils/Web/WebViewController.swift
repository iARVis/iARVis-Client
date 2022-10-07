//
//  WebViewController.swift
//  iARVis (iOS)
//
//  Created by Anonymous on 2022/8/29.
//

import Foundation
import UIKit
import SafariServices

class WebViewController: PartialViewController {
    private var url: URL

    init(url: URL) {
        self.url = url
        super.init(direction: .center, viewSize: (.proportion(0.9), .proportion(0.9)))
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sfVC = SFSafariViewController(url: url)
        addChildViewController(sfVC, addConstrains: true)
    }
}
