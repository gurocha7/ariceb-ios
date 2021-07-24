//
//  SelectOriginDestinyService.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 21/07/21.
//

import Foundation
import Alamofire

class SelectOriginDestinyService {
    
    func getRoute(params: [String:Any] = [:],completion: @escaping ((String) -> Void), failure: Failure?) {
        AF.request("http://\(generalIP):3000/v1/route", method: .get,parameters: params).responseJSON { (response) in
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
