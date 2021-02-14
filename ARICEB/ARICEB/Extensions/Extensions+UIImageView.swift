//
//  Extensions+UIImageView.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 14/02/21.
//

import UIKit

extension UIImageView {
    func applyCircle(){
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.width / 2
    }
    
    func applyBorder(corner: Int){
        self.layer.cornerRadius = CGFloat(corner)
    }
}
