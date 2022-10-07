//
//  ViewElementComponent.swift
//  iARVis (iOS)
//
//  Created by Anonymous on 2022/8/10.
//

import AVKit
import Foundation
import Kingfisher
import SwiftUI
import SwiftyJSON
#if os(iOS)
    import VideoPlayer
#endif

enum ViewElementClickAction: Codable, Hashable {
    case openURL(url: String)
}

enum ViewElementComponentModifier: Codable, Hashable {
    case padding(leading: CGFloat?, trailing: CGFloat?, top: CGFloat?, bottom: CGFloat?)
    case background(color: ARVisColor)
    case roundedCorner(radius: CGFloat)
    case onTap(action: ViewElementClickAction)
}

extension View {
    func apply(modifier: ViewElementComponentModifier) -> AnyView {
        switch modifier {
        case let .padding(leading, trailing, top, bottom):
            return AnyView(padding(.leading, leading)
                .padding(.trailing, trailing)
                .padding(.top, top)
                .padding(.bottom, bottom))
        case let .background(color):
            return AnyView(background(.init(color)))
        case let .roundedCorner(radius):
            return AnyView(cornerRadius(radius, style: .continuous))
        case let .onTap(action: action):
            switch action {
            case let .openURL(url):
                if let url = URL(string: url) {
                    return AnyView(onTapGesture {
                        UIApplication.shared.open(url)
                    })
                }
            }
        }

        return AnyView(self)
    }

    func apply(modifiers: [ViewElementComponentModifier]) -> AnyView {
        var res = AnyView(self)
        for modifier in modifiers {
            res = res.apply(modifier: modifier)
        }
        return res
    }
}

enum ViewElementComponent: Codable, Hashable {
    // font
    case text(content: String, multilineTextAlignment: ARVisTextAlignment? = nil, fontStyle: ARVisFontStyle? = nil, modifiers: [ViewElementComponentModifier]? = nil)
    case image(url: String, contentMode: ARVisContentMode = .fit, width: CGFloat? = nil, height: CGFloat? = nil, clipToCircle: Bool? = nil, modifiers: [ViewElementComponentModifier]? = nil)
    case sfSymbol(name: String, size: CGFloat? = nil, modifiers: [ViewElementComponentModifier]? = nil)
    case audio(title: String? = nil, url: String, modifiers: [ViewElementComponentModifier]? = nil)
    case video(url: String, width: CGFloat? = nil, height: CGFloat? = nil, modifiers: [ViewElementComponentModifier]? = nil)
    case link(url: String, modifiers: [ViewElementComponentModifier]? = nil)
    //    case superLink(link: AnyView, modifiers: [ViewElementComponentModifier]? = nil)
    case hStack(elements: [ViewElementComponent], alignment: ARVisVerticalAlignment? = nil, spacing: CGFloat? = nil, modifiers: [ViewElementComponentModifier]? = nil)
    case vStack(elements: [ViewElementComponent], alignment: ARVisHorizontalAlignment? = nil, spacing: CGFloat? = nil, modifiers: [ViewElementComponentModifier]? = nil)
    case spacer
    case divider(opacity: CGFloat = 0.5, modifiers: [ViewElementComponentModifier]? = nil)
    case table(configuration: TableConfiguration, modifiers: [ViewElementComponentModifier]? = nil)
    case chart(configuration: ChartConfiguration)
    case segmentedControl(items: [ARVisSegmentedControlItem], modifiers: [ViewElementComponentModifier]? = nil)
    case grid(rows: [ViewElementComponent], modifiers: [ViewElementComponentModifier]? = nil)
    case gridRow(rowElements: [ViewElementComponent], modifiers: [ViewElementComponentModifier]? = nil)
    case splom(data: JSON, fields: [String], labels: [String]? = nil, config: ChartComponentCommonConfig? = nil)

    enum CodingKeys: CodingKey {
        case text
        case image
        case sfSymbol
        case audio
        case video
        case link
        case hStack
        case vStack
        case spacer
        case divider
        case table
        case chart
        case segmentedControl
        case grid
        case gridRow
        case splom
    }

