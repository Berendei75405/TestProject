//
//  DishModelForSave.swift
//  TestProject
//
//  Created by user on 03.07.2023.
//

import Foundation

// MARK: - DishModelForSave
struct DishModelForSave: Codable {
    let name: String
    var count: Int
    let price, weight: Int
    let image: Data

    enum CodingKeys: String, CodingKey {
        case name, price,
             weight, image, count
    }
}
