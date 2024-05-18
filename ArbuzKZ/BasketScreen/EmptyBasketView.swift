//
//  EmptyBasketView.swift
//  ArbuzKZ
//
//  Created by Жансая Шакуали on 16.05.2024.
//

import SwiftUI

struct EmptyBasketView: View {
    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                VStack(spacing: 40) {
                    Image(systemName: "basket")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 200)
                    
                    Text("Ваша корзина пуста")
                }
                .frame(width: proxy.size.width)
                .frame(minHeight: proxy.size.height)
            }
        }
    }
}

#Preview {
    EmptyBasketView()
}
