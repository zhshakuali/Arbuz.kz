//
//  ProductsService.swift
//  ArbuzKZ
//
//  Created by Жансая Шакуали on 17.05.2024.
//

import Foundation

class ProductsService: ProductsServiceProtocol {

    private let networkService: NetworkServiceProtocol = MockedNetworkService()

    func fetchProducts() async throws -> [ProductModel] {
        try await networkService.makeRequest()
    }
}
