//
//  ManualLocationViewController.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 17/04/21.
//

import UIKit

class ManualLocationViewController: BaseViewController {
    
    var isOrigin: Bool = false
    
    let customView: ManualLocationView = ManualLocationView.loadFromNib()
    
    init(isOrigin: Bool = true) {
        super.init(nibName: nil, bundle: nil)
        self.isOrigin = isOrigin
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func loadView() {
        super.loadView()
        title = isOrigin ? "Origem" : "Destino"
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
