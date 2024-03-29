//
//  SubmenuViewModel.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 18/04/21.
//

import Foundation

class SubmenuViewModel {
    
    enum SubmenuTypeController: String{
        case classes = "aulas"
        case buldings = "prédios"
        case bathroom = "banheiros"
        case department = "departamentos"
        case auditoriums = "auditórios"
        case laboratories = "laboratórios"
    }
    
    var typeModel: SubmenuTypeController = .classes
    
    private let itemsClasses: [String] = ["DEACL - Departamento de analises clinicas",
                                          "DEALI - Departamento de Alimentos",
                                          "DEAMB - Departamento de Engenharia Ambiental",
                                          "DEART - Departamento de Artes",
                                          "DEBIO - Departamento de Biodiversidade, Evolução e Meio Ambiente",
                                          "DECAD - Departamento de Ciencias Administrativas",
                                          "DECOM - Departamento de Computação",
                                          "DEDIR - Departamento de Direito",
                                          "DEEST - Departamento de Estatística"]
    
    private let itemsBuildings: [String] = [ "Bloco de Sala de Aulas",
                                               "Centro Desportivo",
                                               "Escola de Farmácia",
                                               "Escola de Medicina",
                                               "Escola de Minas",
                                               "Instituto de Ciências Exatas e Biológicas",
                                               "Restaurante Universitário"]
    
    private let itemsBathrooms: [String] = [
                                            "Banheiro Feminino, 1º Andar - Escola de Minas",
                                            "Banheiro Feminino, 1º Andar - Escola de Farmácia",
                                            "Banheiro Feminino, ICEB I - Instituto de Ciências Exatas e Biológicas",
                                            "Banheiro Feminino, 2º Andar - Escola de Minas",
                                            "Banheiro Masculino, 1º Andar - Escola de Minas",
                                            "Banheiro Masculino, 2º Andar - Escola de Minas",
                                            "Banheiro Masculino, 1º Andar - Escola de Farmácia",
                                            "Banheiro Masculino, ICEB I - Instituto de Ciências Exatas e Biológicas"
                                            ]
    
    private let itemsDepartment: [String] = ["DEACL - Departamento de analises clinicas",
                                                "DEALI - Departamento de Alimentos",
                                                "DEAMB - Departamento de Engenharia Ambiental",
                                                "DEART - Departamento de Artes",
                                                "DEBIO - Departamento de Biodiversidade, Evolução e Meio Ambiente",
                                                "DECAD - Departamento de Ciencias Administrativas",
                                                "DECOM - Departamento de Computação",
                                                "DEDIR - Departamento de Direito",
                                                "DEEST - Departamento de Estatística"]
    
    private let itemsAuditoriums: [String] = [ "Auditório 1 - Bloco de Sala de Aulas",
                                                  "Auditório 1 - Escola de Farmácia",
                                                  "Auditório 1 -  Escola de Medicina",
                                                  "Auditório 1 -  Escola de Minas",
                                                  "Auditório 1 -  Instituto de Ciências Exatas e Biológicas",
                                                  "Auditório 1 -  Departamento de Geologia"]
    
    private let itemsLaboratories: [String] = ["GAID",
                                                  "GOAL",
                                                  "HPC",
                                                  "iMobilis",
                                                  "Lasca",
                                                  "TerraLab",
                                                  "XR4GOOD"]
    
    private let classesDescription: String = "Selecione o departamento que sua aula pertence:"
    private let buildingsDescription: String = "Selecione o prédio que deseja encontrar:"
    private let bathroomsDescription: String = "Selecione o banheiro que deseja encontrar:"
    private let departmentDescription: String = "Selecione o departamento que deseja encontrar:"
    private let auditoriumDescription: String = "Selecione o auditório que deseja encontrar:"
    private let laboratoriesDescription: String = "Selecione o laboratório que deseja encontrar:"
    
    func setupModel(type: SubmenuTypeController){
        typeModel = type
    }
    
    func getClassesDescription() -> String{
        return classesDescription
    }
    
    func getBuildingsDescription() -> String{
        return buildingsDescription
    }
    
    func getBathroomsDescription() -> String{
        return bathroomsDescription
    }
    
    func getDepartmentDescription() -> String{
        return departmentDescription
    }
    
    func getAuditoriumDescription() -> String{
        return auditoriumDescription
    }
    
    func getLaboratoriesDescription() -> String{
        return laboratoriesDescription
    }
    
    func getNumberOfClasses() -> Int{
        return itemsClasses.count
    }
    
    func getNumberOfBuildings() -> Int{
        return itemsBuildings.count
    }
    
    func getNumberOfBathrooms() -> Int{
        return itemsBathrooms.count
    }
    
    func getNumberOfDepartment() -> Int{
        return itemsDepartment.count
    }
    
    func getNumberOfAuditoriums() -> Int{
        return itemsAuditoriums.count
    }
    
    func getNumberOfLaboratories() -> Int{
        return itemsLaboratories.count
    }
    
    func getNumberOfModels() -> Int{
        switch typeModel {
        case .classes:
            return getNumberOfClasses()
        case .buldings:
            return getNumberOfBuildings()
        case .bathroom:
            return getNumberOfBathrooms()
        case .department:
            return getNumberOfDepartment()
        case .auditoriums:
            return getNumberOfAuditoriums()
        case .laboratories:
            return getNumberOfLaboratories()
        }
    }
    
    func getItemAtIndex(index: Int) -> String{
        switch typeModel {
        case .classes:
            return itemsClasses[index]
        case .buldings:
            return itemsBuildings[index]
        case .bathroom:
            return itemsBathrooms[index]
        case .department:
            return itemsDepartment[index]
        case .auditoriums:
            return itemsAuditoriums[index]
        case .laboratories:
            return itemsLaboratories[index]
        }
    }
}
