//
//  LocationOptionView.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 17/04/21.
//

import UIKit
import Reusable

class LocationOptionView: UIView, NibLoadable {
    
    enum TypeLocationOption{
        case gps
        case qrcode
        case manual
    }
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBAction func buttonAction(_ sender: Any) {
        
    }
    
    var typeLocation: TypeLocationOption = .manual
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    func setup(type: TypeLocationOption = .manual){
        typeLocation = type
        contentView.applyCorner(corner: 10)
        contentView.applyBorder(borderWidth: 1, borderColor: UIColor.darkGray.cgColor)
        setupLayout(type: type)
    }
    
    private func setupLayout(type: TypeLocationOption = .manual){
        switch type {
        case .gps:
            setupGPSLayout()
        case .qrcode:
            setupQRCodeLayout()
        case .manual:
            setupManualLayout()
        }
    }
    
    private func setupGPSLayout(){
        image.image = UIImage(named: "icon-option-gps")
        let att = NSMutableAttributedString()
        att.append(NSAttributedString(string: "GPS", attributes: [NSAttributedString.Key.font : UIFont(name: "Helvetica Neue Bold", size: 18) ?? UIFont.systemFont(ofSize: 18, weight: .bold) , NSAttributedString.Key.foregroundColor : UIColor.black.cgColor]))
        att.append(NSAttributedString(string: "\nRecomendado para ambientes abertos.", attributes:  [NSAttributedString.Key.font : UIFont(name: "Helvetica Neue Regular", size: 12)  ?? UIFont.systemFont(ofSize: 12, weight: .regular) , NSAttributedString.Key.foregroundColor : UIColor.black.cgColor]))
        label.attributedText = att
    }
    
    private func setupQRCodeLayout(){
        image.image = UIImage(named: "icon-option-qrcode")
        let att = NSMutableAttributedString()
        att.append(NSAttributedString(string: "Qr Code", attributes: [NSAttributedString.Key.font : UIFont(name: "Helvetica Neue Bold", size: 18) ?? UIFont.systemFont(ofSize: 18, weight: .bold) , NSAttributedString.Key.foregroundColor : UIColor.black.cgColor]))
        att.append(NSAttributedString(string: "\nEscaneie o QrCode mais próximo para identificarmos sua localização.", attributes:  [NSAttributedString.Key.font : UIFont(name: "Helvetica Neue Regular", size: 12)  ?? UIFont.systemFont(ofSize: 12, weight: .regular) , NSAttributedString.Key.foregroundColor : UIColor.black.cgColor]))
        label.attributedText = att
    }
    
    private func setupManualLayout(){
        image.image = UIImage(named: "icon-option-manual")
        let att = NSMutableAttributedString()
        att.append(NSAttributedString(string: "Manual", attributes: [NSAttributedString.Key.font : UIFont(name: "Helvetica Neue Bold", size: 18) ?? UIFont.systemFont(ofSize: 18, weight: .bold) , NSAttributedString.Key.foregroundColor : UIColor.black.cgColor]))
        att.append(NSAttributedString(string: "\nInsira sua localização manualmente.", attributes:  [NSAttributedString.Key.font : UIFont(name: "Helvetica Neue Regular", size: 12)  ?? UIFont.systemFont(ofSize: 12, weight: .regular) , NSAttributedString.Key.foregroundColor : UIColor.black.cgColor]))
        label.attributedText = att
    }

}
