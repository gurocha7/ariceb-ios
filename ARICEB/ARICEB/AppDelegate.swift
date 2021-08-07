//
//  AppDelegate.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 14/02/21.
//

import UIKit
import netfox

//let baseURL: String = "http://192.168.2.7:3000/v1"
let baseURL: String = "https://ariceb-prod.herokuapp.com/v1"


@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: MenuCoordinator?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        coordinator = MenuCoordinator()
        SideMenuRootVC.preferences.interaction.swipingEnabled = false
        SideMenuRootVC.preferences.interaction.panningEnabled = false
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = coordinator?.rootVC
        window?.makeKeyAndVisible()
        setupNFX()
        return true
    }
    
    private func setupNFX() {
        NFX.sharedInstance().start()
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }


}

