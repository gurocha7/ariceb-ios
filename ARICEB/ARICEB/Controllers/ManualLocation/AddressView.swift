//
//  AddressView.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 17/04/21.
//

import UIKit
import Reusable

class AddressView: UIView, NibLoadable {
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageArrow: UIImageView!
    
    @IBAction func didTap(_ sender: Any) {
        if canEditAddress {
            didTap?()
        }
    }
    
    var didTap:(() -> Void)?
    
    var canEditAddress: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(canEdit: Bool = false){
        canEditAddress = canEdit
        borderView.applyCorner(corner: 20)
        borderView.applyBorder(borderWidth: 1, borderColor: canEditAddress ? UIColor.darkGray.cgColor : UIColor.lightGray.cgColor)
        imageArrow.image = UIImage(named: "arrow")?.withRenderingMode(.alwaysTemplate)
        imageArrow.tintColor = canEditAddress ? .darkGray : .lightGray
    }
    
    func setupPlaceholder(placeholder: String?){
        label.attributedText = NSAttributedString(string: placeholder ?? "",
                                                  attributes: [NSAttributedString.Key.font : UIFont(name: "Helvetica Neue Semibold", size: 14) ?? UIFont.systemFont(ofSize: 14, weight: .semibold),
                                                               NSAttributedString.Key.foregroundColor : canEditAddress ? UIColor.darkGray : UIColor.lightGray])
        self.layoutIfNeeded()
    }
    
    func updateToEdit(){
        canEditAddress = true
        borderView.applyBorder(borderWidth: 1, borderColor: UIColor.darkGray.cgColor )
        imageArrow.tintColor = .darkGray
        self.layoutIfNeeded()
    }

}
