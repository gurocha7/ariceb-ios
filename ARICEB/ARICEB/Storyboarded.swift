//
//  Storyboarded.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 14/02/21.
//

import Foundation
import UIKit

protocol Storyboarded {
    static func instantiate() -> Self
}

//extension Storyboarded where Self: UIViewController {
//    static func instantiate() -> Self {
//        let id = String(describing: self)
//        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
//        if #available(iOS 13.0, *) {
//            return storyboard.instantiateViewController(identifier: id) as! Self
//        } else {
//
//        }
//    }
//}
