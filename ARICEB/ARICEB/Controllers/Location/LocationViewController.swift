//
//  LocationViewController.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 16/04/21.
//

import UIKit

class LocationViewController: BaseViewController {
    
    var didTapConfirmAddres: ((String?,Int?,Int?,Int?) -> Void)?
    
    let customView: LocationView = LocationView.loadFromNib()
    
    override func loadView() {
        super.loadView()
        title = "Origem"
        view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bindEvents()
    }
    
    private func bindEvents(){
        customView.didTapGPSOption = {
            
        }
        
        customView.didTapQRCodeOption = {
            
        }
        
        customView.didTapManualOption = {[weak self] in
            self?.goToManual()
        }
    }
    
    private func goToManual(){
        let vc = ManualLocationViewController()
        vc.didTapConfirmAddres = { [weak self] (model,buildingID,sectorID,subsectorID) in
            self?.didTapConfirmAddres?(model,buildingID,sectorID,subsectorID)
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
