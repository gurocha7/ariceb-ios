//
//  SideMenuRootVC.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 07/04/21.
//

import UIKit
import SideMenuController

public class SideMenuRootVC: SideMenuController{

    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        SideMenuController.preferences.drawing.menuButtonImage = UIImage(named: "icon-menu")
        SideMenuController.preferences.drawing.sidePanelPosition = .underCenterPanelLeft
        SideMenuController.preferences.drawing.sidePanelWidth = UIScreen.main.bounds.width / 1.5
        SideMenuController.preferences.drawing.centerPanelShadow = true
        SideMenuController.preferences.animating.statusBarBehaviour = .showUnderlay
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.view.backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
