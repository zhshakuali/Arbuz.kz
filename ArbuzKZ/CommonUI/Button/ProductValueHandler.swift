//
//  ProductValueHandler.swift
//  ArbuzKZ
//
//  Created by Жансая Шакуали on 18.05.2024.
//

import Foundation

class ProductValueHandler: ObservableObject {
    @Published var currentValue = 0.0
    
    var currentValusMoreThanZero: Bool {
        currentValue > 0
    }
    
    var currentValueInPieces: Int {
        Int(currentValue / product.measure.count)
    }
    
    var currentValueIsOne: Bool {
        currentValue == productOnePiece
    }
    
    var currentValueIsOneOrLessThanZero: Bool {
        currentValue <= productOnePiece
    }
    
    var isCurrentValueMax: Bool {
        currentValue == product.balance
    }
    
    var productOnePiece: Double {
        product.measure.count
    }
    
    var formattedCurrentValue: String {
        String(format: "%.1f", currentValue)
    }
    
    let product: ProductModel
    
    init(currentValue: Double = 0, product: ProductModel) {
        self.currentValue = currentValue
        self.product = product
    }
    
    func decrement(_ onRemove: () -> Void) {
        guard currentValusMoreThanZero else { return }
        
        onRemove()
        currentValue -= productOnePiece
    }
    
    func increment() {
        currentValue += productOnePiece
    }
}