    enum TextCodingKeys: CodingKey {
        case content
        case multilineTextAlignment
        case fontStyle
        case modifiers
    }

    enum ImageCodingKeys: CodingKey {
        case url
        case contentMode
        case width
        case height
        case clipToCircle
        case modifiers
    }

    enum SfSymbolCodingKeys: CodingKey {
        case name
        case size
        case modifiers
    }

    enum AudioCodingKeys: CodingKey {
        case title
        case url
        case modifiers
    }

    enum VideoCodingKeys: CodingKey {
        case url
        case width
        case height
        case modifiers
    }

    enum LinkCodingKeys: CodingKey {
        case url
        case modifiers
    }

    enum HStackCodingKeys: CodingKey {
        case elements
        case alignment
        case spacing
        case modifiers
    }

    enum VStackCodingKeys: CodingKey {
        case elements
        case alignment
        case spacing
        case modifiers
    }

    enum SpacerCodingKeys: CodingKey {}

    enum DividerCodingKeys: CodingKey {
        case opacity
        case modifiers
    }

    enum TableCodingKeys: CodingKey {
        case configuration
        case modifiers
    }

    enum ChartCodingKeys: CodingKey {
        case configuration
    }

    enum SegmentedControlCodingKeys: CodingKey {
        case items
        case modifiers
    }

    enum GridCodingKeys: CodingKey {
        case rows
        case modifiers
    }

    enum GridRowCodingKeys: CodingKey {
        case rowElements
        case modifiers
    }

    enum SplomCodingKeys: CodingKey {
        case data
        case fields
        case labels
        case config
    }

