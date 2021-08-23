//
//  QRCodeLocationService.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 22/08/21.
//

import Alamofire
import Foundation

class QRCodeLocationService {
    
    func getQrCodeDetails(qrCode: String = "",completion: @escaping ((NextStepsModel) -> Void), failure: Failure?) {
        let url = "\(baseURL)/qrcode"
        let params: [String:Any] = ["name":qrCode]
        debugPrint("==> URL:", url)
        debugPrint("==> PARAMS:", params)
        AF.request(url, method: .get, parameters: params).responseJSON { (response) in
            print("###RESPONSE: ", response)
            guard let data = response.data else {return}
            do {
                let model = try JSONDecoder().decode(NextStepsModel.self, from: data)
                completion(model)
            }catch {
                failure?("Ocorreu um erro inesperado, tente novamente mais tarde.")
            }
        }
    }
    
}
