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
    
    //MARK: - Properties
    let customView: TravelLiveView = TravelLiveView.loadFromNib()
    private var viewModel: TravelLiveViewModel = TravelLiveViewModel()
    private let sceneLocationView = SceneLocationView()
    private var hasRouteToScene: Bool = false

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
        getMockLocation()
    }
        
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneLocationView.pause()
    }

    private func setupUI() {
        sceneLocationView.showAxesNode = false
        sceneLocationView.showFeaturePoints = false
        sceneLocationView.locationNodeTouchDelegate = self
//        sceneLocationView.arViewDelegate  = self
        sceneLocationView.sceneTrackingDelegate = self
        customView.addSubview(sceneLocationView)
        sceneLocationView.frame = customView.bounds
    }
    
    private func bindEvents() {
        viewModel.didShowRoutes = { [weak self] (routes) in
            self?.sceneLocationView.run()
            self?.addRoutesToScene(routes: routes)
        }
    }
    
    private func getMockLocation() {
        viewModel.getRoute(originLat: -20.153360, originLong: -44.903800, destinyLat: -20.153983, destinyLong: -44.903949)
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
