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
    
    @IBOutlet weak var stackView: UIStackView!
    
    
    let travelView: TravelView = TravelView.loadFromNib()
    let bannerView: BannerView = BannerView.loadFromNib()
    
    //MARK: - Overrides

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    //MARK: - Methods
    
    private func setup(){
        title = "ARICEB"
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1215686275, green: 0.7254901961, blue: 0.4235294118, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        view.backgroundColor = .white
        setupStack()
        configMneu()
    }
    
    private func setupStack(){
        setupTravelView()
        setupBannerView()
    }
    
    private func setupTravelView(){
        travelView.translatesAutoresizingMaskIntoConstraints = false
        travelView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        stackView.addArrangedSubview(travelView)
    }
    
    private func setupBannerView(){
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        bannerView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        stackView.addArrangedSubview(bannerView)
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
