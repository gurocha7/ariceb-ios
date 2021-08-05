//
//  BaseError.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 05/08/21.
//

import Foundation

struct BaseError: Codable {
    let error: String?
    let message: String?
    let statusCode: Int?
}