    init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<ViewElementComponent.CodingKeys> = try decoder.container(keyedBy: ViewElementComponent.CodingKeys.self)
        var allKeys = ArraySlice<ViewElementComponent.CodingKeys>(container.allKeys)
        guard let onlyKey = allKeys.popFirst(), allKeys.isEmpty else {
            throw DecodingError.typeMismatch(ViewElementComponent.self, DecodingError.Context(codingPath: container.codingPath, debugDescription: "Invalid number of keys found, expected one.", underlyingError: nil))
        }
        switch onlyKey {
        case .text:
            let nestedContainer: KeyedDecodingContainer<ViewElementComponent.TextCodingKeys> = try container.nestedContainer(keyedBy: ViewElementComponent.TextCodingKeys.self, forKey: ViewElementComponent.CodingKeys.text)
            self = ViewElementComponent.text(content: try nestedContainer.decode(String.self, forKey: ViewElementComponent.TextCodingKeys.content), multilineTextAlignment: try nestedContainer.decodeIfPresent(ARVisTextAlignment.self, forKey: ViewElementComponent.TextCodingKeys.multilineTextAlignment), fontStyle: try nestedContainer.decodeIfPresent(ARVisFontStyle.self, forKey: ViewElementComponent.TextCodingKeys.fontStyle), modifiers: try nestedContainer.decodeIfPresent([ViewElementComponentModifier].self, forKey: ViewElementComponent.TextCodingKeys.modifiers))
        case .image:
            let nestedContainer: KeyedDecodingContainer<ViewElementComponent.ImageCodingKeys> = try container.nestedContainer(keyedBy: ViewElementComponent.ImageCodingKeys.self, forKey: ViewElementComponent.CodingKeys.image)
            self = ViewElementComponent.image(url: try nestedContainer.decode(String.self, forKey: ViewElementComponent.ImageCodingKeys.url), contentMode: try nestedContainer.decode(ARVisContentMode.self, forKey: ViewElementComponent.ImageCodingKeys.contentMode), width: try nestedContainer.decodeIfPresent(CGFloat.self, forKey: ViewElementComponent.ImageCodingKeys.width), height: try nestedContainer.decodeIfPresent(CGFloat.self, forKey: ViewElementComponent.ImageCodingKeys.height), clipToCircle: try nestedContainer.decodeIfPresent(Bool.self, forKey: ViewElementComponent.ImageCodingKeys.clipToCircle), modifiers: try nestedContainer.decodeIfPresent([ViewElementComponentModifier].self, forKey: ViewElementComponent.ImageCodingKeys.modifiers))
        case .sfSymbol:
            let nestedContainer: KeyedDecodingContainer<ViewElementComponent.SfSymbolCodingKeys> = try container.nestedContainer(keyedBy: ViewElementComponent.SfSymbolCodingKeys.self, forKey: ViewElementComponent.CodingKeys.sfSymbol)
            self = ViewElementComponent.sfSymbol(name: try nestedContainer.decode(String.self, forKey: ViewElementComponent.SfSymbolCodingKeys.name), size: try nestedContainer.decodeIfPresent(CGFloat.self, forKey: ViewElementComponent.SfSymbolCodingKeys.size), modifiers: try nestedContainer.decodeIfPresent([ViewElementComponentModifier].self, forKey: ViewElementComponent.SfSymbolCodingKeys.modifiers))
        case .audio:
            let nestedContainer: KeyedDecodingContainer<ViewElementComponent.AudioCodingKeys> = try container.nestedContainer(keyedBy: ViewElementComponent.AudioCodingKeys.self, forKey: ViewElementComponent.CodingKeys.audio)
            self = ViewElementComponent.audio(title: try nestedContainer.decodeIfPresent(String.self, forKey: ViewElementComponent.AudioCodingKeys.title), url: try nestedContainer.decode(String.self, forKey: ViewElementComponent.AudioCodingKeys.url), modifiers: try nestedContainer.decodeIfPresent([ViewElementComponentModifier].self, forKey: ViewElementComponent.AudioCodingKeys.modifiers))
        case .video:
            let nestedContainer: KeyedDecodingContainer<ViewElementComponent.VideoCodingKeys> = try container.nestedContainer(keyedBy: ViewElementComponent.VideoCodingKeys.self, forKey: ViewElementComponent.CodingKeys.video)
            self = ViewElementComponent.video(url: try nestedContainer.decode(String.self, forKey: ViewElementComponent.VideoCodingKeys.url), width: try nestedContainer.decodeIfPresent(CGFloat.self, forKey: ViewElementComponent.VideoCodingKeys.width), height: try nestedContainer.decodeIfPresent(CGFloat.self, forKey: ViewElementComponent.VideoCodingKeys.height), modifiers: try nestedContainer.decodeIfPresent([ViewElementComponentModifier].self, forKey: ViewElementComponent.VideoCodingKeys.modifiers))
        case .link:
            let nestedContainer: KeyedDecodingContainer<ViewElementComponent.LinkCodingKeys> = try container.nestedContainer(keyedBy: ViewElementComponent.LinkCodingKeys.self, forKey: ViewElementComponent.CodingKeys.link)
            self = ViewElementComponent.link(url: try nestedContainer.decode(String.self, forKey: ViewElementComponent.LinkCodingKeys.url), modifiers: try nestedContainer.decodeIfPresent([ViewElementComponentModifier].self, forKey: ViewElementComponent.LinkCodingKeys.modifiers))
        case .hStack:
            let nestedContainer: KeyedDecodingContainer<ViewElementComponent.HStackCodingKeys> = try container.nestedContainer(keyedBy: ViewElementComponent.HStackCodingKeys.self, forKey: ViewElementComponent.CodingKeys.hStack)
            self = ViewElementComponent.hStack(elements: try nestedContainer.decode([ViewElementComponent].self, forKey: ViewElementComponent.HStackCodingKeys.elements), alignment: try nestedContainer.decodeIfPresent(ARVisVerticalAlignment.self, forKey: ViewElementComponent.HStackCodingKeys.alignment), spacing: try nestedContainer.decodeIfPresent(CGFloat.self, forKey: ViewElementComponent.HStackCodingKeys.spacing), modifiers: try nestedContainer.decodeIfPresent([ViewElementComponentModifier].self, forKey: ViewElementComponent.HStackCodingKeys.modifiers))
        case .vStack:
            let nestedContainer: KeyedDecodingContainer<ViewElementComponent.VStackCodingKeys> = try container.nestedContainer(keyedBy: ViewElementComponent.VStackCodingKeys.self, forKey: ViewElementComponent.CodingKeys.vStack)
            self = ViewElementComponent.vStack(elements: try nestedContainer.decode([ViewElementComponent].self, forKey: ViewElementComponent.VStackCodingKeys.elements), alignment: try nestedContainer.decodeIfPresent(ARVisHorizontalAlignment.self, forKey: ViewElementComponent.VStackCodingKeys.alignment), spacing: try nestedContainer.decodeIfPresent(CGFloat.self, forKey: ViewElementComponent.VStackCodingKeys.spacing), modifiers: try nestedContainer.decodeIfPresent([ViewElementComponentModifier].self, forKey: ViewElementComponent.VStackCodingKeys.modifiers))
        case .spacer:
            let _: KeyedDecodingContainer<ViewElementComponent.SpacerCodingKeys> = try container.nestedContainer(keyedBy: ViewElementComponent.SpacerCodingKeys.self, forKey: ViewElementComponent.CodingKeys.spacer)
            self = ViewElementComponent.spacer
        case .divider:
            let nestedContainer: KeyedDecodingContainer<ViewElementComponent.DividerCodingKeys> = try container.nestedContainer(keyedBy: ViewElementComponent.DividerCodingKeys.self, forKey: ViewElementComponent.CodingKeys.divider)
            self = ViewElementComponent.divider(opacity: try nestedContainer.decode(CGFloat.self, forKey: ViewElementComponent.DividerCodingKeys.opacity), modifiers: try nestedContainer.decodeIfPresent([ViewElementComponentModifier].self, forKey: ViewElementComponent.DividerCodingKeys.modifiers))
        case .table:
            let nestedContainer: KeyedDecodingContainer<ViewElementComponent.TableCodingKeys> = try container.nestedContainer(keyedBy: ViewElementComponent.TableCodingKeys.self, forKey: ViewElementComponent.CodingKeys.table)
            self = ViewElementComponent.table(configuration: try nestedContainer.decode(TableConfiguration.self, forKey: ViewElementComponent.TableCodingKeys.configuration), modifiers: try nestedContainer.decodeIfPresent([ViewElementComponentModifier].self, forKey: ViewElementComponent.TableCodingKeys.modifiers))
        case .chart:
            if #available(iOS 16, *) {
                let dict = try container.decode([String: Any].self, forKey: .chart)
                let json = JSON(dict)
                self = ViewElementComponent.chart(configuration: ChartConfigurationJSONParser.default.parse(json))
            } else {
                self = .text(content: "Chart component is not supported in iOS 15.")
            }
        case .segmentedControl:
            let nestedContainer: KeyedDecodingContainer<ViewElementComponent.SegmentedControlCodingKeys> = try container.nestedContainer(keyedBy: ViewElementComponent.SegmentedControlCodingKeys.self, forKey: ViewElementComponent.CodingKeys.segmentedControl)
            self = ViewElementComponent.segmentedControl(items: try nestedContainer.decode([ARVisSegmentedControlItem].self, forKey: ViewElementComponent.SegmentedControlCodingKeys.items), modifiers: try nestedContainer.decodeIfPresent([ViewElementComponentModifier].self, forKey: ViewElementComponent.SegmentedControlCodingKeys.modifiers))
        case .grid:
            let nestedContainer: KeyedDecodingContainer<ViewElementComponent.GridCodingKeys> = try container.nestedContainer(keyedBy: ViewElementComponent.GridCodingKeys.self, forKey: ViewElementComponent.CodingKeys.grid)
            self = ViewElementComponent.grid(rows: try nestedContainer.decode([ViewElementComponent].self, forKey: ViewElementComponent.GridCodingKeys.rows), modifiers: try nestedContainer.decodeIfPresent([ViewElementComponentModifier].self, forKey: ViewElementComponent.GridCodingKeys.modifiers))
        case .gridRow:
            let nestedContainer: KeyedDecodingContainer<ViewElementComponent.GridRowCodingKeys> = try container.nestedContainer(keyedBy: ViewElementComponent.GridRowCodingKeys.self, forKey: ViewElementComponent.CodingKeys.gridRow)
            self = ViewElementComponent.gridRow(rowElements: try nestedContainer.decode([ViewElementComponent].self, forKey: ViewElementComponent.GridRowCodingKeys.rowElements), modifiers: try nestedContainer.decodeIfPresent([ViewElementComponentModifier].self, forKey: ViewElementComponent.GridRowCodingKeys.modifiers))
        case .splom:
            let nestedContainer: KeyedDecodingContainer<ViewElementComponent.SplomCodingKeys> = try container.nestedContainer(keyedBy: ViewElementComponent.SplomCodingKeys.self, forKey: ViewElementComponent.CodingKeys.splom)
            self = ViewElementComponent.splom(data: try nestedContainer.decode(JSON.self, forKey: ViewElementComponent.SplomCodingKeys.data), fields: try nestedContainer.decode([String].self, forKey: ViewElementComponent.SplomCodingKeys.fields), labels: try nestedContainer.decode([String].self, forKey: ViewElementComponent.SplomCodingKeys.labels), config: try nestedContainer.decodeIfPresent(ChartComponentCommonConfig.self, forKey: ViewElementComponent.SplomCodingKeys.config))
        }
    }

    func encode(to encoder: Encoder) throws {
        var container: KeyedEncodingContainer<ViewElementComponent.CodingKeys> = encoder.container(keyedBy: ViewElementComponent.CodingKeys.self)
        switch self {
        case let .text(content, multilineTextAlignment, fontStyle, modifiers):
            var nestedContainer: KeyedEncodingContainer<ViewElementComponent.TextCodingKeys> = container.nestedContainer(keyedBy: ViewElementComponent.TextCodingKeys.self, forKey: ViewElementComponent.CodingKeys.text)
            try nestedContainer.encode(content, forKey: ViewElementComponent.TextCodingKeys.content)
            try nestedContainer.encodeIfPresent(multilineTextAlignment, forKey: ViewElementComponent.TextCodingKeys.multilineTextAlignment)
            try nestedContainer.encodeIfPresent(fontStyle, forKey: ViewElementComponent.TextCodingKeys.fontStyle)
            try nestedContainer.encodeIfPresent(modifiers, forKey: ViewElementComponent.TextCodingKeys.modifiers)
        case let .image(url, contentMode, width, height, clipToCircle, modifiers):
            var nestedContainer: KeyedEncodingContainer<ViewElementComponent.ImageCodingKeys> = container.nestedContainer(keyedBy: ViewElementComponent.ImageCodingKeys.self, forKey: ViewElementComponent.CodingKeys.image)
            try nestedContainer.encode(url, forKey: ViewElementComponent.ImageCodingKeys.url)
            try nestedContainer.encode(contentMode, forKey: ViewElementComponent.ImageCodingKeys.contentMode)
            try nestedContainer.encodeIfPresent(width, forKey: ViewElementComponent.ImageCodingKeys.width)
            try nestedContainer.encodeIfPresent(height, forKey: ViewElementComponent.ImageCodingKeys.height)
            try nestedContainer.encodeIfPresent(clipToCircle, forKey: ViewElementComponent.ImageCodingKeys.clipToCircle)
            try nestedContainer.encodeIfPresent(modifiers, forKey: ViewElementComponent.ImageCodingKeys.modifiers)
        case let .sfSymbol(name, size, modifiers):
            var nestedContainer: KeyedEncodingContainer<ViewElementComponent.SfSymbolCodingKeys> = container.nestedContainer(keyedBy: ViewElementComponent.SfSymbolCodingKeys.self, forKey: ViewElementComponent.CodingKeys.sfSymbol)
            try nestedContainer.encode(name, forKey: ViewElementComponent.SfSymbolCodingKeys.name)
            try nestedContainer.encodeIfPresent(size, forKey: ViewElementComponent.SfSymbolCodingKeys.size)
            try nestedContainer.encodeIfPresent(modifiers, forKey: ViewElementComponent.SfSymbolCodingKeys.modifiers)
        case let .audio(title, url, modifiers):
            var nestedContainer: KeyedEncodingContainer<ViewElementComponent.AudioCodingKeys> = container.nestedContainer(keyedBy: ViewElementComponent.AudioCodingKeys.self, forKey: ViewElementComponent.CodingKeys.audio)
            try nestedContainer.encodeIfPresent(title, forKey: ViewElementComponent.AudioCodingKeys.title)
            try nestedContainer.encode(url, forKey: ViewElementComponent.AudioCodingKeys.url)
            try nestedContainer.encodeIfPresent(modifiers, forKey: ViewElementComponent.AudioCodingKeys.modifiers)
        case let .video(url, width, height, modifiers):
            var nestedContainer: KeyedEncodingContainer<ViewElementComponent.VideoCodingKeys> = container.nestedContainer(keyedBy: ViewElementComponent.VideoCodingKeys.self, forKey: ViewElementComponent.CodingKeys.video)
            try nestedContainer.encode(url, forKey: ViewElementComponent.VideoCodingKeys.url)
            try nestedContainer.encodeIfPresent(width, forKey: ViewElementComponent.VideoCodingKeys.width)
            try nestedContainer.encodeIfPresent(height, forKey: ViewElementComponent.VideoCodingKeys.height)
            try nestedContainer.encodeIfPresent(modifiers, forKey: ViewElementComponent.VideoCodingKeys.modifiers)
        case let .link(url, modifiers):
            var nestedContainer: KeyedEncodingContainer<ViewElementComponent.LinkCodingKeys> = container.nestedContainer(keyedBy: ViewElementComponent.LinkCodingKeys.self, forKey: ViewElementComponent.CodingKeys.link)
            try nestedContainer.encode(url, forKey: ViewElementComponent.LinkCodingKeys.url)
            try nestedContainer.encodeIfPresent(modifiers, forKey: ViewElementComponent.LinkCodingKeys.modifiers)
        case let .hStack(elements, alignment, spacing, modifiers):
            var nestedContainer: KeyedEncodingContainer<ViewElementComponent.HStackCodingKeys> = container.nestedContainer(keyedBy: ViewElementComponent.HStackCodingKeys.self, forKey: ViewElementComponent.CodingKeys.hStack)
            try nestedContainer.encode(elements, forKey: ViewElementComponent.HStackCodingKeys.elements)
            try nestedContainer.encodeIfPresent(alignment, forKey: ViewElementComponent.HStackCodingKeys.alignment)
            try nestedContainer.encodeIfPresent(spacing, forKey: ViewElementComponent.HStackCodingKeys.spacing)
            try nestedContainer.encodeIfPresent(modifiers, forKey: ViewElementComponent.HStackCodingKeys.modifiers)
        case let .vStack(elements, alignment, spacing, modifiers):
            var nestedContainer: KeyedEncodingContainer<ViewElementComponent.VStackCodingKeys> = container.nestedContainer(keyedBy: ViewElementComponent.VStackCodingKeys.self, forKey: ViewElementComponent.CodingKeys.vStack)
            try nestedContainer.encode(elements, forKey: ViewElementComponent.VStackCodingKeys.elements)
            try nestedContainer.encodeIfPresent(alignment, forKey: ViewElementComponent.VStackCodingKeys.alignment)
            try nestedContainer.encodeIfPresent(spacing, forKey: ViewElementComponent.VStackCodingKeys.spacing)
            try nestedContainer.encodeIfPresent(modifiers, forKey: ViewElementComponent.VStackCodingKeys.modifiers)
        case .spacer:
            var _: KeyedEncodingContainer<ViewElementComponent.SpacerCodingKeys> = container.nestedContainer(keyedBy: ViewElementComponent.SpacerCodingKeys.self, forKey: ViewElementComponent.CodingKeys.spacer)
        case let .divider(opacity, modifiers):
            var nestedContainer: KeyedEncodingContainer<ViewElementComponent.DividerCodingKeys> = container.nestedContainer(keyedBy: ViewElementComponent.DividerCodingKeys.self, forKey: ViewElementComponent.CodingKeys.divider)
            try nestedContainer.encode(opacity, forKey: ViewElementComponent.DividerCodingKeys.opacity)
            try nestedContainer.encodeIfPresent(modifiers, forKey: ViewElementComponent.DividerCodingKeys.modifiers)
        case let .table(configuration, modifiers):
            var nestedContainer: KeyedEncodingContainer<ViewElementComponent.TableCodingKeys> = container.nestedContainer(keyedBy: ViewElementComponent.TableCodingKeys.self, forKey: ViewElementComponent.CodingKeys.table)
            try nestedContainer.encode(configuration, forKey: ViewElementComponent.TableCodingKeys.configuration)
            try nestedContainer.encodeIfPresent(modifiers, forKey: ViewElementComponent.TableCodingKeys.modifiers)
        case let .chart(configuration):
            if #available(iOS 16, *) {
                if let encodedDict = ChartConfigurationJSONParser.default.encode(configuration).dictionaryObject {
                    try container.encodeIfPresent(encodedDict, forKey: ViewElementComponent.CodingKeys.chart)
                }
            }
        case let .segmentedControl(items, modifiers):
            var nestedContainer: KeyedEncodingContainer<ViewElementComponent.SegmentedControlCodingKeys> = container.nestedContainer(keyedBy: ViewElementComponent.SegmentedControlCodingKeys.self, forKey: ViewElementComponent.CodingKeys.segmentedControl)
            try nestedContainer.encode(items, forKey: ViewElementComponent.SegmentedControlCodingKeys.items)
            try nestedContainer.encodeIfPresent(modifiers, forKey: ViewElementComponent.SegmentedControlCodingKeys.modifiers)
        case let .grid(rows, modifiers):
            var nestedContainer: KeyedEncodingContainer<ViewElementComponent.GridCodingKeys> = container.nestedContainer(keyedBy: ViewElementComponent.GridCodingKeys.self, forKey: ViewElementComponent.CodingKeys.grid)
            try nestedContainer.encode(rows, forKey: ViewElementComponent.GridCodingKeys.rows)
            try nestedContainer.encodeIfPresent(modifiers, forKey: ViewElementComponent.GridCodingKeys.modifiers)
        case let .gridRow(rowElements, modifiers):
            var nestedContainer: KeyedEncodingContainer<ViewElementComponent.GridRowCodingKeys> = container.nestedContainer(keyedBy: ViewElementComponent.GridRowCodingKeys.self, forKey: ViewElementComponent.CodingKeys.gridRow)
            try nestedContainer.encode(rowElements, forKey: ViewElementComponent.GridRowCodingKeys.rowElements)
            try nestedContainer.encodeIfPresent(modifiers, forKey: ViewElementComponent.GridRowCodingKeys.modifiers)
        case let .splom(data, fields, labels, config):
            var nestedContainer: KeyedEncodingContainer<ViewElementComponent.SplomCodingKeys> = container.nestedContainer(keyedBy: ViewElementComponent.SplomCodingKeys.self, forKey: ViewElementComponent.CodingKeys.splom)
            try nestedContainer.encode(data, forKey: ViewElementComponent.SplomCodingKeys.data)
            try nestedContainer.encode(fields, forKey: ViewElementComponent.SplomCodingKeys.fields)
            try nestedContainer.encodeIfPresent(labels, forKey: ViewElementComponent.SplomCodingKeys.labels)
            try nestedContainer.encodeIfPresent(config, forKey: ViewElementComponent.SplomCodingKeys.config)
        }
    }
}

