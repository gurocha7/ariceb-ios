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
        
        viewModel.showInternalTravelLive = { [weak self] in
            self?.showInternalTravelLive()
        }
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

    private func showInternalTravelLive() {
        let controller = TravelLiveViewController()
        controller.setupInternalRoute()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    private func checkRotatePhone() {
        let controller = RotatePhoneViewController()
        controller.modalPresentationStyle = .overFullScreen
        present(controller, animated: true, completion: nil)
    }
    
}
