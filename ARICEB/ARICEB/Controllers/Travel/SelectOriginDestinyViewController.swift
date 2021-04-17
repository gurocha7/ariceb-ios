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
        
    }

}
