//
//  ManualLocationViewModel.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 17/04/21.
//

import Foundation

class ManualLocationViewModel{
    
    private var service: ManualLocationService = ManualLocationService()
    
    private var buildings: [BuildingsModel] = []
    private var sectors: [SectorModel] = []
    private var subsectors: [SubsectorModel] = []
    
    var listBuildings: ((ListBuildingsModel) -> Void)?
    var listSectors: ((ListSectorsModel) -> Void)?
    var listSubsectors: ((ListSubsectorsModel) -> Void)?
    
    var shouldShowError: ((String) -> Void)?
    
    let placeholderFirstAddres = "Prédio"
    let placeholderSecondAddres = "Departamento/Andar/Corredor"
    let placeholderThirdAddres = "Sala/Laboratório/Auditório"
    
    var fullAddres: String?
    
    var firstAddress: String?
    var secondAddress: String?
    var thirdAddress: String?
    
    
//    var itemsBuildings = ["Bloco de Sala de Aulas",
//                          "Centro Desportivo",
//                          "DEGEO - Departamento de Geologia",
//                          "DEMIN - Departamento de Engenharia de Minas",
//                          "EFAR - Escola de Farmácia",
//                          "EM - Escola de Minas",
//                          "ICEB - Instituto de Ciências Exatas e Biológicas",
//                          "RU - Restaurante Universitário"]
//
    var itemsSectors = ["Andar 1",
                         "Andar 2",
                         "Corredor 3",
                         "Corredor 4",
                         "Subsolo"]

    var itemsSubsectors = ["Auditório 1",
                         "Auditório 2",
                         "Empresa Júnior",
                         "Laboratório X",
                         "Portaria",
                         "Sala 20",
                         "Secretaria"]
    
    func insertFirstAddress(name: String){
        firstAddress = name
        secondAddress = nil
        thirdAddress = nil
    }
    
    func insertSecondAddress(name: String){
        secondAddress = name
        thirdAddress = nil
    }
    
    func insertThirdAddress(name: String){
        thirdAddress = name
    }
    
    func getFirstAddress() -> String?{
        return firstAddress
    }
    
    func getSecondAddress() -> String?{
        return secondAddress
    }
    
    func getThirdAddress() -> String?{
        return thirdAddress
    }
    
    func getFirstPlaceholder() -> String{
        return placeholderFirstAddres
    }
    
    func getSecondPlaceholder() -> String{
        return placeholderSecondAddres
    }

    func getThirdPlaceholder() -> String{
        return placeholderThirdAddres
    }
    
    func getModelForFirst() -> [BuildingsModel] {
        return buildings
    }
    
    func getModelForSecond() -> [SectorModel]{
        return sectors
    }
    
    func getModelForThird() -> [SubsectorModel]{
        return subsectors
    }
    
    func getModel() -> String?{
        var _fullAddress = ""
        if let _first = firstAddress {
            _fullAddress += _first
        }
        if let _second = secondAddress {
            _fullAddress += " - " + _second
        }
        if let _third = thirdAddress {
            _fullAddress += ", " + _third
        }
        fullAddres = _fullAddress
        return _fullAddress
    }
    
    func getBuildings() {
        service.getBuildings { (response) in
            self.buildings = response.buildings ?? []
            self.listBuildings?(response)
        } failure: { (errorMSG) in
            self.shouldShowError?(errorMSG)
        }
    }
    
    func getSector(buildingID: Int) {
        service.getSectors(buildingId: buildingID) { (response) in
            self.sectors = response.sectors ?? []
            self.listSectors?(response)
        } failure: { (errorMSG) in
            self.shouldShowError?(errorMSG)
        }
    }
    
    func getSubsector(sectorID: Int) {
        service.getSubsectors(sectorId: sectorID) { (response) in
            self.subsectors = response.subsectors ?? []
            self.listSubsectors?(response)
        } failure: { (errorMSG) in
            self.shouldShowError?(errorMSG)
        }
    }
}
