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
    
    init(product: ProductModel, cellType: CellType = .horizontal) {
        self.product = product
        self.cellType = cellType
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
        }
        .frame(width: imageSize)
    }
    
    private var horizontalContent: some View {
        HStack(spacing: 12) {
            imageContent
            
            VStack {
                HStack(alignment: .top) {
                    productInfo
                    
                    Spacer(minLength: 20)
                    
                    Button(action: {
                        // TODO: Remove from basket
                    }, label: {
                        Image(systemName: "xmark")
                    })
                    .accentColor(.gray)
                }
                
                Spacer(minLength: 0)
                
                HStack {
                    // TODO: Add button here
                    
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
                .aspectRatio(contentMode: .fill)
                .frame(width: imageSize, height: imageSize)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            Button(action: {
                // TODO: Add into/Remove from favorites
            }, label: {
                Image(systemName: "heart")
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
        product: .mockProduct1
    )
    .padding()
}
