//
//  FAQTableViewCell.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 18/04/21.
//

import UIKit
import Reusable

class FAQTableViewCell: UITableViewCell, NibReusable {
    @IBOutlet weak var labelQuestion: UILabel!
    @IBOutlet weak var buttonArrow: UIButton!
    @IBOutlet weak var insideView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setup(){
        buttonArrow.setImage(UIImage(named: "arrow")?.withRenderingMode(.alwaysTemplate), for: .normal)
        buttonArrow.tintColor = .darkGray
        insideView.applyCorner(corner: 10)
        insideView.applyBorder(borderWidth: 1, borderColor: UIColor.black.cgColor)
    }
    
    func setupInfo(question: String){
        labelQuestion.text = question
    }
    
}
