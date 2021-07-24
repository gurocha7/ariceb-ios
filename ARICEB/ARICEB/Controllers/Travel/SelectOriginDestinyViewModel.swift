//
//  SelectOriginDestinyViewModel.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 18/04/21.
//

import Foundation

class SelectOriginDestinyViewModel {
    
    private var service: SelectOriginDestinyService = SelectOriginDestinyService()
    
    var shouldShowErrorMSG: ((String) -> Void)?
    
    var modelOrigin: String?
    var modelDestiny: String?
    
    var updateOriginLayout: (() -> Void)?
    var updateDestinyLayout: (() -> Void)?
    
    var originIsExternal: Bool = false
    var destinyIsExternal: Bool = false
    
    private var originBuildingID: Int?
    private var originSectorID: Int?
    private var originSubsectorID: Int?
    
    private var destinyBuildingID: Int?
    private var destinySectorID: Int?
    private var destinySubsectorID: Int?
    
    var params: [String:Any] = [:]
    
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
        originIsExternal = true
        guard let sectorIDValue = sectorID else {return}
        originSectorID = sectorIDValue
        originIsExternal = false
        guard let subsectorIDValue = subsectorID else {return}
        originSubsectorID = subsectorIDValue
    }
    
    func insertDestinyIds(_ buildingID: Int? = nil,sectorID: Int? = nil,subsectorID: Int? = nil) {
        guard let buildingIDValue = buildingID else {return}
        destinyBuildingID = buildingIDValue
        destinyIsExternal = true
        guard let sectorIDValue = sectorID else {return}
        destinySectorID = sectorIDValue
        destinyIsExternal = false
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
    
    func getRoute() {
        if originIsExternal && destinyIsExternal {
            params["originID"] = originBuildingID
            params["destinyID"] = destinyBuildingID
            getExternalRoute()
        } else if !originIsExternal && !destinyIsExternal {
            //chamar rota interna
            print("chamar rota interna")
        } else if !originIsExternal && destinyIsExternal {
            //chamar rota de interno para externo
            print("chamar rota interno para externo")
        }else {
            //chamar rota de externo para interno
            print("chamar rota externo para interno")
        }
    }
    
    func getExternalRoute() {
        service.getRoute(params: params) { (response) in
            print("//: ", response)
        } failure: { (errorMSG) in
            self.shouldShowErrorMSG?(errorMSG)
        }
    }
}
