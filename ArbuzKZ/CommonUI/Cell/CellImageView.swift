//
//  CellImageView.swift
//  ArbuzKZ
//
//  Created by Жансая Шакуали on 18.05.2024.
//

import SwiftUI

struct CellImageView: View {
    let image: String
    
    init(image: String) {
        self.image = image
    }
    
    var body: some View {
        Color.clear
            .background(
                Image(image)
                    .resizable()
                    .scaledToFill()
            )
            .aspectRatio(1, contentMode: .fill)
            .clipped()
            .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    CellImageView(image: "a1")
}
