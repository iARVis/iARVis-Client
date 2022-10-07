//
//  ViewElementComponent+Example2+AppleSilicon.swift
//  iARVis
//
//  Created by Anonymous on 2022/9/2.
//

import Foundation

extension ViewElementComponent {
    static let example2_AppleSilicon: ViewElementComponent = .vStack(elements: [
        .hStack(elements: [
            .vStack(elements: [
                .text(content: "What is Apple Silicon? Everything you need to know", fontStyle: ARVisFontStyle(size: 34, weight: .bold)),
                .hStack(elements: [
                    .image(url: "https://www.trustedreviews.com/wp-content/uploads/sites/54/2019/10/71-150x150.jpg", width: 30, clipToCircle: true),
                    .vStack(elements: [
                        .text(content: "By [Ryan Jones](https://www.trustedreviews.com/author/ryanjones)", fontStyle: ARVisFontStyle(size: 17, weight: .regular)),
                        .text(content: "Computing and Gaming Editor", fontStyle: ARVisFontStyle(size: 15, weight: .regular)),
                        .text(content: "July 26, 2022 4:53 pm BST", fontStyle: ARVisFontStyle(size: 13, weight: .regular, color: .rgbaHex(string: "#6e6e73"))),
                    ], alignment: .leading),
                    .spacer,
                ]),
            ], alignment: .leading),
            .image(url: "https://www.trustedreviews.com/wp-content/uploads/sites/54/2020/06/Screen-Shot-2020-06-22-at-19.32.20-920x575.png", width: 700),
        ], alignment: .top),
        .divider(opacity: 0.3),
        .hStack(elements: [
            .vStack(elements: [
                .text(content: "**In this article...**", fontStyle: ARVisFontStyle(size: 19)),
                .text(content: "**1.** What is Apple Silicon?", fontStyle: ARVisFontStyle(size: 17, weight: .light)),
                .text(content: "**2.** Does Apple Silicon use Arm architecture?", fontStyle: ARVisFontStyle(size: 17, weight: .light)),
                .text(content: "**3.** You might like", fontStyle: ARVisFontStyle(size: 17, weight: .light)),
            ], alignment: .leading, spacing: 4),
            .vStack(elements: [
                .text(content: "If you’ve considered buying one of Apple’s iMac or MacBook in recent years, you’ve likely come across the term ‘Apple Silicon’, but what does this mean?", fontStyle: ARVisFontStyle(size: 24, weight: .medium)),
                .text(content: "We’ve created this guide to explain what Apple Silicon is, while also answering any important questions surrounding the technology. So keep reading on if you want to find out more about Apple Silicon.", fontStyle: ARVisFontStyle(size: 17, weight: .regular)),
                .text(content: "What is Apple Silicon?", fontStyle: ARVisFontStyle(size: 24, weight: .medium)),
                .vStack(elements: [
                    .text(content: "Apple Silicon is the processor architecture used inside Apple’s computer chips. The likes of the M1 and M2 processors both use Apple Silicon, marking a departure from Apple’s use of Intel CPUs.", fontStyle: ARVisFontStyle(size: 17, weight: .regular)),
                    .text(content: "The Apple M1 chip was the first Apple Silicon chip to launch, and has been installed inside the [MacBook Air](https://www.trustedreviews.com/reviews/macbook-air-m1), 13-inch MacBook Pro, [Mac Mini](https://www.trustedreviews.com/news/apple-mac-mini-with-m1-chip-release-date-price-specs-performance-4108102) and [iMac](https://www.trustedreviews.com/news/imac-2021-release-date-price-specs-design-wishlist-4119600).", fontStyle: ARVisFontStyle(size: 17, weight: .regular)),
                    .text(content: "The [M1 Pro](https://www.trustedreviews.com/news/apple-m1-pro-release-date-price-specs-performance-4174174) and [M1 Max](https://www.trustedreviews.com/news/apple-m1-max-specs-performance-tdp-4174187) chips launched in October 2021 as more powerful alternatives to the M1, becoming available in the MacBook Pro.", fontStyle: ARVisFontStyle(size: 17, weight: .regular)),
                    .text(content: "And then there’s the [M1 Ultra](https://www.trustedreviews.com/news/apple-m1-ultra-chip-release-date-specs-design-performance-benchmarks-4215398) processor which is the most powerful processor in the range yet, and is packed inside the [Mac Studio](https://www.trustedreviews.com/news/mac-studio-release-date-price-specs-design-4215009) desktop computer.", fontStyle: ARVisFontStyle(size: 17, weight: .regular)),
                    .image(url: "https://www.trustedreviews.com/wp-content/uploads/sites/54/2020/11/Apple-M1.png"),
                    .text(content: "All of the above processors represent the first generation of Apple’s new architecture, but the company has since launched the very first chip in the second generation: the [Apple M2](https://www.trustedreviews.com/news/apple-m2-release-date-price-specs-4157112).", fontStyle: ARVisFontStyle(size: 17, weight: .regular)),
                    .text(content: "The Apple M2 uses the same number of CPU cores as its predecessor, but the improvements made to the architecture has still allowed for a significant performance boost.", fontStyle: ARVisFontStyle(size: 17, weight: .regular)),
                    .text(content: "Apple previously confirmed its entire Mac range will transition over to the Apple Silicon by the end of 2022. Right now, the top-tier Mac Mini and Mac Pro are the only remaining Macs to feature Intel processors, so it’s possible that Apple will meet that deadline.", fontStyle: ARVisFontStyle(size: 17, weight: .regular)),
                    .text(content: "If you’ve still got an Intel Mac, there’s no need for concern, as Apple has confirmed it will continue to support such devices for the foreseeable future.", fontStyle: ARVisFontStyle(size: 17, weight: .regular)),
                ], alignment: .leading, spacing: 8),
                .text(content: "Does Apple Silicon use Arm architecture?", fontStyle: ARVisFontStyle(size: 24, weight: .medium)),
                .vStack(elements: [
                    .text(content: "Yes. MacBook and iMac devices previously used Intel’s x86 processor architecture, but Apple is now switching over to Arm architecture.", fontStyle: ARVisFontStyle(size: 17, weight: .regular)),
                    .text(content: "Apple also uses Arm-based A-Series chips for its iPhone and iPad devices, so the transition allows Apple to provide cross-platform support for apps across both iOS and macOS.", fontStyle: ARVisFontStyle(size: 17, weight: .regular)),
                    .text(content: "Arm technology is renowned for offering excellent power and thermal efficiency compared to Intel processors. This is shown by the fact that the MacBook Air can now operate without a fan.", fontStyle: ARVisFontStyle(size: 17, weight: .regular)),
                    .text(content: "But Apple has also proven that Arm processors have a very high performance ceiling, with benchmark results indicating that the M1 Max is more powerful than the vast majority of laptop processors on the market.", fontStyle: ARVisFontStyle(size: 17, weight: .regular)),
                ], alignment: .leading, spacing: 8),
            ], alignment: .leading, spacing: 16),
        ], alignment: .top, spacing: 24),
        .divider(opacity: 0.3),
        .text(content: "You might like", fontStyle: ARVisFontStyle(size: 24, weight: .medium)),
        .grid(rows: [
            .gridRow(rowElements: [
                .vStack(elements: [
                    .image(url: "https://www.trustedreviews.com/wp-content/uploads/sites/54/2020/10/12-VS-12-pro.jpg"),
                    .text(content: "iPhone 12 vs iPhone 12 Pro: What’s the difference?", fontStyle: ARVisFontStyle(size: 17, weight: .medium)),
                    .text(content: "Max Parker", fontStyle: ARVisFontStyle(size: 15, weight: .light)),
                ]),
                .vStack(elements: [
                    .image(url: "https://www.trustedreviews.com/wp-content/uploads/sites/54/2020/10/iphone-12-4.png"),
                    .text(content: "The iPhone 12 Mini is what the iPhone SE 2 should have been", fontStyle: ARVisFontStyle(size: 17, weight: .medium)),
                    .text(content: "Thomas Deehan", fontStyle: ARVisFontStyle(size: 15, weight: .light)),
                ]),
                .vStack(elements: [
                    .image(url: "https://www.trustedreviews.com/wp-content/uploads/sites/54/2012/09/earpods-6-1.jpg"),
                    .text(content: "Does the iPhone 12 come with headphones?", fontStyle: ARVisFontStyle(size: 17, weight: .medium)),
                    .text(content: "Alastair Stevenson", fontStyle: ARVisFontStyle(size: 15, weight: .light)),
                ]),
                .vStack(elements: [
                    .image(url: "https://www.trustedreviews.com/wp-content/uploads/sites/54/2020/10/iphone-12-box.jpeg"),
                    .text(content: "Does the iPhone 12 come with a charger?", fontStyle: ARVisFontStyle(size: 17, weight: .medium)),
                    .text(content: "Alastair Stevenson", fontStyle: ARVisFontStyle(size: 15, weight: .light)),
                ]),
            ]),
            .gridRow(rowElements: [
                .vStack(elements: [
                    .image(url: "https://www.trustedreviews.com/wp-content/uploads/sites/54/2020/10/iphone-12-pro-3.png"),
                    .text(content: "iPhone 12 Pro vs iPhone 12 Pro Max: Which Pro should you buy?", fontStyle: ARVisFontStyle(size: 17, weight: .medium)),
                    .text(content: "Adam Speight", fontStyle: ARVisFontStyle(size: 15, weight: .light)),
                ]),
                .vStack(elements: [
                    .image(url: "https://www.trustedreviews.com/wp-content/uploads/sites/54/2020/10/12-miniVS-SE-2.jpg"),
                    .text(content: "iPhone 12 mini vs iPhone SE 2: What’s the best mini Apple phone?", fontStyle: ARVisFontStyle(size: 17, weight: .medium)),
                    .text(content: "Ryan Jones", fontStyle: ARVisFontStyle(size: 15, weight: .light)),
                ]),
            ]),
        ]),
    ], alignment: .leading)
}
