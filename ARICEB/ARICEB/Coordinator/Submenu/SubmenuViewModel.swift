//
//  SubmenuViewModel.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 18/04/21.
//

import Foundation

class SubmenuViewModel {
    
    private let itemsClasses: [String] = []
    private let itemsBuildinga: [String] = []
    private let itemsBathrooms: [String] = []
    private let itemsDepartment: [String] = []
    private let itemsAuditoriums: [String] = []
    private let itemsLaboratories: [String] = []
    
    private let classesDescription: String = "Selecione o departamento que sua aula pertence:"
    private let buildingsDescription: String = "Selecione o prédio que deseja encontrar:"
    private let bathroomsDescription: String = "Selecione o banheiro que deseja encontrar:"
    private let departmentDescription: String = "Selecione o departamento que deseja encontrar:"
    private let auditoriumDescription: String = "Selecione o auditório que deseja encontrar:"
    private let laboratoriesDescription: String = "Selecione o laboratório que deseja encontrar:"
    
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
}
