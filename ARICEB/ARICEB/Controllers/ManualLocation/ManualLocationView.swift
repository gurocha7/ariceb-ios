//
//  ManualLocationView.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 17/04/21.
//

import UIKit
import Reusable

class ManualLocationView: UIView, NibLoadable {
    
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var buttonConfirm: UIButton!
    @IBOutlet weak var firstAddress: UIView!
    @IBOutlet weak var secondAddress: UIView!
    @IBOutlet weak var thirdAddress: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
