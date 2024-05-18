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
    
    let product: ProductModel
    let type: CellType
    
    init(product: ProductModel = .mockProduct1, type: CellType = .base) {
        self.product = product
        self.type = type
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
                        initialValue: 0,
                        onRemoveProduct: {
                            
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
                                
                            }, label: {
                                Image(systemName: "xmark")
                            })
                            .accentColor(.gray)
                        }
                        
                        Spacer(minLength: 0)
                        
                        HStack {
                            BasketButton(
                                product: product,
                                initialValue: 0,
                                onRemoveProduct: {
                                    
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
