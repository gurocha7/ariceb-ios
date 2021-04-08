//
//  MenuCoordinator.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 07/04/21.
//



import UIKit

class MenuCoordinator: NSObject {
    var childCoordnators =  [Coordinator]()
    
    let vc = MainViewController(nibName: "MainViewController", bundle: nil)
    let sideMenu = UIViewController()
    
    lazy var rootVC: SideMenuRootVC = {
        let rootMenuVC = SideMenuRootVC()
//        rootMenuVC.delegate = self
        sideMenu.view.backgroundColor = .red
        rootMenuVC.embed(centerViewController: UINavigationController(rootViewController: vc))
        rootMenuVC.embed(sideViewController: sideMenu)
        return rootMenuVC
    }()
    
}
