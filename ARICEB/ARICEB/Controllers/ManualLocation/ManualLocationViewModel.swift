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
    var listBuildings: ((ListBuildingsModel) -> Void)?
    var listSectors: (() -> Void)?
    var listSubsectors: (() -> Void)?
    
    var shouldShowError: ((String) -> Void)?
    
    let placeholderFirstAddres = "Prédio"
    let placeholderSecondAddres = "Departamento/Andar/Corredor"
    let placeholderThirdAddres = "Sala/Laboratório/Auditório"
    
    var fullAddres: String?
    
    var firstAddress: String?
    var secondAddress: String?
    var thirdAddress: String?
    
    
    var itemsBuildings = ["Bloco de Sala de Aulas",
                          "Centro Desportivo",
                          "DEGEO - Departamento de Geologia",
                          "DEMIN - Departamento de Engenharia de Minas",
                          "EFAR - Escola de Farmácia",
                          "EM - Escola de Minas",
                          "ICEB - Instituto de Ciências Exatas e Biológicas",
                          "RU - Restaurante Universitário"]
    
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
    }
    
    func insertSecondAddress(name: String){
        secondAddress = name
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
    
    func getModelForSecond() -> [String]{
        return itemsSectors
    }
    
    func getModelForThird() -> [String]{
        return itemsSubsectors
    }
    
    func getModel() -> String?{
        guard let _first = firstAddress else { return "" }
        guard let _second = secondAddress else { return "" }
        guard let _third = thirdAddress else { return "" }
        let _fullAddress = _first + " - " + _second + ", " + _third
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
            
        } failure: { (errorMSG) in
            self.shouldShowError?(errorMSG)
        }
    }
}
