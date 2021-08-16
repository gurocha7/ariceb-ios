//
//  SelectOriginDestinyViewController.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 16/04/21.
//

import UIKit
import Alamofire

class SelectOriginDestinyViewController: BaseViewController {
    
    let customView: SelectOriginDestinyView = SelectOriginDestinyView.loadFromNib()
    let viewModel:  SelectOriginDestinyViewModel = SelectOriginDestinyViewModel()
    
    private var destinationTag: String = ""
    private var model: NextStepsModel? = nil
    
    override func loadView() {
        super.loadView()
        title = "Caminho"
        view = customView
        customView.viewModel = self.viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bindEvents()
    }
    
    private func bindEvents(){
        customView.shouldSelectOrigin = { [weak self] in
            self?.showLocation()
        }
        
        customView.shouldEditOrigin = {[weak self] in
            self?.editOrigin()
        }
        
        customView.shouldSelectDestiny = { [weak self] in
            self?.editDestiny()
        }
        
        customView.shouldEditDestiny = { [weak self] in
            self?.editDestiny()
        }
        
        customView.shouldShowTravelLive = { [weak self] in
            self?.viewModel.getRoute()
        }
        
        viewModel.updateOriginLayout = { [weak self] in
            self?.customView.updateOriginLayout()
        }
        
        viewModel.updateDestinyLayout = { [weak self] in
            self?.customView.updateDestinyLayout()
        }
        
        viewModel.showExternalTravelLive = { [weak self] (externalRoute) in
            self?.showExternalTravelLive(route: externalRoute)
        }
        
        viewModel.showInternalTravelLive = { [weak self] (tag) in
            self?.destinationTag = tag
            self?.scannerQrCode()
        }
        
        viewModel.shouldShowErrorMSG = { [weak self] (errorMSSG) in
            DispatchQueue.main.async {
                self?.stopLoading()
                self?.showAlertWithMessage(message: errorMSSG)
            }
        }
    }
    
    private func showAlertWithMessage(message: String) {
        let alert = UIAlertController(title: "Atenção", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    private func editOrigin(){
        let vc = ManualLocationViewController(isOrigin: true)
        vc.didTapConfirmAddres = { [weak self] (model,buildingID,sectorID,subsectorID) in
            guard self != nil else {return}
            self?.viewModel.insertOriginIds(buildingID, sectorID: sectorID, subsectorID: subsectorID)
            self?.viewModel.insertModelOrigin(model: model)
            self?.navigationController?.popToViewController(self!, animated: true)
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func editDestiny(){
        let vc = ManualLocationViewController(isOrigin: false)
        vc.didTapConfirmAddres = { [weak self] (model,buildingID,sectorID,subsectorID) in
            guard self != nil else {return}
            self?.viewModel.insertDestinyIds(buildingID, sectorID: sectorID, subsectorID: subsectorID)
            self?.viewModel.insertModelDestiny(model: model)
            self?.navigationController?.popToViewController(self!, animated: true)
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func showLocation(){
        let vc = LocationViewController()
        vc.didTapConfirmAddres = { [weak self] (model,buildingID,sectorID,subsectorID) in
            guard self != nil else {return}
            self?.viewModel.insertOriginIds(buildingID, sectorID: sectorID, subsectorID: subsectorID)
            self?.viewModel.insertModelOrigin(model: model)
            self?.navigationController?.popToViewController(self!, animated: true)
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func showExternalTravelLive(route: ExternalRoute) {
        let controller = TravelLiveViewController()
        controller.setupExternalRoute(route: route)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    private func showInternalTravelLive(model: NextStepsModel?, isByIndex: Bool = false,index: Int? = nil) {
        let controller = TravelLiveViewController()
        controller.setupInternalRoute(model: model, destinationTitle: viewModel.getModelDestinyDescription() ?? "",index: index)
        controller.willScannerWithTag = { [weak self] (nextQrCodes) in
            DispatchQueue.main.async {
                self?.scannerQrCode(hasSteps: true,nextQrCodes: nextQrCodes)
            }
            self?.navigationController?.popViewController(animated: true)
        }
        controller.tapBackButton = { [weak self] in
            self?.stopLoading()
            self?.navigationController?.popViewController(animated: true)
            self?.navigationController?.popViewController(animated: true)
        }
        navigationController?.pushViewController(controller, animated: true)
    }
    
    private func scannerQrCode(hasSteps: Bool = false,nextQrCodes: [String]? = nil) {
        playLoading()
        let controller = ScannerViewController(existingSteps: hasSteps ? nextQrCodes : nil )
        let nav = UINavigationController(rootViewController: controller)
        controller.modalPresentationStyle = .overFullScreen
        controller.insertDestinationTag(destinationTag: destinationTag)
        controller.showRouteByQrCode = { [weak self] (model) in
            self?.model = model
            controller.dismiss(animated: true)
            DispatchQueue.main.async {
                self?.checkRotatePhone(model: model)
            }
        }
        controller.drawStepAtIndex = { [weak self] (index) in
            controller.dismiss(animated: true)
            DispatchQueue.main.async {
                self?.checkRotatePhone(model: self?.model, isByIndex: true, index: index)
            }
        }
        controller.tapCloseController = { [weak self] in
            controller.dismiss(animated: true)
            self?.stopLoading()
        }
        nav.modalPresentationStyle = .overFullScreen
        navigationController?.present(nav, animated: true, completion: nil)
    }
    
    private func checkRotatePhone(model: NextStepsModel?,isByIndex: Bool = false, index: Int? = nil) {
        var stepValue: StepsModel?
        if isByIndex {
            guard let indexValue = index else {return}
            guard let step = model?.steps?[indexValue] else {return}
            stepValue = step
        }else {
            guard let step = model?.steps?.first else {return}
            stepValue = step
        }
        let controller = RotateViewController()
        controller.modalPresentationStyle = .overFullScreen
        controller.setStepsAndParams(stepValue)
        controller.shouldShowStep = { [weak self] in
            controller.dismiss(animated: true, completion: nil)
            DispatchQueue.main.async {
                self?.showInternalTravelLive(model: model,isByIndex: isByIndex,index: index)
            }
        }
        controller.dismissRotate = { [weak self] in
            self?.stopLoading()
            controller.dismiss(animated: true, completion: nil)
        }
        self.present(controller, animated: true, completion: nil)
    }
    
}
