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
    
    var hideMenu: (() -> Void)?
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .clear
        view = customView
        customView.viewModel = self.viewModel
        customView.reloadData()
        customView.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bindEvents()
        
    }
    
    private func bindEvents(){
        
    }
    
    private func choiceController(item: String?){
        guard let _option = item else {return }
        hideMenu?()
    }
}

extension MenuViewController: MenuViewDelegate{
    func menuView(view: MenuView, option: String?) {
        choiceController(item: option)
    }
}
