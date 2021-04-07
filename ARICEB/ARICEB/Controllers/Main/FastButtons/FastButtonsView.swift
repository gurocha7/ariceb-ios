//
//  FastButtonsView.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 06/04/21.
//

import UIKit
import Reusable

class FastButtonsView: UIView, NibLoadable {
    
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var viewLeft: UIView!
    @IBOutlet weak var viewRight: UIView!
    
    @IBAction func buttonLeftAction(_ sender: Any) {
        
    }
    
    @IBAction func buttonRightAction(_ sender: Any) {
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLayout()
    }
    
    private func setupLayout(){
        viewLeft.applyCorner(corner: 15)
        viewLeft.applyBorder(borderWidth: 0.5, borderColor: UIColor.gray.cgColor)
        viewRight.applyCorner(corner: 15)
        viewRight.applyBorder(borderWidth: 0.5, borderColor: UIColor.gray.cgColor)
    }

}
