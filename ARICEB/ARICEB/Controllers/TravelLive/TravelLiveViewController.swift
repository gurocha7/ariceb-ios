//
//  TravelLiveViewController.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 28/06/21.
//

import UIKit

class TravelLiveViewController: BaseViewController {
    
    //MARK: - Properties
    let customView: TravelLiveView = TravelLiveView.loadFromNib()
    private var viewModel: TravelLiveViewModel = TravelLiveViewModel()

    //MARK: - Overrides
    override func loadView() {
        super.loadView()
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.viewModel = viewModel
        bindEvents()
        getMockLocation()
    }

    private func bindEvents() {
        viewModel.didShowRoutes = { [weak self] (routes) in
            print("rotas encontradas: ", routes)
        }
    }
    
    private func getMockLocation() {
        viewModel.getRoute(originLat: -20.398255, originLong: -43.506740, destinyLat: -20.395751, destinyLong: -43.509350)
    }
}
