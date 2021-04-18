//
//  ManualLocationViewController.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 17/04/21.
//

import UIKit

class ManualLocationViewController: UIViewController {
    
    var isOrigin: Bool = false
    
    init(isOrigin: Bool = true) {
        super.init(nibName: nil, bundle: nil)
        self.isOrigin = isOrigin
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = isOrigin ? "Origem" : "Destino"
        view.backgroundColor = .red
    }

}
