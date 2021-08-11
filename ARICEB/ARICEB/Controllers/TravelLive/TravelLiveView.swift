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
    
    enum LastIndicatorType: String {
        case direita = "r"
        case esquerda = "l"
        case subir = "u"
        case descer = "d"
        case subirAdireita = "ru"
    }
    
    //MARK: - Propeties
    var viewModel: TravelLiveViewModel?
    private var arConfig = ARWorldTrackingConfiguration() //faz a utilização da camêra com AR e monitora a posicão e orientação do device
    
    private var managerMotion: CMMotionManager = CMMotionManager()
    private var timer: Timer!
    private var firstPosition: Double = 0.0
    
    var didTapQRCodeButton: (() -> Void)?
    var didFinishTravel: (() -> Void)?
    
    var rotateDegrees: Double = 80
    var needRotateToRight: Bool = false
    var distanceToDraw: Double?
    var lastIndicatorToRight: Bool = false
    var lastIndicatorTypeValue: LastIndicatorType = .direita
    
    //MARK: - OUTLETS
    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var buttonQrCode: UIButton!
    @IBOutlet weak var buttonFinish: UIButton!
    @IBOutlet weak var imageArrowUP: UIImageView!
    @IBOutlet weak var imageArrowDown: UIImageView!
    @IBOutlet weak var timerView: UIView!
    @IBOutlet weak var labelTimerView: UILabel!
    
    @IBAction func qrCodeButtonAction(_ sender: Any) {
        didTapQRCodeButton?()
    }
    
    @IBAction func buttonFinish(_ sender: Any) {
        didFinishTravel?()
    }
    
    deinit {
        removeAllNodes()
        sceneView.session.pause()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
//        addNodeBox()
        setupButtons()
    }
    
    private func removeAllNodes() {
        sceneView.scene.rootNode.childNodes.forEach { (child) in
            child.removeFromParentNode()
        }
    }
    
    private func setupButtons() {
        buttonQrCode.layer.cornerRadius = 6
        buttonFinish.layer.cornerRadius = 6
    }

    private func setupUI() {
        sceneView.session.run(arConfig)
//        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        sceneView.autoenablesDefaultLighting = true //ARKit adiciona luz automaticamente no objeto renderizado
        setupArrowsColor()
    }
    
    private func setupArrowsColor() {
        imageArrowUP.image = UIImage(named: "icon-up-arrow")?.withRenderingMode(.alwaysTemplate)
        imageArrowUP.tintColor = .green
        imageArrowDown.image = UIImage(named: "icon-down-arrow")?.withRenderingMode(.alwaysTemplate)
        imageArrowDown.tintColor = .red
    }
    
    func addNodeBox() {
        let firstScene = SCNScene()
        let box = SCNBox(width: 0.3, height: 0.3, length: 0.3, chamferRadius: 0.1)
        box.firstMaterial?.diffuse.contents = UIColor.purple //adiciona cor para o material desenhado na tela
        box.firstMaterial?.specular.contents = 0.7 //adiciona brilho ao material
        let triangle = SCNGeometry.triangleFrom(vector1: SCNVector3(-1, 0, 1), vector2: SCNVector3(1, 0, 1), vector3: SCNVector3(0, 1, 1))
        let nodeBox = SCNNode(geometry: triangle)
        nodeBox.position = SCNVector3(0,-0.5, -1.50)
        nodeBox.scale = SCNVector3(0.1, 0.1, 0.1)
        firstScene.rootNode.addChildNode(nodeBox)
        sceneView.scene = firstScene
    }
    
    func addFirstSteps() {
//        sceneView.session.run(arConfig,options: .resetTracking)
        guard let step = viewModel?.getFirstSteps() else {return}
        setStepsAndParams(step)
//        drawStepsForUser()
//        startDeviceMotion()
    }
    
    func addStepsByIndex(_ index: Int) {
//        sceneView.session.run(arConfig,options: .resetTracking)
        guard let step = viewModel?.getStepsByIndex(index) else {return}
        setStepsAndParams(step)
//        drawStepsForUser()
//        startDeviceMotion()
    }
    
    private func setStepsAndParams(_ step: StepsModel) {
//        guard let angle = step.angle else {return}
//        guard let direction = step.rotatePhone else {return}
        guard let distance = step.distance else {return}
//        rotateDegrees = angle
//        needRotateToRight = direction.lowercased() == "r"
        distanceToDraw = distance
        if let lastIndicator = step.lastIndicator {
            switch lastIndicator.lowercased() {
            case LastIndicatorType.direita.rawValue:
                lastIndicatorToRight = true
                lastIndicatorTypeValue = .direita
            case LastIndicatorType.esquerda.rawValue:
                lastIndicatorToRight = false
                lastIndicatorTypeValue = .esquerda
            case LastIndicatorType.descer.rawValue:
                lastIndicatorTypeValue = .descer
            case LastIndicatorType.subir.rawValue:
                lastIndicatorTypeValue = .subir
            case LastIndicatorType.subirAdireita.rawValue:
                lastIndicatorTypeValue = .subirAdireita
            default:
                break
            }
        }
    }

    func drawStepsForUser() {
        let firstScene = SCNScene()
        let triangle = SCNGeometry.triangleFrom(vector1: SCNVector3(-1, 0, 1), vector2: SCNVector3(1, 0, 1), vector3: SCNVector3(0, 1, 1))
        triangle.firstMaterial?.diffuse.contents = UIColor.orange
        triangle.firstMaterial?.specular.contents = 0.7
        let distanceInteger = Int(distanceToDraw ?? 0)
        for i in 1...distanceInteger {
            let nodeBox = SCNNode(geometry: triangle)
            nodeBox.position = SCNVector3(0,-0.5, Double(-i))
            nodeBox.scale = SCNVector3(0.1, 0.1, 0.1)
            if lastIndicatorTypeValue == .descer {
                triangle.firstMaterial?.diffuse.contents = UIColor.red
            }else if lastIndicatorTypeValue == .subir || lastIndicatorTypeValue == .subirAdireita {
                triangle.firstMaterial?.diffuse.contents = UIColor.green
            } else {
                
            }
            firstScene.rootNode.addChildNode(nodeBox)
        }
        sceneView.scene = firstScene
        if let timerValue =  UserDefaults.standard.value(forKey: "lastTimerForQrCode") as? Double {
            labelTimerView.text = "\(timerValue)"
            if let byAPI = UserDefaults.standard.value(forKey: "getQRCodeByAPI") as? Bool {
                timerView.backgroundColor = byAPI ? .blue : .green
            }
        }
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
