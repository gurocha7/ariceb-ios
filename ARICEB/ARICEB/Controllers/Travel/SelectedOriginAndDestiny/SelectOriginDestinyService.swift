//
//  SelectOriginDestinyService.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 21/07/21.
//

import Foundation
import Alamofire

class SelectOriginDestinyService {
    
    func getRoute(params: [String:Any] = [:],completion: @escaping ((ExternalRoute) -> Void), failure: Failure?) {
        AF.request("\(baseURL)/route", method: .get, parameters: params).responseJSON { (response) in
            print("###RESPONSE: ", response)
            guard let data = response.data else {return}
            do {
                let model = try JSONDecoder().decode(ExternalRoute.self, from: data)
                completion(model)
            }catch {
                failure?("Ocorreu um erro inesperado, tente novamente mais tarde.")
            }
        }
    }
    
}
