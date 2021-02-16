//
//  TravelView.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 16/02/21.
//

import UIKit
import Reusable

class TravelView: UIView, NibLoadable {

    override func awakeFromNib() {
        super.awakeFromNib()
        setupLayout()
    }
    
    private func setupLayout(){
        backgroundColor = .white
    }

}
