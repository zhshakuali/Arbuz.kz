//
//  BasketViewModel.swift
//  ArbuzKZ
//
//  Created by Жансая Шакуали on 21.05.2024.
//

import Foundation
import Combine

class BasketViewModel: ObservableObject {
   private var cancellables = Set<AnyCancellable>()
    @Published var freeDelieveryText = ""
    @Published var totalPrice: Double = 0
    var items: [ProductModel] {
        cartManager.getProducts()
    }
    let cartManager: CartManager
    
    init(cartManager: CartManager) {
        self.cartManager = cartManager
        setupSubscriptions()
    }
    
    func setupSubscriptions() {
        cartManager.$cartPrice.filter{ $0 <= 8000 }.sink { [weak self] price in
            let difference = String(format: "До бесплатной доставки: %@ T", "\(8000 - price)")
            self?.freeDelieveryText = difference
        }.store(in: &cancellables)
        
        cartManager.$cartPrice.assign(to: &$totalPrice)
    }
}
