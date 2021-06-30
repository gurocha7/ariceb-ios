//
//  TravelLiveView.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 28/06/21.
//

import UIKit
import Reusable
import ARKit

class TravelLiveView: UIView, NibLoadable {
    //MARK: - Propeties
    private let arConfig = ARWorldTrackingConfiguration() //faz a utilização da camêra com AR e monitora a posicão e orientação do device
    
    //MARK: - OUTLETS
    @IBOutlet weak var sceneView: ARSCNView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        addNodeBox()
    }

    private func setupUI() {
        sceneView.session.run(arConfig)
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        sceneView.autoenablesDefaultLighting = true //ARKit adiciona luz automaticamente no objeto renderizado
    }
    
    private func addNodeBox() {
        let firstScene = SCNScene()
        let box = SCNBox(width: 1, height: 1, length: 1, chamferRadius: 0.1)
        let nodeBox = SCNNode(geometry: box)
        nodeBox.position = SCNVector3(0, 0, -0.2)
        nodeBox.scale = SCNVector3(0.1, 0.1, 0.1)
        firstScene.rootNode.addChildNode(nodeBox)
        sceneView.scene = firstScene
    }
}
