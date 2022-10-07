//
//  ViewElementComponent+Example2+MacBookPro.swift
//  iARVis (iOS)
//
//  Created by Anonymous on 2022/8/29.
//

import Foundation

extension ViewElementComponent {
    static let example2_MacBookPro: ViewElementComponent = .vStack(elements: [
        .hStack(elements: [
            .vStack(elements: [
                .text(content: "MacBook Pro (16-inch, 2021)", fontStyle: ARVisFontStyle(size: 40, weight: .bold)),
                .text(content: """
                The **MacBook Pro (16-inch, 2021)** was introduced at Apple's **'Unleashed'** event on 18 October 2021, and is the first MacBook Pro (16-inch) to feature [Apple Silicon](\(URLService.openComponent(config: .json(json: example2_AppleSilicon.prettyJSON), anchor: .leading, relativePosition: .init(-0.005, 0, 0)).url)) as part of the transition from x86_64-based Intel processors.
                It was made available for preorder on 18 October 2021, and for purchase on 26 October 2021.
                The firmware identifiers are [MacBookPro18,1](https://www.theiphonewiki.com/wiki/J316sAP) ([M1 Pro](https://www.theiphonewiki.com/wiki/T6000)) and [MacBookPro18,2](https://www.theiphonewiki.com/wiki/J316cAP) ([M1 Max](https://www.theiphonewiki.com/wiki/T6001)).
                """, fontStyle: ARVisFontStyle(size: 22)),
            ], alignment: .leading),
            .spacer,
            .image(url: "https://cdn.jsdelivr.net/gh/JJAYCHEN1e/Image@2022/default/large_0074.jpg", width: 500),
        ], alignment: .top),
        .divider(),
        .segmentedControl(items: [
            ARVisSegmentedControlItem(title: "Specifications", component: .table(configuration:
                TableConfiguration(tableData: TableData(data: [
                    "Color Options": "**Silver** or **Space Gray**",
                    "Processor": "**M1 Pro** with 10-core CPU and 16-core GPU,\n**M1 Max** with 10-core CPU and 24-core GPU,\n**M1 Max** with 10-core CPU and 32-core GPU",
                    "Memory": "**16GB** or **32GB** LPDDR5-6400 (M1 Pro) (204.8 GB/s),\n**32GB** or **64GB** LPDDR5-6400 (M1 Max) (409.6 GB/s)",
                    "Storage": "**512GB**, **1TB**, **2TB**, **4TB** or **8TB**",
                    "Size": "0.66 inches (1.68 cm) (height) x 14.01 inches (35.57 cm) (width) x 9.77 inches (24.81 cm) (depth)",
                    "Weight": "**4.7 pounds** (2.1 kg) (M1 Pro) or **4.8 pounds** (2.2 kg) (M1 Max)",
                    "Display": """
                    **Liquid Retina XDR display**:
                    16.2-inch (diagonal) Liquid Retina XDR display; 3456-by-2234 native resolution at 254 pixels per inch

                    **XDR (Extreme Dynamic Range)**:
                    1,000,000:1 contrast ratiom
                    **XDR brightness**: 1000 nits sustained full-screen, 1600 nits peak (HDR content only)
                    **SDR brightness**: 500 nits

                    **Color**:
                    1 billion colors (8-bit + FRC)
                    **Wide Color (P3)**
                    **True Tone** technology

                    **Refresh rates**:
                    **ProMotion** technology for **adaptive** refresh rates **up to 120Hz**
                    **Fixed refresh rates**: 47.95Hz, 48.00Hz, 50.00Hz, 59.94Hz, 60.00Hz

                    **Reference modes**:
                    **Apple XDR Display (P3-1600 nits)**
                    **Apple Display (P3-500 nits)**
                    HDR Video (P3-ST 2084)
                    HDTV Video (BT.709-BT.1886)
                    NTSC Video (BT.601 SMPTE-C)
                    PAL & SECAM Video (BT.601 EBU)
                    Digital Cinema (P3-DCI)
                    Digital Cinema (P3-D65)
                    Design & Print (P3-D50)
                    Photography (P3-D65)
                    Internet & Web (sRGB)
                    """,
                    "Camera": "1080p FaceTime HD camera\nAdvanced image signal processor with computational video",
                    "Audio": "High-fidelity six-speaker sound system with force-cancelling woofers\nWide stereo sound\nSupport for spatial audio when playing music or video with Dolby Atmos on built-in speakers\nSpatial audio with dynamic head tracking when using AirPods (3rd generation), AirPods Pro, and AirPods Max\nStudio-quality three-mic array with high signal-to-noise ratio and directional beamforming\n3.5mm headphone jack with advanced support for high-impedance headphones",
                    "Charging and Expansion": "MagSafe 3 port\nThree Thunderbolt 4 (USB-C) ports with support for:\nCharging\nDisplayPort\nThunderbolt 4 (up to 40Gb/s)\nUSB 4 (up to 40Gb/s)\nHDMI port\nSDXC card slot\n3.5mm headphone jack",
                    "Wireless": "Wi-Fi\n802.11ax Wi-Fi 6 wireless networking\nIEEE 802.11a/b/g/n/ac compatible\nBluetooth\nBluetooth 5.0 wireless technology",
                    "Battery and Power": "100-watt-hour lithium-polymer battery\nCurrent: 8,693 mA⋅h\nPower: 99.6 W⋅h\nVoltage: 11.45 V\n140W USB-C Power Adapter",
                ], titles: ["Color Options", "Processor", "Memory", "Storage", "Size", "Weight", "Display", "Camera", "Audio", "Charging and Expansion", "Wireless", "Battery and Power"]),
                orientation: .vertical)
            )),
            ARVisSegmentedControlItem(title: "Family History", component: .vStack(elements: [
                .text(content: "MacBook Pro Sesries", fontStyle: ARVisFontStyle(size: 19, weight: .medium, color: .rgbaHex(string: "#3e3e43"))),
                example2_MacBookProFamilyChartViewElementComponent,
            ], alignment: .leading)),
            ARVisSegmentedControlItem(title: "Performance", component: .vStack(elements: [
                .divider(opacity: 0.2),
                .segmentedControl(items: [
                    ARVisSegmentedControlItem(title: "CPU", component: .vStack(elements: [
                        .vStack(elements: [
                            .image(url: "https://cdn.jsdelivr.net/gh/JJAYCHEN1e/Image@2022/default/Apple_M1-Pro-M1-Max_CPU-Performance_10182021.jpg", height: 400),
                            .text(content: "M1 Pro and M1 Max feature an up-to-10-core CPU that is up to 1.7x faster than the latest 8-core PC laptop chip at the same power level,\nand achieves the PC chip’s peak performance at up to 70 percent less power.", fontStyle: ARVisFontStyle(size: 12, weight: .medium, color: .rgbaHex(string: "#6e6e73"))),
                            .divider(opacity: 0.2),
                            .segmentedControl(items: [
                                ARVisSegmentedControlItem(title: "Cinebench 23 - Multi", component: .vStack(elements: [
                                    .text(content: "In the **multi-core test**, all cores are put to work and it is clear that **the 10-core M1 processors can compete with the Ryzen 5900HX with eight cores**. The great thing is that the cooling is particularly quiet in both cases. The fans do run, but make a soft noise and the cooling is therefore noticeably quieter than that of the majority of laptops. The M1 Pro processor with eight cores is just a bit faster than a Ryzen 5600H, which has six cores. In single-core applications, the new M1 processors still perform slightly better than the old M1, probably due to the better cooling, because the MacBook Air is passively cooled.", fontStyle: ARVisFontStyle(size: 17)),
                                    example2MacBookProPerformanceBarChartCPUViewElementComponent,
                                ])),
                                ARVisSegmentedControlItem(title: "Cinebench 23 - Single", component: .vStack(elements: [
                                    .text(content: "In the multi-test, all cores are put to work and it is clear that the 10-core M1 processors can compete with the Ryzen 5900HX with eight cores. The great thing is that the cooling is particularly quiet in both cases. The fans do run, but make a soft noise and the cooling is therefore noticeably quieter than that of the majority of laptops. The M1 Pro processor with eight cores is just a bit faster than a Ryzen 5600H, which has six cores. In **single-core** applications, **the new M1 processors still perform slightly better than the old M1**, probably due to the better cooling, because the MacBook Air is passively cooled.", fontStyle: ARVisFontStyle(size: 17)),
                                    example2MacBookProPerformanceBarChartCPU2ViewElementComponent,
                                ])),
                                ARVisSegmentedControlItem(title: "Blender", component: .vStack(elements: [
                                    .text(content: "We use **Blender** to check whether the processors are affected by throttling. We render the same image repeatedly and each time the render time is almost the same as the previous image. The MacBook Air is passively cooled and the difference that makes is also clearly visible, because the line slowly rises because the hardware gets too hot and thus starts to throttle. The actively cooled MacBook Pros do not suffer from this.", fontStyle: ARVisFontStyle(size: 17)),
                                    example2MacBookProPerformanceLineChartViewElementComponent,
                                ])),
                            ]),
                        ]),
                    ])),
                    ARVisSegmentedControlItem(title: "GPU", component: .vStack(elements: [
                        .vStack(elements: [
                            .image(url: "https://cdn.jsdelivr.net/gh/JJAYCHEN1e/Image@2022/default/Apple_M1-Pro-M1-Max_M1-Max-GPU-Performance-vs-PC_10182021.jpg", height: 400),
                            .text(content: "M1 Max has an up-to-32-core GPU that delivers graphics performance comparable to that in a high-end compact PC pro laptop using up to 40 percent less power.", fontStyle: ARVisFontStyle(size: 12, weight: .medium, color: .rgbaHex(string: "#6e6e73"))),
                            .divider(opacity: 0.2),
                            .segmentedControl(items: [
                                ARVisSegmentedControlItem(title: "3DMark Wild Life Extreme Unlimited", component: .vStack(elements: [
                                    .text(content: "A somewhat 'neutral' benchmark is **3DMark Wild Life**. This test works on x86 and arm processors and on Windows, MacOS, Android and iOS. In Windows, the test uses Vulkan and under MacOS, of course, Metal. The benchmark is purely graphic, at a high resolution, and this also shows that **the M1 Max can hold its own and can come close to a mobile RTX 3080**. The 16-core GPU in the M1 Pro comes closer of an RTX 3050 Ti video card, while the 14-core model is about thirteen percent lower. That is entirely in line with expectations, because the GPU cores scale almost linearly.", fontStyle: ARVisFontStyle(size: 18)),
                                    example2MacBookProPerformanceBarChartGPUViewElementComponent,
                                ])),
                            ]),
                        ]),
                    ])),
                ]),
            ])),
            ARVisSegmentedControlItem(title: "Technical Reviews", component: .vStack(elements: [
                .hStack(elements: [
                    .video(url: "https://www.youtube.com/watch?v=rr2XfL_df3o", width: 450),
                    .vStack(elements: [
                        .text(content: "M1 Max MacBook Pro Review: Truly Next Level!", fontStyle: ARVisFontStyle(size: 17, weight: .medium)),
                        .text(content: "22:38", fontStyle: ARVisFontStyle(size: 14, weight: .medium, color: .rgbaHex(string: "#6e6e73"))),
                        .hStack(elements: [
                            .image(url: "https://yt3.ggpht.com/lkH37D712tiyphnu0Id0D5MwwQ7IRuwgQLVD05iMXlDWO-kDHut3uI4MgIEAQ9StK0qOST7fiA=s68-c-k-c0x00ffffff-no-rj", width: 25, clipToCircle: true),
                            .text(content: "Marques Brownlee", fontStyle: ARVisFontStyle(size: 14, weight: .medium)),
                        ]),
                        .text(content: """
                        The 14" and 16" MacBook Pros are incredible. I can finally retire the travel iMac.
                        0:00 Intro
                        1:38 Top Notch Design
                        2:27 Let's Talk Ports
                        7:11 RIP Touchbar
                        8:20 The new displays
                        10:12 Living with the notch
                        12:37 Performance
                        19:39 Battery
                        20:30 So should you get it?
                        """, fontStyle: ARVisFontStyle(size: 14, weight: .light, color: .rgbaHex(string: "#6e6e73"))),
                    ], alignment: .leading),
                ], alignment: .top),
                .hStack(elements: [
                    .video(url: "https://www.youtube.com/watch?v=ftU1HzBKd5Y", width: 450),
                    .vStack(elements: [
                        .text(content: "MacBook Pro with M1 Pro and M1 Max review: laptop of the year", fontStyle: ARVisFontStyle(size: 17, weight: .medium)),
                        .text(content: "22:04", fontStyle: ARVisFontStyle(size: 14, weight: .medium, color: .rgbaHex(string: "#6e6e73"))),
                        .hStack(elements: [
                            .image(url: "https://yt3.ggpht.com/ytc/AMLnZu_aCwxQLZtM1N2t1_dJ16UUOTArC2ogjNkusByP69U=s68-c-k-c0x00ffffff-no-rj", width: 25, clipToCircle: true),
                            .text(content: "The Verge", fontStyle: ARVisFontStyle(size: 14, weight: .medium)),
                        ]),
                        .text(content: """
                        Apple’s new MacBook Pro 14 and MacBook Pro 16 are a triumphant success — they have excellent performance, stunning battery life, useful ports, and incredible displays. The only knock against them is you’re going to pay a lot for all that good stuff.

                        Read more: https://www.theverge.com/e/22515962

                        0:00 Intro
                        0:26 Specs & prices
                        0:51 Design & hardware
                        3:08 Mini LED Display (and the notch)
                        7:32 Speakers
                        8:00 Processors
                        9:22 Benchmarks
                        12:27 Gaming
                        13:38 Video Editing
                        16:06 Final Cut Pro
                        16:33 After Effects
                        17:03 Battery life
                        19:37 M1 Pro vs M1 Max
                        20:32 Conclusion
                        """, fontStyle: ARVisFontStyle(size: 14, weight: .light, color: .rgbaHex(string: "#6e6e73"))),
                    ], alignment: .leading),
                ], alignment: .top),
                .hStack(elements: [
                    .video(url: "https://www.youtube.com/watch?v=IhqCC70ZfDM", width: 450),
                    .vStack(elements: [
                        .text(content: "M1 Max MacBook Pro Review! (14\" + 16\")", fontStyle: ARVisFontStyle(size: 17, weight: .medium)),
                        .text(content: "8:36", fontStyle: ARVisFontStyle(size: 14, weight: .medium, color: .rgbaHex(string: "#6e6e73"))),
                        .hStack(elements: [
                            .image(url: "https://yt3.ggpht.com/ytc/AMLnZu-1SOWcwcK3QGxz1kl145xbRkD-n8PVrC9p8RVR4w=s68-c-k-c0x00ffffff-no-rj", width: 25, clipToCircle: true),
                            .text(content: "Dave2D", fontStyle: ARVisFontStyle(size: 14, weight: .medium)),
                        ]),
                        .text(content: """
                        My review of the best MacBook in 2021. The new Apple MacBook Pro with M1 Max and M1 Pro chips. The 14" and 16" MacBook Pro are built with professionals in mind but could be used for laptop gaming.
                        """, fontStyle: ARVisFontStyle(size: 14, weight: .light, color: .rgbaHex(string: "#6e6e73"))),
                    ], alignment: .leading),
                ], alignment: .top),
            ], alignment: .leading)),
        ]),
    ])

