//
//  ViewElementComponent+Example1+ArtworkWidget.swift
//  iARVis (iOS)
//
//  Created by Anonymous on 2022/8/29.
//

import Foundation

extension ViewElementComponent {
    static let example1_ArtworkWidget: ViewElementComponent = {
        .vStack(elements: [
            .hStack(elements: [
                .vStack(elements: [
                    .text(content: "Christ's Entry into Brussels in 1889", fontStyle: ARVisFontStyle(size: 24, weight: .bold)),
                    .text(content: "1888", fontStyle: ARVisFontStyle(size: 20, weight: .medium)),
                    .text(content: "[James Ensor](\(URLService.openComponent(config: .json(json: example1_JamesEnsorWidget.prettyJSON), anchor: .top, relativePosition: .init(0, 0.005, 0)).url)) (Belgian, 1860 - 1949)",
                          fontStyle: ARVisFontStyle(size: 20)),
                    .text(content: "On view at [Getty Center, Museum West Pavilion, Gallery W103](https://www.getty.edu/art/collection/gallery/103M5Q)"),
                    .spacer,
                    .text(content: "Introduction audio(English)", fontStyle: ARVisFontStyle(size: 17, weight: .light)),
                    .audio(title: "Christ's Entry into Brussels in 1889 (Highlights)", url: "https://dea3n992em6cn.cloudfront.net/museumcollection/000932-en-20210324-v1.mp3"),
                ], alignment: .leading, spacing: 4),
                .image(url: "https://media.getty.edu/iiif/image/ce4d5a1f-ee25-44b3-afa2-d597d43056ff/full/1024,/0/default.jpg?download=ce4d5a1f-ee25-44b3-afa2-d597d43056ff_1024.jpg&size=small"),
            ], alignment: .top),
            .divider(),
            .hStack(elements: [
                .spacer,
                .segmentedControl(items: [
                    ARVisSegmentedControlItem(title: "Introduction", component: .vStack(elements: [
                        .text(content: "Introduction", fontStyle: ARVisFontStyle(size: 22, weight: .medium)),
                        .hStack(elements: [
                            .spacer,
                            .video(url: "https://youtu.be/D7WdO4DcHaA", height: 300),
                            .spacer,
                        ]),
                        .text(content: "James Ensor took on religion, politics, and art in this scene of Christ entering contemporary Brussels in a Mardi Gras parade. In response to the French pointillist style, Ensor used palette knives, spatulas, and both ends of his brush to put down patches of colors with expressive freedom. He made several preparatory drawings for the painting, including one in the J. Paul Getty Museum's collection."),
                        .text(content: "Ensor's society is a mob, threatening to trample the viewer -- a crude, ugly, chaotic, dehumanized sea of masks, frauds, clowns, and caricatures. Public, historical, and allegorical figures, along with the artist's family and friends, make up the crowd. The haloed Christ at the center of the turbulence is in part a self-portrait: mostly ignored, a precarious, isolated visionary amidst the herdlike masses of modern society. Ensor's Christ functions as a political spokesman for the poor and oppressed--a humble leader of the true religion, in opposition to the atheist social reformer Emile Littré, shown in bishop's garb holding a drum major's baton and leading on the eager, mindless crowd."),
                        .text(content: "After rejection by Les XX, the artists' association that Ensor had helped to found, the painting was not exhibited publicly until 1929. Ensor displayed Christ's Entry prominently in his home and studio throughout his life. With its aggressive, painterly style and merging of the public with the deeply personal, Christ's Entry was a forerunner of twentieth-century Expressionism."),
                    ], alignment: .leading, spacing: 8)),
                    ARVisSegmentedControlItem(title: "Provenance", component: .vStack(elements: [
                        .text(content: "Provenance", fontStyle: ARVisFontStyle(size: 22, weight: .medium)),
                        example1_ProvenanceChartViewElementComponent,
                    ], alignment: .leading, spacing: 4)),
                    ARVisSegmentedControlItem(title: "Historical Price", component: .vStack(elements: [
                        .text(content: "Historical Price", fontStyle: ARVisFontStyle(size: 22, weight: .medium)),
                        example1_HistoricalPriceChartViewElementComponent,
                    ], alignment: .leading, spacing: 4)),
                    ARVisSegmentedControlItem(title: "Full Artwork Details", component: .table(configuration:
                        TableConfiguration(tableData: TableData(data: [
                            "Title": "Christ's Entry into Brussels in 1889",
                            "Artist/Maker": "[James Ensor](https://www.getty.edu/art/collection/person/103JT2) (Belgian, 1860 - 1949)",
                            "Date": "1888",
                            "Medium": "[Oil on canvas](https://www.getty.edu/art/collection/search?materials=Oil%20on%20canvas)",
                            "Dimensions": "252.6 × 431 cm (99 7/16 × 169 11/16 in.)",
                            "Place": "[Belgium](https://www.getty.edu/art/collection/search?q=%22Belgium%22) (Place Created)",
                            "Culture": "[Belgian](https://www.getty.edu/art/collection/search?q=%22Belgium%22)",
                            "Signature(s)": "Signed and dated lower right, beneath the elevated platform: \"J. ENSOR / 1888\"",
                            "Object Number": "87.PA.96",
                            "Inscription(s)": "On red banner at top: \"VIVE LA SOCiALE\"; on lozenge-shaped banner left of center: \"FANFARES DOCTRINAiRES / TOUJOURS RÉUSSi\"; on red banner at lower right: \"VIVE JESUS / ROI DE / BrUXLLES\"",
                            "Department": "[Paintings](https://www.getty.edu/art/collection/search?department=Paintings)",
                            "Classification": "[Painting](https://www.getty.edu/art/collection/search?classification=Painting)",
                            "Object Type": "[Painting](https://www.getty.edu/art/collection/search?object_type=Painting)",
                        ], titles: ["Title", "Artist/Maker", "Date", "Medium", "Dimensions", "Place", "Culture", "Signature(s)", "Object Number", "Inscription(s)", "Department", "Classification", "Object Type"]),
                        orientation: .vertical)
                    )),
                ]),
                .spacer,
            ]),
        ], alignment: .leading, spacing: 4)
    }()
}
