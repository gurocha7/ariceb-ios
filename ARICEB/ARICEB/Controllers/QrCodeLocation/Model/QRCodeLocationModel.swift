//
//  QRCodeLocationModel.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 22/08/21.
//

import Foundation

struct QRCodeLocationModel: Codable {
    let buildingID: Int?
    let sectorID: Int?
    let subsectorID: Int?
    let buildingName: String?
    let sectorName: String?
    let subsectorName: String?
}