extension ViewElementComponent {
    var modifiers: [ViewElementComponentModifier] {
        switch self {
        case let .text(_, _, _, modifiers):
            return modifiers ?? []
        case let .image(_, _, _, _, _, modifiers):
            return modifiers ?? []
        case let .sfSymbol(_, _, modifiers):
            return modifiers ?? []
        case let .audio(_, _, modifiers):
            return modifiers ?? []
        case let .video(_, _, _, modifiers):
            return modifiers ?? []
        case let .link(_, modifiers):
            return modifiers ?? []
        case let .hStack(_, _, _, modifiers):
            return modifiers ?? []
        case let .vStack(_, _, _, modifiers):
            return modifiers ?? []
        case .spacer:
            return []
        case let .divider(_, modifiers):
            return modifiers ?? []
        case let .table(_, modifiers):
            return modifiers ?? []
        case .chart:
            return []
        case let .segmentedControl(_, modifiers):
            return modifiers ?? []
        case let .grid(_, modifiers):
            return modifiers ?? []
        case let .gridRow(_, modifiers):
            return modifiers ?? []
        case .splom:
            return []
        }
    }
}

extension ViewElementComponent {
    @ViewBuilder
    func view() -> some View {
        let modifiers = self.modifiers
        Group {
            switch self {
            case let .text(content, multilineTextAlignment, fontStyle, _):

                Text(.init(content))
                    .font(.init(fontStyle))
                    .if(fontStyle?.color != nil, transform: { view in
                        view.foregroundColor(.init(fontStyle?.color))
                    })
                    .multilineTextAlignment(.init(multilineTextAlignment))
            case let .image(url, contentMode, width, height, clipToCircle, _):
                KFImage(URL(string: url))
                    .placeholder {
                        Image(systemName: "arrow.2.circlepath.circle")
                            .font(.largeTitle)
                            .opacity(0.3)
                    }
                    .resizable()
                    .aspectRatio(contentMode: .init(contentMode))
                    .frame(width: width, height: height)
                    .if(clipToCircle == true) { view in
                        view.clipShape(Circle())
                    }
            case let .sfSymbol(name: name, size: size, _):
                SFSymbolView(name: name, size: size)
            case let .audio(title, url, modifiers):
                AudioPlayerView(title: title, audioUrl: url)
            case let .video(url, width, height, _):
                if let url = URL(string: url),
                   let components = URLComponents(url: url, resolvingAgainstBaseURL: true),
                   let host = components.host {
                    if let _ = url.absoluteString.youtubeVideoID {
                        YoutubeThumbnailView(url: url.absoluteString)
                            .frame(width: width, height: height)
                    } else {
                        #if os(iOS)
                            VideoPlayer(url: url, play: .constant(true))
                                .frame(width: width, height: height)
                        #endif
                    }
                }
            case let .link(url, _):
                fatalError()
            case let .hStack(elements, alignment, spacing, _):
                HStack(alignment: .init(alignment), spacing: spacing) {
                    ForEach(Array(zip(elements.indices, elements)), id: \.0) { _, element in
                        AnyView(element.view())
                    }
                }
            case let .vStack(elements, alignment, spacing, _):
                VStack(alignment: .init(alignment), spacing: spacing) {
                    ForEach(Array(zip(elements.indices, elements)), id: \.0) { _, element in
                        AnyView(element.view())
                    }
                }
            case .spacer:
                Spacer(minLength: 0)
            case let .divider(opacity, _):
                Rectangle()
                    .fill(Color.primary.opacity(opacity))
                    .frame(height: 1)
                    .padding(.vertical, 8)
            case let .table(configuration, _):
                ARVisTableView(configuration: configuration)
            case let .chart(configuration):
                if #available(iOS 16, *) {
                    ChartView(chartConfiguration: configuration)
                        .id(UUID())
                }
            case let .segmentedControl(items, _):
                ARVisSegmentedControlView(items: items)
                    .id(UUID())
            case let .grid(rows, _):
                if #available(iOS 16, *) {
                    Grid {
                        ForEach(Array(zip(rows.indices, rows)), id: \.0) { _, row in
                            AnyView(row.view())
                        }
                    }
                } else {
                    Text("Grid component is not supported in iOS 15.")
                }
            case let .gridRow(rowElements, _):
                if #available(iOS 16, *) {
                    GridRow {
                        ForEach(Array(zip(rowElements.indices, rowElements)), id: \.0) { _, rowElement in
                            AnyView(rowElement.view())
                        }
                    }
                } else {
                    Text("GridRow component is not supported in iOS 15.")
                }
            case let .splom(data, fields, labels, config):
                if #available(iOS 16, *) {
                    SPLOMView(data: data, fields: fields, labels: labels, config: config)
                } else {
                    Text("SPLOM component is not supported in iOS 15.")
                }
            }
        }
        .apply(modifiers: modifiers)
    }
}
