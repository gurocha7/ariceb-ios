//
//  ManualLocationService.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 19/07/21.
//

import Foundation
import Alamofire

typealias Failure = ((String) -> Void)

class ManualLocationService {
    
    func getBuildings(completion: @escaping ((String) -> Void), failure: Failure?) {
        AF.request("http://127.0.0.1:3000/v1/buildings", method: .get).responseJSON { (response) in
            print("###RESPONSE: ", response)
            guard let data = response.data else {return}
            do {
                completion("Rolou")
            }catch {
                failure?("Ocorreu um erro inesperado, tente novamente mais tarde.")
            }
        }
    }
    
}
