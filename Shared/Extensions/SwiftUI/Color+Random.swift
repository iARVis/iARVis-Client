//
//  Color+Random.swift
//  iARVis
//
//  Created by Anonymous on 2022/9/26.
//

import SwiftUI
extension Color {
    static var random: Color {
        return Color(
            red: .random(in: 0 ... 1),
            green: .random(in: 0 ... 1),
            blue: .random(in: 0 ... 1)
        )
    }
}
