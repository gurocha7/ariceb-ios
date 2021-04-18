//
//  SubmenuViewModel.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 18/04/21.
//

import Foundation

class SubmenuViewModel {
    
    private let itemsClasses: [String] = ["DEACL - Departamento de analises clinicas",
                                          "DEALI - Departamento de Alimentos",
                                          "DEAMB - Departamento de Engenharia Ambiental",
                                          "DEART - Departamento de Artes",
                                          "DEBIO - Departamento de Biodiversidade, Evolução e Meio Ambiente",
                                          "DECAD - Departamento de Ciencias Administrativas",
                                          "DECOM - Departamento de Computação",
                                          "DEDIR - Departamento de Direito",
                                          "DEEST - Departamento de Estatística"]
    
    private let itemsBuildinga: [String] = [ "Bloco de Sala de Aulas",
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
