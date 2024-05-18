//
//  ProductDetailView.swift
//  ArbuzKZ
//
//  Created by Жансая Шакуали on 16.05.2024.
//

import SwiftUI

struct ProductDetailView: View {

    @State private var isFavorite = false

    @EnvironmentObject var cartManager: CartManager
    
    let product: ProductModel
    let onClose: () -> Void

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    Image(product.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
                        .clipShape(RoundedRectangle(cornerRadius: 12))

                    Text(product.title)
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)

                    Text("1 шт = \(product.measure.formattedMeasure)")
                        .font(.subheadline)

                    VStack(alignment: .leading, spacing: 12) {
                        Text("Описание")
                            .font(.title)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        Text(product.description)
                    }

                    Spacer(minLength: 0).frame(height: 20)

                    ProductDetailButton(
                        product: product,
                        currentValue: Binding(get: {
                            cartManager.count(for: product)
                        }, set: { _ in
                            
                        }),
                        onIncrement: {
                            cartManager.incrementProduct(product)
                        },
                        onDecrement: {
                            cartManager.decrementProduct(product)
                        }
                    )
                }
                .padding(.horizontal, 12)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        onClose()
                    }, label: {
                        Image(systemName: "xmark")
                            .accentColor(.black)
                            .frame(width: 24, height: 24)
                    })
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        isFavorite.toggle()
                    }, label: {
                        Image(systemName: isFavorite ? "heart.fill" : "heart")
                            .accentColor(.black)
                            .frame(width: 24, height: 24)
                    })
                }
            }
            .onChange(of: isFavorite) { value in
                // TODO: Add to/Remote from favorite products
            }
        }
    }
}

#Preview {
    ProductDetailView(product: .mockProduct1) {

    }
}
