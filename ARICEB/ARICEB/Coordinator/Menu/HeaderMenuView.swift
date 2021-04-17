//
//  HeaderMenuView.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 17/04/21.
//

import UIKit
import Reusable

class HeaderMenuView: UIView , NibLoadable{

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup(){
        self.backgroundColor = .clear
    }
    
}
