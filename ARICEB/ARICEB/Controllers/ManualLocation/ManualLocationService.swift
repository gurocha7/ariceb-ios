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
    
    func getBuildings(completion: @escaping ((ListBuildingsModel) -> Void), failure: Failure?) {
        AF.request("\(baseURL)v1/buildings", method: .get).responseJSON { (response) in
            print("###RESPONSE: ", response)
            guard let data = response.data else {return}
            do {
                let model = try JSONDecoder().decode(ListBuildingsModel.self, from: data)
                completion(model)
            }catch {
                failure?("Ocorreu um erro inesperado, tente novamente mais tarde.")
            }
        }
    }
    
    func getSectors(buildingId: Int,completion: @escaping ((ListSectorsModel) -> Void), failure: Failure?) {
        AF.request("\(baseURL)v1/sectors/\(buildingId)", method: .get).responseJSON { (response) in
            print("###RESPONSE: ", response)
            guard let data = response.data else {return}
            do {
                let model = try JSONDecoder().decode(ListSectorsModel.self, from: data)
                completion(model)
            }catch {
                failure?("Ocorreu um erro inesperado, tente novamente mais tarde.")
            }
        }
    }
    
    func getSubsectors(sectorId: Int,completion: @escaping ((ListSubsectorsModel) -> Void), failure: Failure?) {
        AF.request("\(baseURL)v1/subsectors/\(sectorId)", method: .get).responseJSON { (response) in
            print("###RESPONSE: ", response)
            guard let data = response.data else {return}
            do {
                let model = try JSONDecoder().decode(ListSubsectorsModel.self, from: data)
                completion(model)
            }catch {
                failure?("Ocorreu um erro inesperado, tente novamente mais tarde.")
            }
        }
    }
}
