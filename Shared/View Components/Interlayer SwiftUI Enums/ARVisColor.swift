//
//  ARVisColor.swift
//  iARVis (iOS)
//
//  Created by Anonymous on 2022/8/10.
//

import Foundation
import SwiftUI
import UIColorHexSwift

#if os(iOS)
    import UIKit
    typealias NativeColor = UIColor
#elseif os(macOS)
    import AppKit
    typealias NativeColor = NSColor
#endif

enum ARVisColor: Hashable {
    case black
    case blue
    case brown
    case clear
    case cyan
    case gray
    case green
    case indigo
    case mint
    case orange
    case pink
    case purple
    case red
    case teal
    case white
    case yellow
    case rgba(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1.0)
    case rgba256(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 255.0)
    case rgbaHex(string: String)

    init(_ color: Color) {
        let components = color.components
        self = .rgba(r: components.red, g: components.green, b: components.blue, a: components.opacity)
    }
}

extension ARVisColor {
    func toSwiftUIColor() -> SwiftUI.Color {
        switch self {
        case .black:
            return .black
        case .blue:
            return .blue
        case .brown:
            return .brown
        case .clear:
            return .clear
        case .cyan:
            return .cyan
        case .gray:
            return .gray
        case .green:
            return .green
        case .indigo:
            return .indigo
        case .mint:
            return .mint
        case .orange:
            return .orange
        case .pink:
            return .pink
        case .purple:
            return .purple
        case .red:
            return .red
        case .teal:
            return .teal
        case .white:
            return .white
        case .yellow:
            return .yellow
        case let .rgba(r, g, b, a):
            return .init(.sRGB, red: min(1, r), green: min(1, g), blue: min(1, b), opacity: min(1, a))
        case let .rgba256(r, g, b, a):
            return .init(.sRGB, red: min(1, r / 255), green: min(1, g / 255), blue: min(1, b / 255), opacity: min(1, a / 255))
        case let .rgbaHex(string):
            return Color(rgba: string)
        }
    }
}

extension ARVisColor: RawRepresentable {
    typealias RawValue = String

    var rawValue: String {
        switch self {
        case .black:
            return "black"
        case .blue:
            return "blue"
        case .brown:
            return "brown"
        case .clear:
            return "clear"
        case .cyan:
            return "cyan"
        case .gray:
            return "gray"
        case .green:
            return "green"
        case .indigo:
            return "indigo"
        case .mint:
            return "mint"
        case .orange:
            return "orange"
        case .pink:
            return "pink"
        case .purple:
            return "purple"
        case .red:
            return "red"
        case .teal:
            return "teal"
        case .white:
            return "white"
        case .yellow:
            return "yellow"
        default:
            return ""
        }
    }

    init?(rawValue: String) {
        switch rawValue {
        case "black":
            self = .black
        case "blue":
            self = .blue
        case "brown":
            self = .brown
        case "clear":
            self = .clear
        case "cyan":
            self = .cyan
        case "gray":
            self = .gray
        case "green":
            self = .green
        case "indigo":
            self = .indigo
        case "mint":
            self = .mint
        case "orange":
            self = .orange
        case "pink":
            self = .pink
        case "purple":
            self = .purple
        case "red":
            self = .red
        case "teal":
            self = .teal
        case "white":
            self = .white
        case "yellow":
            self = .yellow
        default:
            return nil
        }
    }
}

extension ARVisColor: CustomStringConvertible {
    var description: String {
        if rawValue != "" {
            return rawValue
        }

        if case let .rgbaHex(string) = self {
            return string
        }

        if case let .rgba(r, g, b, a) = self {
            return "(\(Int(r * 255)), \(Int(g * 255)), \(Int(b * 255)), \(Int(a * 255)))"
        }

        if case let .rgba256(r, g, b, a) = self {
            return "(\(r), \(g), \(b), \(a))"
        }

        return ""
    }
}

extension ARVisColor: Codable {
    enum CodingKeys: String, CodingKey {
        case rgba
        case rgba256
        case rgbaString
    }

    fileprivate enum DumbARVisColor: Codable {
        case rgba(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat)
        case rgba256(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat)

        init?(_ avColor: ARVisColor) {
            switch avColor {
            case let .rgba(r, g, b, a):
                self = .rgba(r: r, g: g, b: b, a: a)
            case let .rgba256(r, g, b, a):
                self = .rgba256(r: r, g: g, b: b, a: a)
            default:
                return nil
            }
        }
    }

