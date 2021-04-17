//
//  LocationView.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 17/04/21.
//

import UIKit
import Reusable

class LocationView: UIView, NibLoadable {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var stack: UIStackView!
    @IBOutlet weak var gpsView: LocationOptionView!
    @IBOutlet weak var qrCodeView: LocationOptionView!
    @IBOutlet weak var manualView: LocationOptionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup(){
        clearStack()
        labelTitle.text = "Você pode determinar seu ponto de origem utilizando  um dos métodos a seguir:"
        setupStack()
    }
    
    
    private func setupStack(){
        gpsView = LocationOptionView.loadFromNib()
        gpsView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        qrCodeView = LocationOptionView.loadFromNib()
        qrCodeView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        manualView = LocationOptionView.loadFromNib()
        manualView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        stack.addArrangedSubview(gpsView)
        stack.addArrangedSubview(qrCodeView)
        stack.addArrangedSubview(manualView)
        gpsView.setup()
        qrCodeView.setup()
        manualView.setup()
    }
    
    private func clearStack(){
        stack.arrangedSubviews.forEach { $0.removeFromSuperview() }
    }
}
