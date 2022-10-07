//
//  ARKitViewController+ARSessionDelegate.swift
//  iARVis (iOS)
//
//  Created by Anonymous on 2022/7/28.
//

import ARKit
import UIKit

// MARK: - ARSessionDelegate

extension ARKitViewController: ARSessionDelegate {
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        for imageTrackingConfig in visContext.visConfiguration?.imageTrackingConfigurations ?? [] {
            for relationship in imageTrackingConfig.relationships {
                guard let nodePair = visContext.nodePairs(url: imageTrackingConfig.imageURL)?[relationship] else {
                    continue
                }
                updateAdditionalWidgetViewController(node: nodePair.node, widgetConfiguration: relationship.widgetConfiguration)
            }
        }
    }

    func session(_: ARSession, didFailWithError error: Error) {
        guard error is ARError else { return }

        let errorWithInfo = error as NSError
        let messages = [
            errorWithInfo.localizedDescription,
            errorWithInfo.localizedFailureReason,
            errorWithInfo.localizedRecoverySuggestion,
        ]

        // Use `flatMap(_:)` to remove optional error messages.
        let errorMessage = messages.compactMap { $0 }.joined(separator: "\n")

        DispatchQueue.main.async {
            self.displayErrorMessage(title: "The AR session failed.", message: errorMessage)
        }
    }

    // MARK: - Error handling

    func displayErrorMessage(title: String, message: String) {
        // Present an alert informing about the error that has occurred.
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let restartAction = UIAlertAction(title: "Restart Session", style: .default) { _ in
            alertController.dismiss(animated: true, completion: nil)
            self.resetTracking()
        }
        alertController.addAction(restartAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension ARKitViewController {
    func updateAdditionalWidgetViewController(node: SCNWidgetNode, widgetConfiguration: WidgetConfiguration) {
        for (key, config) in widgetConfiguration.additionalWidgetConfiguration {
            if node.additionalWidgetNodes[key] == nil {
                // Add new additional widget!
                DispatchQueue.main.async {
                    let newNode = SCNWidgetNode(widgetConfiguration: config.widgetConfiguration)
                    let plane = SCNPlane()
                    plane.width = config.widgetConfiguration.size.width * config.widgetConfiguration.scale
                    plane.height = config.widgetConfiguration.size.width * config.widgetConfiguration.scale
                    newNode.geometry = plane

                    let widgetViewController = WidgetInARViewController(node: newNode) { [weak self] widgetNode in
                        if let self = self {
                            self.focusedWidgetNode.send(widgetNode)
                        }
                    } chartConfigurationFocusCallback: { [weak self] chartConfiguration in
                        if let self = self {
                            self.focusedChartConfiguration.send(chartConfiguration)
                        }
                    }
                    node.additionalWidgetNodes[key] = newNode
                    node.additionalWidgetNodes[key]?.widgetViewController = widgetViewController

                    let material: SCNMaterial = {
                        let material = SCNMaterial()
                        material.diffuse.contents = widgetViewController.view
                        return material
                    }()
                    newNode.geometry?.materials = [material]
                    node.addChildNode(newNode)

                    let anchor: WidgetAnchorPoint = {
                        if config.widgetConfiguration.relativeAnchorPoint == .auto {
                            let usedAnchorPoints = widgetConfiguration.additionalWidgetConfiguration.map { $0.1.widgetConfiguration.relativeAnchorPoint }
                            return WidgetAnchorPoint.allCases.first(where: { !usedAnchorPoints.contains($0) }) ?? .top
                        } else {
                            return config.widgetConfiguration.relativeAnchorPoint
                        }
                    }()

                    guard let originalNodePlane = node.geometry as? SCNPlane,
                          let newNodePlane = newNode.geometry as? SCNPlane else {
                        fatalErrorDebug()
                        return
                    }

                    let oPlaneRealSize: CGSize = {
                        let oWidgetConfig = node.widgetConfiguration
                        let oWidgetSize = oWidgetConfig.size
                        let oPlaneSize = originalNodePlane.size
                        let oSquareSize = max(oWidgetSize.width, oWidgetSize.height)
                        return CGSize(width: oPlaneSize.width * oWidgetSize.width / oSquareSize, height: oPlaneSize.height * oWidgetSize.height / oSquareSize)
                    }()

                    let nPlaneRealSize: CGSize = {
                        let nWidgetConfig = config.widgetConfiguration
                        let nWidgetSize = nWidgetConfig.size
                        let nPlaneSize = newNodePlane.size
                        let nSquareSize = max(nWidgetSize.width, nWidgetSize.height)
                        return CGSize(width: nPlaneSize.width * nWidgetSize.width / nSquareSize, height: nPlaneSize.height * nWidgetSize.height / nSquareSize)
                    }()

                    var xOffset: CGFloat
                    var yOffset: CGFloat
                    switch anchor {
                    case .bottom:
                        xOffset = 0
                        yOffset = -oPlaneRealSize.height / 2 - nPlaneRealSize.height / 2
                    case .center:
                        xOffset = 0
                        yOffset = 0
                    case .leading:
                        xOffset = -oPlaneRealSize.width / 2 - nPlaneRealSize.width / 2
                        yOffset = 0
                    case .top:
                        xOffset = 0
                        yOffset = oPlaneRealSize.height / 2 + nPlaneRealSize.height / 2
                    case .trailing:
                        xOffset = oPlaneRealSize.width / 2 + nPlaneRealSize.width / 2
                        yOffset = 0
                    case .cover:
                        xOffset = 0
                        yOffset = 0
                    case .auto:
                        xOffset = 0
                        yOffset = 0
                    }
                    newNode.position = config.widgetConfiguration.relativePosition +
                        config.widgetConfiguration.positionOffset +
                        SCNVector3(Float(xOffset), Float(yOffset), 0)
                }
            }
            if let childNode = node.additionalWidgetNodes[key] {
                updateAdditionalWidgetViewController(node: childNode, widgetConfiguration: config.widgetConfiguration)
            }
        }
    }
}
