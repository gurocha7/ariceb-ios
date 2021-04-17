//
//  SelectOriginDestinyView.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 16/04/21.
//

import UIKit
import Reusable

class SelectOriginDestinyView: UIView, NibLoadable{
    
    let smallHeight = 58
    let bigHeight = 190
    
    //ORIGIN
    enum OriginViewState{
        case open
        case closed
    }
    
    var originViewState: OriginViewState = .closed
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var originView: UIView!
    @IBOutlet weak var buttonArrowOrigin: UIButton!
    @IBAction func didTapButtonArrowOrigin(_ sender: Any) {
        updateOriginView()
    }
    
    
    //DESTINY
    enum DestinyViewState{
        case open
        case closed
    }
    
    var destinyViewState: DestinyViewState = .closed
    @IBOutlet weak var constOriginViewHeight: NSLayoutConstraint!
    @IBOutlet weak var destinyView: UIView!
    @IBAction func buttonArrowDestiny(_ sender: Any) {
        updateDestinyView()
    }

    @IBOutlet weak var constDestinyViewHeight: NSLayoutConstraint!
    
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
    
    private func updateDestinyView(){
        let isClosed = destinyViewState == DestinyViewState.closed
        destinyViewState = isClosed ? .open : .closed
        UIView.animate(withDuration: 0.4) { [weak self] in
            self?.constDestinyViewHeight.constant = isClosed ? 190 : 58
            self?.layoutIfNeeded()
        }
    }
    
}
