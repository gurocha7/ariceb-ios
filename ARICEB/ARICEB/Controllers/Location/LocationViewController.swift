//
//  LocationViewController.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 16/04/21.
//

import UIKit

class LocationViewController: BaseViewController {
    
    var didTapConfirmAddres: ((String?) -> Void)?
    
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
        vc.didTapConfirmAddres = { [weak self] (model) in
            self?.didTapConfirmAddres?(model)
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
