//
//  SelectOriginDestinyService.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 21/07/21.
//

import Foundation
import Alamofire

class SelectOriginDestinyService {
    
    func getRoute(completion: @escaping ((String) -> Void), failure: Failure?) {
        AF.request("http://127.0.0.1:3000/v1/route", method: .get).responseJSON { (response) in
            print("###RESPONSE: ", response)
            guard let data = response.data else {return}
            do {
//                let model = try JSONDecoder().decode(ListSubsectorsModel.self, from: data)
                completion("")
            }catch {
                failure?("Ocorreu um erro inesperado, tente novamente mais tarde.")
            }
        }
    }
    
}
