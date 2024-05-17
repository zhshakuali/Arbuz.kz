//
//  NetworkServiceProtocol.swift
//  ArbuzKZ
//
//  Created by Жансая Шакуали on 17.05.2024.
//

import Foundation

protocol NetworkServiceProtocol {
    func makeRequest<T: Decodable>() async throws -> T
}
