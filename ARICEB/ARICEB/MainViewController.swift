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
    
    @IBOutlet weak var imageBanner: UIImageView!
    
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
        setupBanner()
        configMneu()
    }
    
    private func setupBanner(){
        imageBanner.backgroundColor = .orange
        imageBanner.applyBorder(corner: 18)
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
