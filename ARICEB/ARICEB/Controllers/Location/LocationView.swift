//
//  LocationView.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 17/04/21.
//

import UIKit
import Reusable

class LocationView: UIView, NibLoadable {
    
    var didTapGPSOption:(() -> Void)?
    var didTapQRCodeOption:(() -> Void)?
    var didTapManualOption:(() -> Void)?
    
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
        setupTitle()
        clearStack()
        setupStack()
        bindEvents()
    }
    
    private func setupTitle(){
        let att = NSMutableAttributedString()
        att.append(NSAttributedString(string: "Você pode determinar seu ponto de origem\n utilizando um dos métodos a seguir:", attributes: [NSAttributedString.Key.font : UIFont(name: "Helvetica Neue Bold", size: 14) ?? UIFont.systemFont(ofSize: 14, weight: .bold), NSAttributedString.Key.foregroundColor : UIColor.black.cgColor ]))
        labelTitle.attributedText = att
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
        gpsView.setup(type: .gps)
        qrCodeView.setup(type: .qrcode)
        manualView.setup(type: .manual)
    }
    
    private func clearStack(){
        stack.arrangedSubviews.forEach { $0.removeFromSuperview() }
    }
    
    private func bindEvents(){
        gpsView.didTapOption = { [weak self] in
            self?.didTapGPSOption?()
        }
        
        qrCodeView.didTapOption = { [weak self] in
            self?.didTapQRCodeOption?()
        }
        
        manualView.didTapOption = { [weak self] in
            self?.didTapManualOption?()
        }
    }
}
