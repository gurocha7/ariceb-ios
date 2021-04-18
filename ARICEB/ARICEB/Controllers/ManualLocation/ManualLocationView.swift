//
//  ManualLocationView.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 17/04/21.
//

import UIKit
import Reusable

class ManualLocationView: UIView, NibLoadable {
    
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var labelInfo: UILabel!
    @IBOutlet weak var stack: UIStackView!
    @IBOutlet weak var buttonConfirm: UIButton!
    @IBOutlet weak var firstAddressView: AddressView!
    @IBOutlet weak var secondAddressView: AddressView!
    @IBOutlet weak var thirdAddressView: AddressView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup(){
        setupInfoView()
        clearStack()
        setupStack()
        setupButton()
    }
    
    private func setupInfoView(){
        infoView.applyCorner(corner: 10)
        labelInfo.attributedText = NSAttributedString(string: "Selecione o local que você se encontra neste momento. Ex: ICEB - Departamento de Matemática, Sala 9", attributes: [NSAttributedString.Key.font : UIFont(name: "Helvetica Neue Regular", size: 14) ?? UIFont.systemFont(ofSize: 14, weight: .regular), NSAttributedString.Key.foregroundColor : UIColor.black])
    }

    private func clearStack(){
        stack.arrangedSubviews.forEach { $0.removeFromSuperview() }
    }
    
    private func setupStack(){
        firstAddressView = AddressView.loadFromNib()
        secondAddressView = AddressView.loadFromNib()
        thirdAddressView = AddressView.loadFromNib()
        firstAddressView.heightAnchor.constraint(equalToConstant: 42).isActive = true
        secondAddressView.heightAnchor.constraint(equalToConstant: 42).isActive = true
        thirdAddressView.heightAnchor.constraint(equalToConstant: 42).isActive = true
        stack.addArrangedSubview(firstAddressView)
        stack.addArrangedSubview(secondAddressView)
        stack.addArrangedSubview(thirdAddressView)
    }
    
    private func setupButton(){
        
    }
    
}
