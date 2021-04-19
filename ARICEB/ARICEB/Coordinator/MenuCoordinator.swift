//
//  MenuCoordinator.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 07/04/21.
//



import UIKit

class MenuCoordinator: NSObject {
    
    enum MenuTypeController: String{
        case classes = "aulas"
        case buldings = "prédios"
        case bathroom = "banheiros"
        case department = "departamentos"
        case auditoriums = "auditórios"
        case laboratories = "laboratórios"
        case ru = "ru"
        case faq = "faq"
    }
   
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
        
        sideMenu.hideMenu = { [weak self] (option) in
            self?.rootVC.hideMenu()
            self?.chekController(option: option)
        }
    }
    
    private func setup(){
        
    }
    
    func showSelectTravel(){
        let vc = SelectOriginDestinyViewController()
        self.homeNavController.pushViewController(vc, animated: true)
    }
    
    private func chekController(option: String){
        switch option.lowercased() {
        case MenuTypeController.classes.rawValue:
            showSubmenu(option: option)
        case MenuTypeController.buldings.rawValue:
            showSubmenu(option: option)
        case MenuTypeController.bathroom.rawValue:
            showSubmenu(option: option)
        case MenuTypeController.department.rawValue:
            showSubmenu(option: option)
        case MenuTypeController.auditoriums.rawValue:
            showSubmenu(option: option)
        case MenuTypeController.laboratories.rawValue:
            showSubmenu(option: option)
        case MenuTypeController.ru.rawValue:
            break
        case MenuTypeController.faq.rawValue:
            showFAQ()
        default:
            break
        }
    }
    
    private func showSubmenu(option: String){
        let vc = SubmenuViewController(option: option)
        self.homeNavController.pushViewController(vc, animated: true)
    }
    
    private func showFAQ(){
        let vc = FAQViewController()
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
