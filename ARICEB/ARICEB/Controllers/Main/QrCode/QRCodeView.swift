//
//  QRCodeView.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 02/04/21.
//

import UIKit
import Reusable

class QRCodeView: UIView, NibLoadable{
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var imageQRCode: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLayout()
    }
    
    private func setupLayout(){
        contentView.backgroundColor = #colorLiteral(red: 0.01176470588, green: 0.662745098, blue: 0.9568627451, alpha: 1)
        contentView.applyCorner(corner: 15)
        contentView.applyBorder(borderWidth: 0.5, borderColor: UIColor.gray.cgColor)
        imageQRCode.image = UIImage(named: "icon-qrcode")?.withRenderingMode(.alwaysOriginal)
        labelTitle.text = "QRCODE\nEntenda como funciona a localização via QrCode."
    }
    
}
