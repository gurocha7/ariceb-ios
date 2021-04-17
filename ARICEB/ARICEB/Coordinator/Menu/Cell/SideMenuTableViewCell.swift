//
//  SideMenuTableViewCell.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 17/04/21.
//

import UIKit
import Reusable

class SideMenuTableViewCell: UITableViewCell, NibReusable {
    @IBOutlet weak var insideView: UIView!
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setup(){
        insideView.applyCorner(corner: 25)
        insideView.applyBorder(borderWidth: 1, borderColor: UIColor.darkGray.cgColor)
    }
    
    func setupTitle(title: String?){
        label.text = title
    }
    
}
