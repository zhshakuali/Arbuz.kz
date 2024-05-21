//
//  CartButton.swift
//  ArbuzKZ
//
//  Created by Жансая Шакуали on 20.05.2024.
//

import SwiftUI

struct CartButton: View {
    @ObservedObject var cartManager: CartManager
    @State private var isLoading = false
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            Task {
                await validateCart()
                action()
            }
        }) {
            VStack {
                if isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    Text("Перейти к оплате")
                        .foregroundColor(.white)
                        .fontWeight(.heavy)
                    
                    Text("\(cartManager.cartPrice, specifier: "%.2f") Т")
                        .bold()
                        .foregroundColor(.white)
                }
            }
            .padding(10)
            .frame(maxWidth: .infinity)
            .background(Color.green.opacity(0.7))
            .cornerRadius(10)
        }
    }
    
    @MainActor
    private func validateCart() async {
        isLoading = true
        try? await Task.sleep(seconds: 1)
        isLoading = false
    }
}

#Preview {
    CartButton(cartManager: CartManager()) {
        
    }
}
