//
//  CartManager.swift
//  ArbuzKZ
//
//  Created by Жансая Шакуали on 18.05.2024.
//

import SwiftUI

class CartManager: ObservableObject {
    @Published var products: [ProductModel] = []
    @Published var cartPrice: Double = 0
    
    func incrementProduct(_ product: ProductModel) {
        products.append(product)
        totalCartPrice()
        objectWillChange.send()
    }
    
    func decrementProduct(_ product: ProductModel) {
        if let index = products.firstIndex(of: product) {
            products.remove(at: index)
            totalCartPrice()
            objectWillChange.send()
        }
    }
    
    func removeProduct(_ product: ProductModel) {
        products.removeAll(where: { $0.id == product.id })
        totalCartPrice()
        objectWillChange.send()
    }
    
    func count(for product: ProductModel) -> Double {
        products.filter { $0.id == product.id }.reduce(0, { $0 + $1.measure.count })
    }
    
    func getProducts() -> [ProductModel] {
        var products: [ProductModel] = []
        
        self.products.forEach { product in
            if !products.contains(product) {
                products.append(product)
            }
        }
        
        return products
    }
    
    private func totalCartPrice() {
        let totalPrice = products.reduce(0.0) { $0 + $1.price }
        cartPrice = totalPrice
    }

}
