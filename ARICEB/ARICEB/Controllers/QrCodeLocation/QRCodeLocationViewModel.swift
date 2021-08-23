//
//  QRCodeLocationViewModel.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 22/08/21.
//

import Foundation

class QRCodeLocationViewModel {
    
    private var service: QRCodeLocationService = QRCodeLocationService()
    
    var showQrcode: ((NextStepsModel) -> Void)?
    var shouldShowError: ((String) -> Void)?
    
    func getSteps(qrCode: String = "") {
        service.getQrCodeDetails(qrCode: qrCode) {[weak self] (response) in
            self?.showQrcode?(response)
        } failure: {[weak self] (errorMSG) in
            self?.shouldShowError?(errorMSG)
        }
    }
    
}
