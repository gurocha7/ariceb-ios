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
    }

    private func setupUI() {
        sceneView.session.run(arConfig)
    }
}
