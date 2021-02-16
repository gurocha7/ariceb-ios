//
//  Coordinator.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 14/02/21.
//

import Foundation
import UIKit

protocol Coordinator {
    var childCoordnators: [Coordinator] { get set}
    var navigationController: UINavigationController { get set }
    
    func start()
}
