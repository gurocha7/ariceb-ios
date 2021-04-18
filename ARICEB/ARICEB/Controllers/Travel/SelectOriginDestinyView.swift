//
//  SelectOriginDestinyView.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 16/04/21.
//

import UIKit
import Reusable

class SelectOriginDestinyView: UIView, NibLoadable{
    
    var viewModel: SelectOriginDestinyViewModel?
    let smallHeight = 58
    let bigHeight = 190
    
    //ORIGIN
    enum OriginViewState{
        case open
        case closed
    }
    
    var shouldSelectOrigin: (() -> Void)?
    var shouldEditOrigin: (() -> Void)?
    var originViewState: OriginViewState = .closed
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var originView: UIView!
    @IBOutlet weak var imageOrigin: UIImageView!
    @IBOutlet weak var labelOriginTitle: UILabel!
    @IBOutlet weak var buttonArrowOrigin: UIButton!
    @IBAction func didTapButtonArrowOrigin(_ sender: Any) {
        updateOriginView()
    }
    
    @IBAction func didTapToSelectOrigin(_ sender: Any) {
        viewModel?.modelOrigin  != nil ? shouldEditOrigin?() : shouldSelectOrigin?()
    }
    
    
    //DESTINY
    enum DestinyViewState{
        case open
        case closed
    }
    
    var shouldSelectDestiny: (() -> Void)?
    var shouldEditDestiny: (() -> Void)?
    var destinyViewState: DestinyViewState = .closed
    @IBOutlet weak var constOriginViewHeight: NSLayoutConstraint!
    @IBOutlet weak var destinyView: UIView!
    @IBOutlet weak var imageDestiny: UIImageView!
    @IBOutlet weak var labelDestinyTitle: UILabel!
    @IBOutlet weak var buttonArrowDestiny: UIButton!
    @IBAction func buttonArrowDestiny(_ sender: Any) {
        updateDestinyView()
    }
    @IBAction func didTapToSelectDestiny(_ sender: Any) {
        viewModel?.modelDestiny != nil ? shouldEditDestiny?() : shouldSelectDestiny?()
    }
    
