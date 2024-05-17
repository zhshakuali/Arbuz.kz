//
//  NetworkService.swift
//  ArbuzKZ
//
//  Created by Жансая Шакуали on 17.05.2024.
//

import Foundation

class NetworkService: NetworkServiceProtocol {
    func makeRequest<T: Decodable>() async throws -> T {
        throw NetworkError.common
    }
}
