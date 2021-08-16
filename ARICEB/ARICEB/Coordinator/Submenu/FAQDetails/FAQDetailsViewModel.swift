//
//  FAQDetailsViewModel.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 08/08/21.
//

import Foundation

class FAQDetailsViewModel {
    
    let titles: [String] = ["COMO USAR O APP?","COMO INSERIR MINHA ORIGEM?","COMO INSERIR MEU DESTINO?"]
    let description: [String] = ["Você pode usar pode utiizar o app para selecionar um ponto de origem e destino e o app irá projetar o caminho com utilização da Realidade Aumentada e irá te ajudar a encontrar seu destino final com mais facilidade :)",
        "Selecione uma das 3 opções existentes para selecionar a sua origem atual. Você pode escolher o modo GPS caso esteja em locais abertos, QrCode para escaneare identificar rapidamente o local ou existe a opção de selecionar manualmente seu local de origem.",""]
    let descriptionNameImage: [String] = ["print-1","print-2","print-3"]
    let imageHeight = [130,400,400]
    
    func getTitleFor(_ index: Int) -> String {
        return titles[index]
    }
    
    func getDescriptionFor(_ index: Int) -> String {
        return description[index]
    }
    
    func getDescriptionNameImageFor(_ index: Int) -> String {
        return descriptionNameImage[index]
    }
    
    func getImageHeight(index: Int) -> Int {
        return imageHeight[index]
    }
}
