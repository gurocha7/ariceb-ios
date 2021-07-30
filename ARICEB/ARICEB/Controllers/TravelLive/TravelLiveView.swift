//
//  TravelLiveView.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 28/06/21.
//

import UIKit
import Reusable
import ARKit
import CoreMotion

class TravelLiveView: UIView, NibLoadable {
    //MARK: - Propeties
    var viewModel: TravelLiveViewModel?
    private let arConfig = ARWorldTrackingConfiguration() //faz a utilização da camêra com AR e monitora a posicão e orientação do device
    
    private var managerMotion: CMMotionManager = CMMotionManager()
    private var timer: Timer!
    private var firstPosition: Double = 0.0
    
    var didTapQRCodeButton: (() -> Void)?
    
    var rotateDegrees: Double = 85
    private var canShowRote: Bool = false
    
    //MARK: - OUTLETS
    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var buttonQrCode: UIButton!
    
    @IBAction func qrCodeButtonAction(_ sender: Any) {
        didTapQRCodeButton?()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
//        addNodeBox()
        setupButtons()
    }
    
    private func setupButtons() {
        buttonQrCode.layer.cornerRadius = 6
    }

    private func setupUI() {
        sceneView.session.run(arConfig)
//        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        sceneView.autoenablesDefaultLighting = true //ARKit adiciona luz automaticamente no objeto renderizado
    }
    
    func startDeviceMotion() {
        if managerMotion.isDeviceMotionAvailable {
            self.managerMotion.deviceMotionUpdateInterval = 1.0 / 60.0
            self.managerMotion.showsDeviceMovementDisplay = true
            self.managerMotion.startDeviceMotionUpdates(using: .xMagneticNorthZVertical)
            // Configure a timer to fetch the motion data.
            self.timer = Timer(fire: Date(), interval: 5, repeats: true,
                               block: { (timer) in
                                if let data = self.managerMotion.deviceMotion {
                                    // Get the attitude relative to the magnetic north reference frame.
                                    debugPrint("==> DEGREES: ",data.heading)
                                    debugPrint("==============================")
                                    debugPrint("==> FIRST VALUE: ",self.firstPosition)
                                    if self.firstPosition == 0.0 {
                                        self.firstPosition = data.heading
                                    }else {
                                        let motionRightResult = data.heading >= (self.firstPosition + self.rotateDegrees)
                                        debugPrint("==> motionRightResult: ",motionRightResult)
                                        let motionLeftResult = data.heading <= (self.firstPosition - self.rotateDegrees)
                                        debugPrint("==> motionLeftResult: ",motionLeftResult)
                                        if motionLeftResult || motionRightResult {
                                            debugPrint("**PODE TRAÇAR A ROTA INTERNA**")
                                            self.canShowRote = true
                                            self.addNodeBox()
                                            return
                                        }
                                    }
                                    // Use the motion data in your app.
                                }
            })
            // Add the timer to the current run loop.
            RunLoop.current.add(self.timer!, forMode: RunLoop.Mode.default)
        }
    }
    
    func addNodeBox() {
        let firstScene = SCNScene()
        let box = SCNBox(width: 0.3, height: 0.3, length: 0.3, chamferRadius: 0.1)
        box.firstMaterial?.diffuse.contents = UIColor.purple //adiciona cor para o material desenhado na tela
        box.firstMaterial?.specular.contents = 0.7 //adiciona brilho ao material
        
        let triangle = SCNGeometry.triangleFrom(vector1: SCNVector3(-1, 0, 1), vector2: SCNVector3(1, 0, 1), vector3: SCNVector3(0, 1, 1))
        let triangle2 = SCNGeometry.triangleFrom(vector1: SCNVector3(-1, 0, 1), vector2: SCNVector3(1, 0, 1), vector3: SCNVector3(0, 1, 1))
        let triangle3 = SCNGeometry.triangleFrom(vector1: SCNVector3(-1, 0, 1), vector2: SCNVector3(1, 0, 1), vector3: SCNVector3(0, 1, 1))
        
        let nodeBox = SCNNode(geometry: triangle)
        nodeBox.position = SCNVector3(0,-0.5, -1.50)
        nodeBox.scale = SCNVector3(0.1, 0.1, 0.1)
        let nodeBox2 = SCNNode(geometry: triangle2)
        nodeBox2.position = SCNVector3(0,-0.5, -0.9)
        nodeBox2.scale = SCNVector3(0.1, 0.1, 0.1)
        let nodeBox3 = SCNNode(geometry: triangle3)
        nodeBox3.position = SCNVector3(0,-0.5, -0.5)
        nodeBox3.scale = SCNVector3(0.1, 0.1, 0.1)
        
        firstScene.rootNode.addChildNode(nodeBox)
        firstScene.rootNode.addChildNode(nodeBox2)
        firstScene.rootNode.addChildNode(nodeBox3)
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
