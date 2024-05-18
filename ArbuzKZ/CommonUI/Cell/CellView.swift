//
//  CellView.swift
//  ArbuzKZ
//
//  Created by Жансая Шакуали on 18.05.2024.
//

import SwiftUI

struct CellView: View {
    
    enum CellType {
        case base
        case cart
    }
    
    @ObservedObject var cartManager: CartManager
    
    let product: ProductModel
    let type: CellType
    let onRemove: () -> Void
    let onUpdate: () -> Void
    
    init(cartManager: CartManager, product: ProductModel = .mockProduct1, type: CellType = .base, onRemove: @escaping () -> Void = {}, onUpdate: @escaping () -> Void = {}) {
        self.cartManager = cartManager
        self.product = product
        self.type = type
        self.onRemove = onRemove
        self.onUpdate = onUpdate
    }
    
    var body: some View {
        ZStack {
            switch type {
            case .base:
                VStack {
                    imageContent
                    productInfo
                    DefaultButton(
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
                            onUpdate()
                        }
                    )
                }
            case .cart:
                HStack {
                    imageContent
                        .scaledToFit()
                    
                    VStack {
                        HStack(alignment: .top) {
                            productInfo
                            
                            Spacer(minLength: 20)
                            
                            Button(action: {
                                onRemove()
                            }, label: {
                                Image(systemName: "xmark")
                            })
                            .accentColor(.gray)
                        }
                        
                        Spacer(minLength: 0)
                        
                        HStack {
                            BasketButton(
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
                                    onUpdate()
                                }
                            )
                            
                            Spacer(minLength: 0)
                            
                            CellTotalPriceView(title: "6700 T")
                        }
                    }
                }
            }
        }
    }
    
    var imageContent: some View {
        CellImageView(image: product.image)
    }
    
    var productInfo: some View {
        CellTextContentView(title: product.title, subtitle: product.formattedPrice)
    }
}
