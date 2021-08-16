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
    
    func getTitleFor(_ index: Int) -> String {
        return titles[index]
    }
}