    static let example2_MacBookProFamilyChartViewElementComponentJSONStr = """
    {
        "vStack": {
            "elements": [
                {
                    "chart": \(ChartConfigurationExample.chartConfigurationExample2_MacBookProFamilyChart)
                },
            ]
        }
    }
    """

    static let example2MacBookProPerformanceLineChartViewElementComponentJSONStr = """
    {
        "vStack": {
            "elements": [
                {
                    "chart": \(ChartConfigurationExample.chartConfigurationExample2_MacBookProPerformanceLineChart)
                },
            ]
        }
    }
    """

    static let example2MacBookProPerformanceBarChartCPUViewElementComponentJSONStr = """
    {
        "vStack": {
            "elements": [
                {
                    "chart": \(ChartConfigurationExample.chartConfigurationExample2_MacBookProPerformanceBarChartCPU)
                },
            ]
        }
    }
    """

    static let example2MacBookProPerformanceBarChartCPU2ViewElementComponentJSONStr = """
    {
        "vStack": {
            "elements": [
                {
                    "chart": \(ChartConfigurationExample.chartConfigurationExample2_MacBookProPerformanceBarChartCPU2)
                },
            ]
        }
    }
    """

    static let example2MacBookProPerformanceBarChartGPUViewElementComponentJSONStr = """
    {
        "vStack": {
            "elements": [
                {
                    "chart": \(ChartConfigurationExample.chartConfigurationExample2_MacBookProPerformanceBarChartGPU)
                },
            ]
        }
    }
    """

