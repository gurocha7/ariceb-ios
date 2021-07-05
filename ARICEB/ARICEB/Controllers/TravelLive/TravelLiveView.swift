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
    var viewModel: TravelLiveViewModel?
    private let arConfig = ARWorldTrackingConfiguration() //faz a utilização da camêra com AR e monitora a posicão e orientação do device
    
    //MARK: - OUTLETS
    @IBOutlet weak var sceneView: ARSCNView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
//        addNodeBox()
    }

    private func setupUI() {
        sceneView.session.run(arConfig)
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        sceneView.autoenablesDefaultLighting = true //ARKit adiciona luz automaticamente no objeto renderizado
    }
    
    private func addNodeBox() {
        let firstScene = SCNScene()
        let box = SCNBox(width: 0.3, height: 0.3, length: 0.3, chamferRadius: 0.1)
        box.firstMaterial?.diffuse.contents = UIColor.purple //adiciona cor para o material desenhado na tela
        box.firstMaterial?.specular.contents = 0.7 //adiciona brilho ao material
        
        let triangle = SCNGeometry.triangleFrom(vector1: SCNVector3(1, 0, 1), vector2: SCNVector3(1, 1, -1), vector3: SCNVector3(-1, 1, 1))
        
        let nodeBox = SCNNode(geometry: triangle)
        nodeBox.position = SCNVector3(0, 0, -0.2)
        nodeBox.scale = SCNVector3(0.1, 0.1, 0.1)
        
        firstScene.rootNode.addChildNode(nodeBox)
        sceneView.scene = firstScene
    }
}

extension SCNGeometry {
    static func Plane(width: CGFloat, height: CGFloat) -> SCNGeometry {
        let src = SCNGeometrySource(vertices: [
            SCNVector3(-width / 2, -height / 2, 0),
            SCNVector3(width / 2, -height / 2, 0),
            SCNVector3(-width / 2, height / 2, 0),
            SCNVector3(width / 2, height / 2, 0),
        ])
        let indices: [UInt32] = [0, 1, 2, 3]
        let normals = SCNGeometrySource(normals: [SCNVector3](repeating: SCNVector3(0, 0, 1), count: 4) )
        let textureMap = SCNGeometrySource(textureCoordinates: [
            CGPoint(x: 0, y: 1),
            CGPoint(x: 1, y: 1),
            CGPoint(x: 0, y: 0),
            CGPoint(x: 1, y: 0)
        ])
        let inds = SCNGeometryElement(indices: indices, primitiveType: .triangleStrip)
        return SCNGeometry.init(sources: [src, normals, textureMap], elements: [inds])
    }
    
    class func triangleFrom(vector1: SCNVector3, vector2: SCNVector3, vector3: SCNVector3) -> SCNGeometry {
        let indices: [Int32] = [0, 1, 2]
        let source = SCNGeometrySource(vertices: [vector1, vector2, vector3])
        let element = SCNGeometryElement(indices: indices, primitiveType: .triangles)
        return SCNGeometry(sources: [source], elements: [element])
    }
}
