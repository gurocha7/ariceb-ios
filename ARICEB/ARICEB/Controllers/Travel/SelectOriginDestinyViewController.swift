//
//  SelectOriginDestinyViewController.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 16/04/21.
//

import UIKit

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
            
        }
        
        viewModel.updateOriginLayout = { [weak self] in
            self?.customView.updateOriginLayout()
        }
    }
    
    private func editOrigin(){
        let vc = ManualLocationViewController(isOrigin: true)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func showLocation(){
        let vc = LocationViewController()
        vc.didTapConfirmAddres = { [weak self] (model) in
            guard self != nil else {return}
            self?.viewModel.insertModelOrigin(model: model)
            self?.navigationController?.popToViewController(self!, animated: true)
        }
        navigationController?.pushViewController(vc, animated: true)
    }

}
