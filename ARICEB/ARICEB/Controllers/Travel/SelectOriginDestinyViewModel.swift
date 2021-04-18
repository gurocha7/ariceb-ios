//
//  SelectOriginDestinyViewModel.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 18/04/21.
//

import Foundation

class SelectOriginDestinyViewModel {
    
    var modelOrigin: String?
    var modelDestiny: String?
    
    var updateOriginLayout: (() -> Void)?
    var updateDestinyLayout: (() -> Void)?
    
    func insertModelOrigin(model: String?){
        modelOrigin = model
        updateOriginLayout?()
    }
    
    func insertModelDestiny(model: String?){
        modelDestiny = model
        updateDestinyLayout?()
    }
    
    func getModelOrigin() -> String?{
        guard let _text = modelOrigin else {return nil}
        let final = String(_text.split(separator: ",").last ?? "")
        return final
    }
    
}
