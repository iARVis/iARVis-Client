//
//  VisualizationContext.swift
//  iARVis (iOS)
//
//  Created by Anonymous on 2022/7/31.
//

import ARKit
import SceneKit

typealias VisualizationConfigurationProcessResult = (referenceImages: [ARReferenceImage], referenceObjects: [ARReferenceObject])

class SCNWidgetNode: SCNNode {
    var widgetConfiguration: WidgetConfiguration
    var widgetViewController: UIViewController?
    var additionalWidgetNodes: [String: SCNWidgetNode] = [:]

    init(widgetConfiguration: WidgetConfiguration) {
        self.widgetConfiguration = widgetConfiguration
        super.init()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class VisualizationContext {
    var visConfiguration: VisualizationConfiguration?
    var visConfigurationProcessingTask: Task<Void, Never>?

    class NodePair {
        var _node = SCNNode()
        var node: SCNWidgetNode

        init(node: SCNWidgetNode) {
            self.node = node
        }
    }

    // TODO: Should we use the conf as the key?
    private var imageNodePairMap: [String: [WidgetImageRelationship: NodePair]] = [:]

    func reset() {
        visConfiguration = nil

        imageNodePairMap = [:]

        visConfigurationProcessingTask?.cancel()
        visConfigurationProcessingTask = nil
    }

    enum VisualizationConfigurationProcessingError: String, Error {
        case cancelled
        case fetchFailure
    }

    func processVisualizationConfiguration(completionHandler: @escaping (VisualizationConfigurationProcessResult) -> Void) {
        visConfigurationProcessingTask?.cancel()
        visConfigurationProcessingTask = nil

        visConfigurationProcessingTask = Task {
            do {
                guard !Task.isCancelled else { throw VisualizationConfigurationProcessingError.cancelled }

                let fetchResults = try await withThrowingTaskGroup(of: (URL, UIImage).self, body: { group -> [(URL, UIImage)] in
                    var dataArray = [(URL, UIImage)]()

                    guard let imageTrackingConfigurations = visConfiguration?.imageTrackingConfigurations else {
                        return dataArray
                    }

                    dataArray.reserveCapacity(imageTrackingConfigurations.count)

                    for imageTrackingConfiguration in imageTrackingConfigurations {
                        group.addTask {
                            let result = try await ImageDownloader.default.download(url: imageTrackingConfiguration.imageURL)
                            return (imageTrackingConfiguration.imageURL, result)
                        }
                    }

                    for try await res in group {
                        dataArray.append(res)
                    }

                    return dataArray
                })

                guard !Task.isCancelled else { throw VisualizationConfigurationProcessingError.cancelled }

                let referenceImages: [ARReferenceImage] = fetchResults.map { input -> ARReferenceImage in
                    let referenceImage = ARReferenceImage(input.1.cgImage!, orientation: .up, physicalWidth: 0.2)
                    referenceImage.name = input.0.absoluteString
                    return referenceImage
                }

                guard !Task.isCancelled else { throw VisualizationConfigurationProcessingError.cancelled }

                completionHandler((referenceImages, []))
            } catch {
                printDebug(level: .warning, error.localizedDescription)
            }
        }
    }
}

extension VisualizationContext {
    // MARK: - Node pair utils

    func nodePairs(url: String) -> [WidgetImageRelationship: NodePair]? {
        imageNodePairMap[url]
    }

    func nodePairs(url: URL) -> [WidgetImageRelationship: NodePair]? {
        imageNodePairMap[url.absoluteString]
    }

    func set(nodePair: NodePair?, for url: String, relationship: WidgetImageRelationship) {
        imageNodePairMap[url, default: [:]][relationship] = nodePair
    }

    func set(nodePair: NodePair?, for url: URL, relationship: WidgetImageRelationship) {
        imageNodePairMap[url.absoluteString, default: [:]][relationship] = nodePair
    }

    func imageTrackingConfiguration(url: String) -> ImageTrackingConfiguration? {
        visConfiguration?.findImageConfiguration(url: url)
    }

    func imageTrackingConfiguration(url: URL) -> ImageTrackingConfiguration? {
        visConfiguration?.findImageConfiguration(url: url)
    }
}
