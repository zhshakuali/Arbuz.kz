//
//  FavoriteProductsManager.swift
//  ArbuzKZ
//
//  Created by Жансая Шакуали on 18.05.2024.
//

import SwiftUI

class FavoriteProductsManager: ObservableObject {
    @Published var favoriteProductIDs: Set<Int> = []
    
    func isFavorite(_ id: Int) -> Bool {
        favoriteProductIDs.contains(id)
    }
    
    func updateProductID(_ id: Int) {
        if favoriteProductIDs.contains(id) {
            favoriteProductIDs.remove(id)
        } else {
            favoriteProductIDs.insert(id)
        }
        objectWillChange.send()
    }
}
