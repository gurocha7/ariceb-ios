//
//  BannerView.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 16/02/21.
//

import UIKit
import Reusable

class BannerView: UIView, NibLoadable {

    @IBOutlet weak var imageEvent: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLayout()
    }
    
    private func setupLayout(){
        imageEvent.image = UIImage(named: "event-image")?.withRenderingMode(.alwaysOriginal)
    }

}
