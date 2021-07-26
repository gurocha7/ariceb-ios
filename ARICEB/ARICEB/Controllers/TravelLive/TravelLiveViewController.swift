//
//  TravelLiveViewController.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 28/06/21.
//

import UIKit
import ARCL
import ARKit
import MapKit

class TravelLiveViewController: BaseViewController {
    
    enum RouteType {
        case outToOut
        case inToIn
        case inToOut
        case outToIn
    }
    
    //MARK: - Properties
    let customView: TravelLiveView = TravelLiveView.loadFromNib()
    private var viewModel: TravelLiveViewModel = TravelLiveViewModel()
    private let sceneLocationView = SceneLocationView()
    private var hasRouteToScene: Bool = false
    
    private var routeType: RouteType = .outToOut
    
    //Outdoor -> Outdoor
    private var externalRoute: ExternalRoute? {
        didSet {
            routeType = .outToOut
        }
    }

    
    lazy var buttonQrCode: UIButton = {
        let button = UIButton()
        button.setTitle("Escanear QrCode", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = mainColor
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    //MARK: - Overrides
    override func loadView() {
        super.loadView()
        view = customView
        setupUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.viewModel = viewModel
        bindEvents()
        getRoute()
//        getMockLocation()
    }
        
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneLocationView.pause() 
    }

    private func setupUI() {
        switch routeType {
        case .outToOut:
            sceneLocationView.showAxesNode = false
            sceneLocationView.showFeaturePoints = false
            sceneLocationView.locationNodeTouchDelegate = self
    //        sceneLocationView.arViewDelegate  = self
            sceneLocationView.sceneTrackingDelegate = self
            customView.addSubview(sceneLocationView)
            sceneLocationView.frame = customView.bounds
        default:
            break
        }
    }
    
    private func bindEvents() {
        viewModel.didShowRoutes = { [weak self] (routes) in
            self?.sceneLocationView.run()
            self?.addRoutesToScene(routes: routes)
        }
    }
    
    func setupExternalRoute(route: ExternalRoute) {
        externalRoute = route
    }
    
    private func getRoute() {
        switch routeType {
        case .outToOut:
            buttonQrCode.isHidden = true
            title = "Destino: " + (externalRoute?.buildingDestiny?.name ?? "")
            viewModel.getRoute(originLat: externalRoute?.buildingOrigin?.lat,
                               originLong: externalRoute?.buildingOrigin?.long,
                               destinyLat: externalRoute?.buildingDestiny?.lat,
                               destinyLong: externalRoute?.buildingDestiny?.long)
        default:
            break
        }
    }
    
    private func getMockLocation() {
        viewModel.getRoute(originLat: -20.404285, originLong: -43.509755, destinyLat: -20.403843, destinyLong: -43.509369)
    }
    
    private func addRoutesToScene(routes: [MKRoute]? ) {
        guard sceneLocationView.sceneLocationManager.currentLocation != nil else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                self?.addRoutesToScene(routes: routes)
            }
            return
        }
        
        if let routesValue = routes {
            print("ADDED ROUTES")
            sceneLocationView.addRoutes(routes: routesValue) { distance -> SCNBox in
                let box = SCNBox(width: 1.75, height: 0.5, length: distance, chamferRadius: 0.25)
                box.firstMaterial?.diffuse.contents = UIColor.yellow
                return box
            }
        }else{
            print("NAO CONSEGUIU ADICIONAR AS ROTAS")
            sceneLocationView.pause()
        }
        sceneLocationView.autoenablesDefaultLighting = true
    }
}

extension TravelLiveViewController: SceneTrackingDelegate {
    func sessionWasInterrupted(_ session: ARSession) {
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }
    func sessionInterruptionEnded(_ session: ARSession) {}
    func session(_ session: ARSession, didFailWithError error: Error) {}
    func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera) {}
}

extension TravelLiveViewController: LNTouchDelegate {
    func annotationNodeTouched(node: AnnotationNode) {
        if let node = node.parent as? LocationNode {
            let coords = "\(node.location.coordinate.latitude.short)° \(node.location.coordinate.longitude.short)°"
            let altitude = "\(node.location.altitude.short)m"
            let tag = node.tag ?? ""
//            nodePositionLabel.text = " Annotation node at \(coords), \(altitude) - \(tag)"
            print("###Annotation node at \(coords), \(altitude) - \(tag)")
        }
    }
    
    func locationNodeTouched(node: LocationNode) {
        let coords = "\(node.location.coordinate.latitude.short)° \(node.location.coordinate.longitude.short)°"
        let altitude = "\(node.location.altitude.short)m"
        let tag = node.tag ?? ""
//        nodePositionLabel.text = " Location node at \(coords), \(altitude) - \(tag)"
        print("###Location node at \(coords), \(altitude) - \(tag)")
    }
}

/*
 
 1 - cenário com origem e destino indoor = abre a camera que ira utilizar um reconhecedorde QrCode
     obs: testar a projeção de setas com dados mockados
 
 2 - cenario com origem e destino outdoor = ta pronta, passar apenas lat e long para o maps
 
 3 - Cenario com origem indoor e destino outdoor = começar com camera reonhecendo QrCode e vai ate a porta, quando podera clicar no botao "mostrar caminho externo",    que ira chamar lat e long do cenario 2
 
 4 - Cenario com origem outdoor e destino indoor = inverte a logica do cenario 3
 */
