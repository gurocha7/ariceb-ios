//
//  SubmenuTableViewCell.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 18/04/21.
//

import UIKit
import Reusable

class SubmenuTableViewCell: UITableViewCell, NibReusable {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var insideView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setup(){
        insideView.applyCorner(corner: 10)
        insideView.applyBorder(borderWidth: 1, borderColor: UIColor.black.cgColor)
    }
    
    func setupInfo(name: String){
        label.text = name
    }
    
}
