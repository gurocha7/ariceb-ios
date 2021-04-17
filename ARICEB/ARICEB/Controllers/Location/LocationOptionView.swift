//
//  LocationOptionView.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 17/04/21.
//

import UIKit
import Reusable

class LocationOptionView: UIView, NibLoadable {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBAction func buttonAction(_ sender: Any) {
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(){
        contentView.applyCorner(corner: 10)
        contentView.applyBorder(borderWidth: 1, borderColor: UIColor.darkGray.cgColor)
    }

}
