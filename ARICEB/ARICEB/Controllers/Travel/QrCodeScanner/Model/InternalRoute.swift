//
//  InternalRoute.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 31/07/21.
//

import Foundation

struct InternalRoute: Codable {
    let destinationTag: String?
    let qrcodeTag: String?
}

extension Encodable {
    var convertToString: String? {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .prettyPrinted
        do {
            let jsonData = try jsonEncoder.encode(self)
            return String(data: jsonData, encoding: .utf8)
        } catch {
            return nil
        }
    }
}
