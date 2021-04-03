//
//  TravelView.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 16/02/21.
//

import UIKit
import Reusable

class TravelView: UIView, NibLoadable {
    @IBOutlet weak var contentView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLayout()
    }
    
    private func setupLayout(){
        backgroundColor = .white
        contentView.applyCorner(corner: 30)
        contentView.applyBorder(borderWidth: 1, borderColor: UIColor.black.cgColor)
        contentView.applyShadow(opacity: 0.2, shadowRadius: 5)
    }

}
