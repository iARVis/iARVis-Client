//
//  DebugCommon.swift
//  iARVis (iOS)
//
//  Created by Anonymous on 2022/7/31.
//

import Foundation
import SceneKit
import ARKit

class VirtualObjectNode: SCNNode {
    enum VirtualObjectType {
        case duck
    }

    init(type: VirtualObjectType = .duck) {
        super.init()

        let scale = 1.0
        switch type {
        case .duck:
            loadScn(name: "duck", inDirectory: "models.scnassets/duck")
        }
        self.scale = SCNVector3(scale, scale, scale)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func react() {
        SCNTransaction.begin()
        SCNTransaction.animationDuration = 0.3
        SCNTransaction.completionBlock = {
            SCNTransaction.animationDuration = 0.15
            self.opacity = 1.0
        }
        self.opacity = 0.5
        SCNTransaction.commit()
    }
}

extension SCNNode {
    func loadScn(name: String, inDirectory directory: String) {
        guard let scene = SCNScene(named: "\(name).scn", inDirectory: directory) else { fatalError() }
        for child in scene.rootNode.childNodes {
            child.geometry?.firstMaterial?.lightingModel = .physicallyBased
            addChildNode(child)
        }
    }
}

extension SCNView {
    private func enableEnvironmentMap(intensity: CGFloat) {
        if scene?.lightingEnvironment.contents == nil {
            if let environmentMap = UIImage(named: "models.scnassets/sharedImages/environment_blur.exr") {
                scene?.lightingEnvironment.contents = environmentMap
            }
        }
        scene?.lightingEnvironment.intensity = intensity
    }
    
    private func enableSceneBackground() {
        if scene?.background.contents == nil {
            if let environment = UIImage(named: "models.scnassets/sharedImages/environment.jpg") {
                scene?.background.contents = environment
            }
        }
    }
    
    func updateLightingEnvironment(for frame: ARFrame) {
        // If light estimation is enabled, update the intensity of the model's lights and the environment map
        let intensity: CGFloat
        if let lightEstimate = frame.lightEstimate {
            intensity = lightEstimate.ambientIntensity / 400
        } else {
            intensity = 2
        }
        DispatchQueue.main.async(execute: {
            self.enableEnvironmentMap(intensity: intensity)
        })
    }

    func updateSceneBackground(for frame: ARFrame) {
        DispatchQueue.main.async(execute: {
            self.enableSceneBackground()
        })
    }
}

extension ARImageAnchor {
    func addPlaneNode(on node: SCNNode, color: UIColor) {
        let size = referenceImage.physicalSize

        let geometry = SCNPlane(width: size.width, height: size.height)
        geometry.materials.first?.diffuse.contents = color

        let planeNode = SCNNode(geometry: geometry)
        planeNode.transform = SCNMatrix4MakeRotation(-Float.pi / 2.0, 1, 0, 0)

        DispatchQueue.main.async {
            node.addChildNode(planeNode)
        }
    }

    func findPlaneNode(on node: SCNNode) -> SCNNode? {
        for childNode in node.childNodes {
            if childNode.geometry as? SCNPlane != nil {
                return childNode
            }
        }
        return nil
    }

    func updatePlaneNode(on node: SCNNode, scale: CGFloat) {
        let size = referenceImage.physicalSize
        DispatchQueue.main.async {
            guard let planeNode = self.findPlaneNode(on: node) else { return }
            guard let plane = planeNode.geometry as? SCNPlane else { fatalError() }
            // 平面ジオメトリのサイズを更新
            plane.width = size.width * scale
            plane.height = size.height * scale
        }
    }

    func removePlaneNode(on node: SCNNode) {
        DispatchQueue.main.async {
            guard let planeNode = self.findPlaneNode(on: node) else { return }
            planeNode.removeFromParentNode()
        }
    }
}
