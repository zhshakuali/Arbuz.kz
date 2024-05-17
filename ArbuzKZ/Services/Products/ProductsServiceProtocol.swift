//
//  ProductsServiceProtocol.swift
//  ArbuzKZ
//
//  Created by Жансая Шакуали on 17.05.2024.
//

import Foundation

protocol ProductsServiceProtocol {
    func fetchProducts() async throws -> [ProductModel]
}
