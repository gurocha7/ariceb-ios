//
//  FAQDetailsViewModel.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 08/08/21.
//

import Foundation

class FAQDetailsViewModel {
    
    let titles: [String] = ["COMO USAR O APP?","COMO INSERIR MINHA ORIGEM?","COMO INSERIR MEU DESTINO?"]
    let description: [String] = ["Você pode usar pode utiizar o app para selecionar um ponto de origem e destino e o app iráprojetar o caminho com utilização da Realidade Aumentada e irá te ajudar a encontrar seu destino final com mais facilidade :)","",""]
    let descriptionNameImage: [String] = ["print-1","",""]
    
    
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
