//
//  ManualLocationViewModel.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 17/04/21.
//

import Foundation

class ManualLocationViewModel{
    
    let placeholderFirstAddres = "Prédio"
    let placeholderSecondAddres = "Departamento/Andar/Corredor"
    let placeholderThirdAddres = "Sala/Laboratório/Auditório"
    
    var fullAddres = ""
    
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
                         "Secetrária"]
    
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
    
    func getModelForFirst() -> [String]{
        return itemsBuildings
    }
    
    func getModelForSecond() -> [String]{
        return itemsSectors
    }
    
    func getModelForThird() -> [String]{
        return itemsSubsectors
    }
}
