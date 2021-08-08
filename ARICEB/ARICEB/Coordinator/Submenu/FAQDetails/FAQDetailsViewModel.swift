//
//  FAQDetailsViewModel.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 08/08/21.
//

import Foundation

class FAQDetailsViewModel {
    
    let titles: [String] = ["COMO USAR O APP?","COMO INSERIR MINHA ORIGEM?","COMO INSERIR MEU DESTINO?"]
    let description: [String] = ["","",""]
    let descriptionNameImage: [String] = ["","",""]
    
    
    func getTitleFor(_ index: Int) -> String {
        return titles[index]
    }
    
    func getDescriptionFor(_ index: Int) -> String {
        return description[index]
    }
    
    func getDescriptionNameImageFor(_ index: Int) -> String {
        return descriptionNameImage[index]
    }
}
