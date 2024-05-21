//
//  BannerView.swift
//  ArbuzKZ
//
//  Created by Жансая Шакуали on 21.05.2024.
//

import SwiftUI

struct BannerView: View {
    @State var isPresented = false
    @ObservedObject var viewModel: BasketViewModel
    let onShown: (Bool) -> Void
    var body: some View {
        VStack {
            if isPresented {
                Text(viewModel.freeDelieveryText)
                    .font(.caption)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 4)
                    .background(RoundedRectangle(cornerRadius: 4).fill(Color.green.opacity(0.5)))
                    .transition(.move(edge: .top))
            }
        }
        .onAppear(perform: {
            showBannerIfNeeded(viewModel.totalPrice)
        })
        .onChange(of: viewModel.totalPrice) { newValue in
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
    BannerView(viewModel: BasketViewModel(cartManager: CartManager()), onShown: { _ in })
}
