//
//  JSON+Hashable.swift
//  iARVis (iOS)
//
//  Created by Anonymous on 2022/9/28.
//

import Foundation
import SwiftyJSON

extension JSON: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(prettyJSON)
    }
}
