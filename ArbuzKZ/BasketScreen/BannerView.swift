//
//  BannerView.swift
//  ArbuzKZ
//
//  Created by Жансая Шакуали on 21.05.2024.
//

import SwiftUI

struct BannerView: View {
    @State var isPresented = false
    @ObservedObject var cartManager: CartManager
    let onShown: (Bool) -> Void
    var body: some View {
        VStack {
            if isPresented {
                Text("До бесплатной доставки: \(8000 - cartManager.cartPrice, specifier: "%.2f") Т")
                    .font(.caption)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 4)
                    .background(RoundedRectangle(cornerRadius: 4).fill(Color.green.opacity(0.5)))
                    .transition(.move(edge: .top))
            }
        }
        .onAppear(perform: {
            showBannerIfNeeded(cartManager.cartPrice)
        })
        .onChange(of: cartManager.cartPrice) { newValue in
            showBannerIfNeeded(newValue)
        }
        .onChange(of: isPresented) { newValue in
            onShown(newValue)
        }
    }
    
    func showBannerIfNeeded(_ price: Double) {
        withAnimation {
            isPresented = price > 8000 ? false : true
        }

    }
}

#Preview {
    BannerView(cartManager: CartManager(), onShown: { _ in })
}
