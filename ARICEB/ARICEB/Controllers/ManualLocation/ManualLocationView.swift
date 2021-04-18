//
//  ManualLocationView.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 17/04/21.
//

import UIKit
import Reusable

class ManualLocationView: UIView, NibLoadable {
    
    var viewModel: ManualLocationViewModel?
    
    var didTapFirstAddress: (() -> Void)?
    var didTapSecondAddress: (() -> Void)?
    var didTapThirdAddress: (() -> Void)?
    
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
        bindEvents()
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
        firstAddressView.heightAnchor.constraint(equalToConstant: 45).isActive = true
        secondAddressView.heightAnchor.constraint(equalToConstant: 45).isActive = true
        thirdAddressView.heightAnchor.constraint(equalToConstant: 45).isActive = true
        stack.addArrangedSubview(firstAddressView)
        stack.addArrangedSubview(secondAddressView)
        stack.addArrangedSubview(thirdAddressView)
        firstAddressView.setup(canEdit: true)
        secondAddressView.setup()
        thirdAddressView.setup()
    }
    
    private func setupButton(){
        buttonConfirm.isEnabled = false
        buttonConfirm.setTitleColor(#colorLiteral(red: 0.7058823529, green: 0.7058823529, blue: 0.7058823529, alpha: 1), for: .normal)
        buttonConfirm.applyCorner(corner: 30)
        buttonConfirm.applyBorder(borderWidth: 1, borderColor: UIColor.darkGray.cgColor)
        buttonConfirm.setAttributedTitle(NSAttributedString(string: "CONFIRMAR",
                                                            attributes: [NSAttributedString.Key.font : UIFont(name: "Helvetica Neue Bold", size: 20) ?? UIFont.systemFont(ofSize: 20, weight: .bold),
                                                                         NSAttributedString.Key.foregroundColor : UIColor.white]), for: .normal)
    }
    
    private func bindEvents(){
        firstAddressView.didTapEdit = { [weak self] in
            self?.didTapFirstAddress?()
        }
        
        secondAddressView.didTapEdit  = { [weak self] in
            self?.didTapSecondAddress?()
        }
        
        thirdAddressView.didTapEdit  = { [weak self] in
            self?.didTapThirdAddress?()
        }
    }
    
    func setupPlaceholders(){
        firstAddressView.setupPlaceholder(placeholder: viewModel?.getFirstPlaceholder())
        secondAddressView.setupPlaceholder(placeholder: viewModel?.getSecondPlaceholder())
        thirdAddressView.setupPlaceholder(placeholder: viewModel?.getThirdPlaceholder())
    }
    
    func enableSecondAddresToEdit(){
        secondAddressView.updateToEdit()
    }
    
    func enableThirdAddresToEdit(){
        thirdAddressView.updateToEdit()
    }
    
}
