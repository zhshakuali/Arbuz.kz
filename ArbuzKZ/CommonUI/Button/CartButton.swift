//
//  CartButton.swift
//  ArbuzKZ
//
//  Created by Жансая Шакуали on 20.05.2024.
//

import SwiftUI

struct CartButton: View {
    @ObservedObject var cartManager: CartManager
    
    var body: some View {
        Button(action: {
            // Действие кнопки
        }) {
            VStack {
                Text("Перейти к оплате")
                    .foregroundColor(.white)
                    .fontWeight(.heavy)
                
                Text("\(String(cartManager.cartPrice)) Т")
                    .bold()
                    .foregroundColor(.white)
            }
            .padding(10)
            .frame(maxWidth: .infinity)
            .background(Color.green.opacity(0.7))
            .cornerRadius(10)
            
        }
    }
}



#Preview {
   CartButton(cartManager: CartManager())
}
