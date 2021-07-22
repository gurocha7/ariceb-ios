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
    
    private var originBuildingID: Int?
    private var originSectorID: Int?
    private var originSubsectorID: Int?
    
    private var destinyBuildingID: Int?
    private var destinySectorID: Int?
    private var destinySubsectorID: Int?
    
    func insertModelOrigin(model: String?){
        modelOrigin = model
        updateOriginLayout?()
    }
    
    func insertModelDestiny(model: String?){
        modelDestiny = model
        updateDestinyLayout?()
    }
    
    func insertOriginIds(_ buildingID: Int? = nil,sectorID: Int? = nil,subsectorID: Int? = nil) {
        guard let buildingIDValue = buildingID else {return}
        originBuildingID = buildingIDValue
        guard let sectorIDValue = sectorID else {return}
        originSectorID = sectorIDValue
        guard let subsectorIDValue = subsectorID else {return}
        originSubsectorID = subsectorIDValue
    }
    
    func insertDestinyIds(_ buildingID: Int? = nil,sectorID: Int? = nil,subsectorID: Int? = nil) {
        guard let buildingIDValue = buildingID else {return}
        destinyBuildingID = buildingIDValue
        guard let sectorIDValue = sectorID else {return}
        destinySectorID = sectorIDValue
        guard let subsectorIDValue = subsectorID else {return}
        destinySubsectorID = subsectorIDValue
    }
    
    func getModelOriginDescription() -> String?{
        guard let _text = modelOrigin else {return nil}
        return _text
    }
    
    func getModelDestinyDescription() -> String?{
        guard let _text = modelDestiny else {return nil}
        return _text
    }
    
    func getModelOrigin() -> String?{
        guard let _text = modelOrigin else {return nil}
        let final = String(_text.split(separator: ",").last ?? "")
        return final
    }
    
    func getModelDestiny() -> String?{
        guard let _text = modelDestiny else {return nil}
        let final = String(_text.split(separator: ",").last ?? "")
        return final
    }
    
}
