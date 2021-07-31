//
//  NextStepsModel.swift
//  ARICEB
//
//  Created by Gustavo Rocha on 31/07/21.
//

import Foundation

struct NextStepsModel: Codable {
    let nextqrcode_tags: [String]?
    let steps: [StepsModel]?
}
