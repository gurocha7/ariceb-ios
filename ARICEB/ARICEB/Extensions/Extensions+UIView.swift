//
//  Extensions+UIView.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 02/04/21.
//

import UIKit

extension UIView {
    func applyCircle(){
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.width / 2
    }
    
    func applyCorner(corner: Int){
        self.layer.cornerRadius = CGFloat(corner)
    }
    
    func applyBorder(borderWidth: CGFloat,borderColor: CGColor){
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor
    }
    
    func applyShadow( opacity: Float, shadowRadius: CGFloat){
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 2)
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOpacity = opacity
    }
}
