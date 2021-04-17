//
//  MenuViewController.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 17/04/21.
//

import UIKit

class MenuViewController: UIViewController {
    
    let customView: MenuView = MenuView.loadFromNib()
    
    override func loadView() {
        super.loadView()
        view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
