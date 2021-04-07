//
//  MainViewController.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 14/02/21.
//

import UIKit
import SideMenuSwift

class MainViewController: UIViewController {
    
    //MARK: - Properties
    
    var coordinator: MainCoordinator?
    
    @IBOutlet weak var stackView: UIStackView!
    
    let travelView: TravelView = TravelView.loadFromNib()
    let bannerView: BannerView = BannerView.loadFromNib()
    let qrCodeView: QRCodeView = QRCodeView.loadFromNib()
    let fastButtonsView: FastButtonsView = FastButtonsView.loadFromNib()
    
    //MARK: - Overrides

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    //MARK: - Methods
    
    private func setup(){
        title = "ARICEB"
        navigationController?.navigationBar.barTintColor = mainColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        view.backgroundColor = .white
        setupStack()
        configMneu()
        bindEvents()
    }
    
    private func bindEvents(){
        travelView.selectOriginAndDestiny = { [weak self] in
            self?.coordinator?.showSelectTravel()
        }
    }
    
    private func setupStack(){
        setupTravelView()
        setupBannerView()
        setupQrCodeView()
        setupFastButtonsView()
    }
    
    private func setupTravelView(){
        travelView.translatesAutoresizingMaskIntoConstraints = false
        travelView.heightAnchor.constraint(equalToConstant: 110).isActive = true
        stackView.addArrangedSubview(travelView)
    }
    
    private func setupBannerView(){
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        bannerView.heightAnchor.constraint(equalToConstant: 160).isActive = true
        stackView.addArrangedSubview(bannerView)
    }
    
    private func setupQrCodeView(){
        qrCodeView.translatesAutoresizingMaskIntoConstraints = false
        qrCodeView.heightAnchor.constraint(equalToConstant: 140).isActive = true
        stackView.addArrangedSubview(qrCodeView)
    }
    
    private func setupFastButtonsView(){
        fastButtonsView.translatesAutoresizingMaskIntoConstraints = false
        fastButtonsView.heightAnchor.constraint(equalToConstant: 140).isActive = true
        stackView.addArrangedSubview(fastButtonsView)
    }
    
    private func configMneu(){
        sideMenuController?.delegate = self
        sideMenuController?.revealMenu()
        SideMenuController.preferences.basic.menuWidth = 240
        SideMenuController.preferences.basic.statusBarBehavior = .hideOnMenu
        SideMenuController.preferences.basic.position = .above
        SideMenuController.preferences.basic.direction = .left
        SideMenuController.preferences.basic.enablePanGesture = true
        SideMenuController.preferences.basic.supportedOrientations = .portrait
        SideMenuController.preferences.basic.shouldRespectLanguageDirection = true
    }

}

extension MainViewController: SideMenuControllerDelegate{
    
}
