//
//  ProductCellView.swift
//  ArbuzKZ
//
//  Created by Жансая Шакуали on 16.05.2024.
//

import SwiftUI

struct ProductCellView: View {
    
    enum CellType {
        case horizontal
        case vertical
    }
    
    private var imageSize: CGFloat {
        cellType == .vertical ? 128 : 96
    }
    
    let product: ProductModel
    let cellType: CellType
    let isFavorite: Bool
    let onClose: (Int) -> Void
    let onFavorite: (Int) -> Void
    
    init(
        product: ProductModel,
        isFavorite: Bool,
        cellType: CellType = .horizontal,
        onClose: @escaping (Int) -> Void,
        onFavorite: @escaping (Int) -> Void
    ) {
        self.product = product
        self.cellType = cellType
        self.isFavorite = isFavorite
        self.onClose = onClose
        self.onFavorite = onFavorite
    }
    
    var body: some View {
        switch cellType {
        case .horizontal:
            horizontalContent
        case .vertical:
            verticalContent
        }
    }
    
    private var verticalContent: some View {
        VStack {
            imageContent
            productInfo
            DefaultButton(
                product: product,
                initialValue: 0,
                onRemoveProduct: {
                    onClose(product.id)
                }
            )
        }
    }
    
    private var horizontalContent: some View {
        HStack(spacing: 12) {
            imageContent
            
            VStack {
                HStack(alignment: .top) {
                    productInfo
                    
                    Spacer(minLength: 20)
                    
                    Button(action: {
                        onClose(product.id)
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
                            onClose(product.id)
                        }
                    )
                    
                    Spacer(minLength: 0)
                    
                    Text("6500 T") // TODO: Show total amount per product
                        .fontWeight(.bold)
                }
            }
        }
        .frame(height: imageSize)
    }
    
    private var imageContent: some View {
        ZStack(alignment: .topTrailing) {
            Image(product.image)
                .resizable()
                .scaledToFit()
                .clipped()
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            
            Button(action: {
                onFavorite(product.id)
            }, label: {
                Image(systemName: isFavorite ? "heart.fill" : "heart")
            })
            .padding(.top, 6)
            .padding(.trailing, 4)
        }
    }
    
    private var productInfo: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(product.title)
                    .font(.callout)
                    .lineLimit(2)
                
                Text("\(product.formattedPrice) \(product.prefix)")
                    .font(.callout)
                    .lineLimit(1)
                    .foregroundColor(Color.gray)
            }
            
            Spacer(minLength: 0)
        }
    }
}

#Preview {
    ProductCellView(
        product: .mockProduct1,
        isFavorite: false,
        onClose: { _ in
            
        },
        onFavorite: { _ in
            
        }
    )
    .padding()
}
