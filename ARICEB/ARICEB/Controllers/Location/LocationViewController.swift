//
//  LocationViewController.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 16/04/21.
//

import UIKit

class LocationViewController: BaseViewController {
    
    var isOrigin: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
        title = isOrigin ? "Origem" : "Destino"
    }
    
    init(isOrigin: Bool = true) {
        super.init(nibName: nil, bundle: nil)
        self.isOrigin = isOrigin
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
