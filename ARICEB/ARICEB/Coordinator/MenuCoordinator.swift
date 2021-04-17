//
//  MenuCoordinator.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 07/04/21.
//



import UIKit

class MenuCoordinator: NSObject {
   
    var childCoordnators:  [Coordinator] = []
    let vc = MainViewController(nibName: "MainViewController", bundle: nil)
    let sideMenu = MenuViewController()
    
    private lazy var homeNavController: UINavigationController = {
        return UINavigationController(rootViewController: self.vc)
    }()
    
    lazy var rootVC: SideMenuRootVC = {
        let rootMenuVC = SideMenuRootVC()
        rootMenuVC.delegate = self
        rootMenuVC.embed(centerViewController: homeNavController)
        rootMenuVC.embed(sideViewController: sideMenu)
        return rootMenuVC
    }()
    
    public override init(){
        super.init()
        setup()
        bindEvents()
    }
    
    private func bindEvents(){
        vc.selectOriginAndDestiny = { [weak self] in
            self?.showSelectTravel()
        }
        
        sideMenu.hideMenu = { [weak self] in
            self?.rootVC.hideMenu()
            self?.showFAQ()
        }
    }
    
    private func setup(){
        
    }
    
    func showSelectTravel(){
        let vc = SelectOriginDestinyViewController()
        self.homeNavController.pushViewController(vc, animated: false)
    }
    
    private func showFAQ(){
        let vc = UIViewController()
        vc.view.backgroundColor = .orange
        self.homeNavController.pushViewController(vc, animated: true)
    }
}

extension MenuCoordinator: SideMenuControllerDelegate{
    func sideMenuControllerDidHide(_ sideMenuController: SideMenuController) {
        print("HIDE")
    }
    
    func sideMenuControllerDidReveal(_ sideMenuController: SideMenuController) {
        print("REVEAL")
    }
}
