//
//  QRCodeScannerService.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 30/07/21.
//

import Foundation
import Alamofire

class QRCodeScannerService {
    
    func getStepsForInternalRoute(qrCode: String = "", destinationTag: String = "", completion: @escaping ((String) -> Void), failure: Failure?) {
        let url = "\(baseURL)/internalroute"
        let params: [String:Any] = ["qrcodeTag":qrCode,"destinationTag":destinationTag]
        debugPrint("==> URL:", url)
        debugPrint("==> PARAMS:", params)
        AF.request(url, method: .get, parameters: params).responseJSON { (response) in
            print("###RESPONSE: ", response)
            guard let data = response.data else {return}
            do {
//                let model = try JSONDecoder().decode(ExternalRoute.self, from: data)
                completion("")
            }catch {
                failure?("Ocorreu um erro inesperado, tente novamente mais tarde.")
            }
        }
    }
    
}
