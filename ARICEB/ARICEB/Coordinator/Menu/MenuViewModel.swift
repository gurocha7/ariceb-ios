//
//  MenuViewModel.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 17/04/21.
//

import Foundation

class MenuViewModel {
    
    var items: [String] = ["Aulas","Prédios","Banheiros","Departamentos","Auditórios","Laboratórios","RU","FAQ"]
    
    
    func getItemForIndex(index: Int) -> String{
        return items[index]
    }
    
    func getNumberOfItems() -> Int{
        return items.count
    }
    
}
