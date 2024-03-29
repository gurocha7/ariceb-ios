//
//  MainCoordinator.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 14/02/21.
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordnators =  [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = MainViewController(nibName: "MainViewController", bundle: nil)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
//    func showSelectTravel(){
//        let vc = UIViewController()
//        vc.view.backgroundColor = .orange
//        navigationController.pushViewController(vc, animated: false)
//    }
    
}
