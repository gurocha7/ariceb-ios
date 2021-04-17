//
//  LocationViewController.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 16/04/21.
//

import UIKit

class LocationViewController: BaseViewController {
    
    let customView: LocationView = LocationView.loadFromNib()
    
    override func loadView() {
        super.loadView()
        title = "Origem"
        view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
