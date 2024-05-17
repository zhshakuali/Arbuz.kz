//
//  MockedNetworkService.swift
//  ArbuzKZ
//
//  Created by Жансая Шакуали on 17.05.2024.
//

import Foundation

class MockedNetworkService: NetworkServiceProtocol {
    func makeRequest<T: Decodable>() async throws -> T {
        try await Task.sleep(nanoseconds: 1)
        guard let fileURL = Bundle.main.url(forResource: "Products", withExtension: "json") else {
            throw NetworkError.common
        }

        let data = try Data(contentsOf: fileURL, options: .mappedIfSafe)
        return try JSONDecoder().decode(T.self, from: data)
    }
}
