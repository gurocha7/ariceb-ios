//
//  SelectOriginDestinyViewController.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 16/04/21.
//

import UIKit

class SelectOriginDestinyViewController: BaseViewController {
    
    let customView: SelectOriginDestinyView = SelectOriginDestinyView.loadFromNib()
    
    override func loadView() {
        super.loadView()
        title = "Caminho"
        view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bindEvents()
    }
    
    private func bindEvents(){
        customView.shouldSelectOrigin = { [weak self] in
            self?.showLocation()
        }
        
        customView.shouldSelectDestiny = { [weak self] in
            
        }
    }
    
    private func showLocation(){
        let vc = LocationViewController()
        vc.didTapConfirmAddres = { [weak self] (model) in
            guard self != nil else {return}
            self?.navigationController?.popToViewController(self!, animated: true)
        }
        navigationController?.pushViewController(vc, animated: true)
    }

}
