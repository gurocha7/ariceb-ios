//
//  SelectOriginDestinyView.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 16/04/21.
//

import UIKit
import Reusable

class SelectOriginDestinyView: UIView, NibLoadable{
    
    enum OriginViewState{
        case open
        case closed
    }
    
    let smallHeight = 58
    let bigHeight = 190
    
    var originViewState: OriginViewState = .open
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var originView: UIView!
    @IBOutlet weak var buttonArrowOrigin: UIButton!
    @IBAction func didTapButtonArrowOrigin(_ sender: Any) {
        updateOriginView()
    }
    
    @IBOutlet weak var constOriginViewHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func updateOriginView(){
        let isClosed = originViewState == OriginViewState.closed
        originViewState = isClosed ? .open : .closed
        UIView.animate(withDuration: 0.4) { [weak self] in
            self?.constOriginViewHeight.constant = isClosed ? 190 : 58
            self?.layoutIfNeeded()
        }
    }
    
}
