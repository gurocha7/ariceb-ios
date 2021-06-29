//
//  TravelLiveViewController.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 28/06/21.
//

import UIKit

class TravelLiveViewController: BaseViewController {
    
    let customView: TravelLiveView = TravelLiveView.loadFromNib()

    
    override func loadView() {
        super.loadView()
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