    fileprivate init?(_ dumbAVColor: DumbARVisColor) {
        switch dumbAVColor {
        case let .rgba(r, g, b, a):
            self = .rgba(r: r, g: g, b: b, a: a)
        case let .rgba256(r, g, b, a):
            self = .rgba256(r: r, g: g, b: b, a: a)
        }
    }

    private static func checkHexStringValidity(string hexString: String) throws -> Bool {
        guard hexString.hasPrefix("#") else {
            let error = PlatformColorInputError.missingHashMarkAsPrefix(hexString)
            throw error
        }

        switch hexString.dropFirst().count {
        case 3:
            return true
        case 4:
            return true
        case 6:
            return true
        case 8:
            return true
        default:
            let error = PlatformColorInputError.mismatchedHexStringLength(hexString)
            throw error
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .black, .blue, .brown, .clear, .cyan, .gray, .green, .indigo, .mint, .orange, .pink, .purple, .red, .teal, .white, .yellow:
            try container.encode("\(self)")
        case .rgba, .rgba256:
            try container.encode(DumbARVisColor(self))
        case let .rgbaHex(string):
            try container.encode(string)
        }
    }

    init(from decoder: Decoder) throws {
        let context = DecodingError.Context(
            codingPath: [],
            debugDescription: "Data corrupted."
        )

        if let container = try? decoder.container(keyedBy: CodingKeys.self) {
            // rgb, rgba
            if container.allKeys.count != 1 {
                let context = DecodingError.Context(
                    codingPath: container.codingPath,
                    debugDescription: "Invalid number of keys found, expected one."
                )
                throw DecodingError.typeMismatch(ARVisColor.self, context)
            }

            let container = try decoder.singleValueContainer()
            let dumbAVColor = try container.decode(DumbARVisColor.self)
            if let avColor = ARVisColor(dumbAVColor) {
                self = avColor
            } else {
                throw DecodingError.dataCorrupted(context)
            }
        } else if let container = try? decoder.singleValueContainer() {
            // single value
            let decodeResultString = try container.decode(String.self)
            if let decodeResult = ARVisColor(rawValue: decodeResultString) {
                // blue, white, gray...
                self = decodeResult
            } else if try ARVisColor.checkHexStringValidity(string: decodeResultString) {
                self = .rgbaHex(string: decodeResultString)
            } else {
                let context = DecodingError.Context(
                    codingPath: container.codingPath,
                    debugDescription: "Invalid string found: \(decodeResultString)."
                )
                throw DecodingError.dataCorrupted(context)
            }
        } else {
            // Never Enter Here
            throw DecodingError.dataCorrupted(context)
        }
    }
}

extension SwiftUI.Color {
    init?(_ color: ARVisColor?) {
        guard let color = color else {
            return nil
        }
        self = color.toSwiftUIColor()
    }

    init(_ color: ARVisColor) {
        self = color.toSwiftUIColor()
    }
}

extension Color {
    var components: (red: CGFloat, green: CGFloat, blue: CGFloat, opacity: CGFloat) {
        if let components = self.cgColor?.components {
            let r: CGFloat = components[safe: 0] ?? 0
            let g: CGFloat = components[safe: 1] ?? 0
            let b: CGFloat = components[safe: 2] ?? 0
            let o: CGFloat = components[safe: 3] ?? 0

            return (r, g, b, o)
        }

        return (0, 0, 0, 0)
    }

    var hexString: String {
        let components = components
        let rIntValue = components.red * 255
        let rHexValue = String(format: "%02X", Int(rIntValue))
        let gIntValue = components.green * 255
        let gHexValue = String(format: "%02X", Int(gIntValue))
        let bIntValue = components.blue * 255
        let bHexValue = String(format: "%02X", Int(bIntValue))
        let aIntValue = components.opacity * 255
        let aHexValue = String(format: "%02X", Int(aIntValue))

        return "#\(rHexValue)\(gHexValue)\(bHexValue)\(aHexValue)"
    }
}

struct ARVisColorWrapper: Codable {
    var color: ARVisColor
}
