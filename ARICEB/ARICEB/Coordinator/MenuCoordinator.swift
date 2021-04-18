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
        self.homeNavController.pushViewController(vc, animated: false)
    }
    
    private func chekController(option: String){
        switch option.lowercased() {
        case MenuTypeController.classes.rawValue:
            print("clicou em aulas")
        case MenuTypeController.buldings.rawValue:
            print("clicou em prédios")
            showSubmenu(option: option)
        case MenuTypeController.bathroom.rawValue:
            print("clicou em ",MenuTypeController.bathroom.rawValue)
            showSubmenu(option: option)
        case MenuTypeController.department.rawValue:
            print("clicou em",MenuTypeController.department.rawValue)
            showSubmenu(option: option)
        case MenuTypeController.auditoriums.rawValue:
            print("clicou em ", MenuTypeController.auditoriums.rawValue)
            showSubmenu(option: option)
        case MenuTypeController.laboratories.rawValue:
            print("clicou em ",MenuTypeController.laboratories.rawValue)
            showSubmenu(option: option)
        case MenuTypeController.ru.rawValue:
            print("clicou em ",MenuTypeController.ru.rawValue)
        case MenuTypeController.faq.rawValue:
            print("clicou em ",MenuTypeController.faq.rawValue)
            showFAQ()
        default:
            break
        }
    }
    
    private func showSubmenu(option: String){
        let vc = SubmenuViewController()
        self.homeNavController.pushViewController(vc, animated: true)
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
