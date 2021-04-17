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
        self.selectedBackgroundView = UIView()
    }
    
    private func setup(){
        insideView.applyCorner(corner: 25)
        insideView.applyBorder(borderWidth: 1, borderColor: UIColor.darkGray.cgColor)
    }
    
    func setupTitle(title: String?){
        guard let _title = title else {return}
        label.textColor = .black
        label.font = UIFont(name: "Helvetica Neue Bold", size: 20)
        label.text = _title
    }
    
    func setupFAQTitle(title: String?){
        insideView.backgroundColor = .clear
        insideView.applyBorder(borderWidth: 0, borderColor: UIColor.clear.cgColor)
        guard let _title = title else {return}
        label.attributedText = NSAttributedString(string: _title, attributes: [NSAttributedString.Key.font : UIFont(name: "Helvetica Neue Regular", size: 20) ?? UIFont.systemFont(ofSize: 20, weight: .regular)  ,NSAttributedString.Key.foregroundColor : UIColor.white])
    }
    
}
