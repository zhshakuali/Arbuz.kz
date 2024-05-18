//
//  CellTextContentView.swift
//  ArbuzKZ
//
//  Created by Жансая Шакуали on 18.05.2024.
//

import SwiftUI

struct CellTextContentView: View {
    
    let title: String
    let titleFontWeight: Font.Weight
    let subtitle: String
    
    init(
        title: String,
        titleFontWeight: Font.Weight = .regular,
        subtitle: String
    ) {
        self.title = title
        self.titleFontWeight = titleFontWeight
        self.subtitle = subtitle
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.caption)
                    .fontWeight(titleFontWeight)
                
                Text(subtitle)
                    .font(.caption2)
                    .foregroundColor(.gray)
            }
            
            Spacer(minLength: 0)
        }
    }
}

#Preview {
    CellTextContentView(title: "Лимон Аргентина", subtitle: "1 950 T/шт")
}
