//
//  ProductModel.swift
//  ArbuzKZ
//
//  Created by Жансая Шакуали on 17.05.2024.
//

import Foundation

class ProductModel: Decodable {
    struct Measure: Decodable {
        let count: Double
        let prefix: String
    }

    let id: Int
    let category: String
    let title: String
    let measure: Measure
    let price: Double
    let prefix: String
    let description: String
    let image: String
}