    @IBOutlet weak var constDestinyViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var buttonConfirmTravel: UIButton!
    @IBAction func buttonConfirmTravel(_ sender: Any) {
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup(){
        setupOriginView()
        setupDestinyView()
        setupButton()
    }
    
    private func setupButton(){
        buttonConfirmTravel.isEnabled = false
        buttonConfirmTravel.backgroundColor = #colorLiteral(red: 0.7058823529, green: 0.7058823529, blue: 0.7058823529, alpha: 1)
        buttonConfirmTravel.applyCorner(corner: 28)
        buttonConfirmTravel.applyBorder(borderWidth: 1, borderColor: UIColor.darkGray.cgColor)
        buttonConfirmTravel.setAttributedTitle(NSAttributedString(string: "MOSTRAR CAMINHO",
                                                            attributes: [NSAttributedString.Key.font : UIFont(name: "Helvetica Neue Bold", size: 20) ?? UIFont.systemFont(ofSize: 20, weight: .bold),
                                                                         NSAttributedString.Key.foregroundColor : UIColor.white]), for: .normal)
    }
    
    private func setupOriginView(){
        originView.applyCorner(corner: 30)
        originView.applyBorder(borderWidth: 1, borderColor: UIColor.darkGray.cgColor)
        imageOrigin.image = UIImage(named: "icon-origin")
        let att = NSMutableAttributedString()
        att.append(NSAttributedString(string: "Selecione sua ",
                                      attributes: [NSAttributedString.Key.font : UIFont(name: "Lato-regular", size: 18) ?? UIFont.systemFont(ofSize: 18, weight: .regular), NSAttributedString.Key.foregroundColor : UIColor.black.cgColor ]))
        att.append(NSAttributedString(string: "origem",
                                      attributes: [NSAttributedString.Key.font :UIFont(name: "Lato-bold", size: 18) ??  UIFont.systemFont(ofSize: 18, weight: .bold), NSAttributedString.Key.foregroundColor : UIColor.black.cgColor ]))
        labelOriginTitle.attributedText = att
        buttonArrowOrigin.setImage(UIImage(named: "arrow"), for: .normal)
        buttonArrowOrigin.isHidden = true
    }
    
    private func setupDestinyView(){
        destinyView.applyCorner(corner: 30)
        destinyView.applyBorder(borderWidth: 1, borderColor: UIColor.darkGray.cgColor)
        imageDestiny.image = UIImage(named: "icon-destiny")
        let att = NSMutableAttributedString()
        att.append(NSAttributedString(string: "Selecione seu ",
                                      attributes: [NSAttributedString.Key.font : UIFont(name: "Lato-regular", size: 18) ?? UIFont.systemFont(ofSize: 18, weight: .regular), NSAttributedString.Key.foregroundColor : UIColor.black.cgColor ]))
        att.append(NSAttributedString(string: "destino",
                                      attributes: [NSAttributedString.Key.font :UIFont(name: "Lato-bold", size: 18) ??  UIFont.systemFont(ofSize: 18, weight: .bold), NSAttributedString.Key.foregroundColor : UIColor.black.cgColor ]))
        labelDestinyTitle.attributedText = att
        buttonArrowDestiny.setImage(UIImage(named: "arrow"), for: .normal)
        buttonArrowDestiny.isHidden = true
    }
    
    private func updateOriginView(){
        let isClosed = originViewState == OriginViewState.closed
        originViewState = isClosed ? .open : .closed
        UIView.animate(withDuration: 0.4) { [weak self] in
            self?.constOriginViewHeight.constant = isClosed ? 190 : 58
            self?.buttonArrowOrigin.transform = isClosed ? CGAffineTransform(rotationAngle: .pi) : CGAffineTransform(rotationAngle: 0.0)
            self?.layoutIfNeeded()
        }
    }
    
    private func updateDestinyView(){
        let isClosed = destinyViewState == DestinyViewState.closed
        destinyViewState = isClosed ? .open : .closed
        UIView.animate(withDuration: 0.4) { [weak self] in
            self?.constDestinyViewHeight.constant = isClosed ? 190 : 58
            self?.buttonArrowDestiny.transform = isClosed ? CGAffineTransform(rotationAngle: .pi) : CGAffineTransform(rotationAngle: 0.0)
            self?.layoutIfNeeded()
        }
    }
    
    func updateOriginLayout(){
        guard let originText = viewModel?.getModelOrigin() else {return}
        originView.applyBorder(borderWidth: 1, borderColor: #colorLiteral(red: 0.01176470588, green: 0.662745098, blue: 0.9568627451, alpha: 1))
        buttonArrowOrigin.isHidden = false
        labelOriginTitle.text = originText
        labelOriginTitle.font = UIFont(name: "Lato-regular", size: 18)
        labelOriginTitle.textColor = .black
        checkIfCompleted()
        self.layoutIfNeeded()
    }
    
    func updateDestinyLayout(){
        guard let originText = viewModel?.getModelDestiny() else {return}
        destinyView.applyBorder(borderWidth: 1, borderColor: #colorLiteral(red: 0.01176470588, green: 0.662745098, blue: 0.9568627451, alpha: 1))
        buttonArrowDestiny.isHidden = false
        labelDestinyTitle.text = originText
        labelDestinyTitle.font = UIFont(name: "Lato-regular", size: 18)
        labelDestinyTitle.textColor = .black
        checkIfCompleted()
        self.layoutIfNeeded()
    }
    
    private func checkIfCompleted(){
        if viewModel?.modelOrigin != nil && viewModel?.modelDestiny != nil {
            enableButtonConfirm()
        }
    }
    
    private func enableButtonConfirm(){
        buttonConfirmTravel.isEnabled = true
        buttonConfirmTravel.backgroundColor = #colorLiteral(red: 0.01176470588, green: 0.662745098, blue: 0.9568627451, alpha: 1)
    }
    
}
