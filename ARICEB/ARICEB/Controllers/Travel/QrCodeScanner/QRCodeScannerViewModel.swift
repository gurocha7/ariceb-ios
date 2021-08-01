//
//  QRCodeScannerViewModel.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 30/07/21.
//
import Foundation

class QRCodeScannerViewModel {
    
    private var service: QRCodeScannerService
    private var destinationTag: String = ""
    
    var showSteps: ((NextStepsModel) -> Void)?
    var shouldShowError: ((String) -> Void)?
    
    init(service: QRCodeScannerService = QRCodeScannerService()) {
        self.service = service
    }
    
    func insertDestinationTag(tag: String?) {
        guard let tagValue = tag else {return}
        destinationTag = tagValue
    }
    
    func getSteps(qrCode: String = "") {
        service.getStepsForInternalRoute(qrCode: qrCode, destinationTag: destinationTag) {[weak self] (response) in
            self?.showSteps?(response)
        } failure: {[weak self] (errorMSG) in
            self?.shouldShowError?(errorMSG)
        }
    }
}
