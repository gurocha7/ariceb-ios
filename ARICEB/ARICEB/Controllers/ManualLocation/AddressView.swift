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
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(){
        borderView.applyCorner(corner: 20)
        borderView.applyBorder(borderWidth: 1, borderColor: UIColor.darkGray.cgColor)
        imageArrow.image = UIImage(named: "arrow")?.withRenderingMode(.alwaysTemplate)
        imageArrow.tintColor = .darkGray
    }
    
    func setupPlaceholder(placeholder: String?){
        label.attributedText = NSAttributedString(string: placeholder ?? "",
                                                  attributes: [NSAttributedString.Key.font : UIFont(name: "Helvetica Neue Semibold", size: 14) ?? UIFont.systemFont(ofSize: 14, weight: .semibold),
                                                               NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        self.layoutIfNeeded()
    }

}