    static let example2_MacBookProFamilyChartViewElementComponent: ViewElementComponent = try! JSONDecoder().decode(ViewElementComponent.self, from: example2_MacBookProFamilyChartViewElementComponentJSONStr.data(using: .utf8)!)

    static let example2MacBookProPerformanceLineChartViewElementComponent: ViewElementComponent = try! JSONDecoder().decode(ViewElementComponent.self, from: example2MacBookProPerformanceLineChartViewElementComponentJSONStr.data(using: .utf8)!)

    static let example2MacBookProPerformanceBarChartCPUViewElementComponent: ViewElementComponent = try! JSONDecoder().decode(ViewElementComponent.self, from: example2MacBookProPerformanceBarChartCPUViewElementComponentJSONStr.data(using: .utf8)!)

    static let example2MacBookProPerformanceBarChartCPU2ViewElementComponent: ViewElementComponent = try! JSONDecoder().decode(ViewElementComponent.self, from: example2MacBookProPerformanceBarChartCPU2ViewElementComponentJSONStr.data(using: .utf8)!)

    static let example2MacBookProPerformanceBarChartGPUViewElementComponent: ViewElementComponent = try! JSONDecoder().decode(ViewElementComponent.self, from: example2MacBookProPerformanceBarChartGPUViewElementComponentJSONStr.data(using: .utf8)!)
}
