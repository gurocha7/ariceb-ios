//
//  MenuViewController.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 17/04/21.
//

import UIKit

class MenuViewController: UIViewController {
    
    let customView: MenuView = MenuView.loadFromNib()
    let viewModel: MenuViewModel = MenuViewModel()
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .clear
        view = customView
        customView.viewModel = self.viewModel
        customView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bindEvents()
        
    }
    
    private func bindEvents(){
        
    }

}
