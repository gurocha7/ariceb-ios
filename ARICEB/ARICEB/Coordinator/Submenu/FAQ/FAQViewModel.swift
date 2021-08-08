//
//  FAQViewModel.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 18/04/21.
//

import Foundation

class FAQViewModel{
    
    let itemsQuestions:[String] = ["COMO USAR O APP?","COMO INSERIR MINHA ORIGEM?","COMO INSERIR MEU DESTINO?"]
    let itemsAnswers:[String] = ["Lorem Ipsum dolor","Lorem Ipsum dolor","Lorem Ipsum dolor"]
    
    
    func getNumberOfQuestions() -> Int {
        return itemsQuestions.count
    }
    
    func getItemAtIndex(index: Int) -> String {
        return itemsQuestions[index]
    }
    
    func getItemAnswersAtIndex(index: Int) -> String {
        return itemsAnswers[index]
    }
}
