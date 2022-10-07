//
//  Collection+Safe.swift
//  iARVis
//
//  Created by Anonymous on 2022/8/14.
//

import Foundation

extension Collection {
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    @inlinable
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
