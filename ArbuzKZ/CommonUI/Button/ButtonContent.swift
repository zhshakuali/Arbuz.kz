//
//  ButtonContent.swift
//  ArbuzKZ
//
//  Created by Жансая Шакуали on 18.05.2024.
//

import SwiftUI

struct ButtonContent: View {
    
    struct TextConfig {
        let value: String
        let font: Font
        let fontWeight: Font.Weight
        let color: Color
        let isStrikethrough: Bool
        
        init(value: String, font: Font = .body, fontWeight: Font.Weight = .regular, color: Color = .primary, isStrikethrough: Bool = false) {
            self.value = value
            self.font = font
            self.fontWeight = fontWeight
            self.color = color
            self.isStrikethrough = isStrikethrough
        }
    }
    
    let alignment: HorizontalAlignment
    let title: TextConfig
    let subtitle: TextConfig?
    
    var body: some View {
        HStack {
            if alignment != .leading {
                Spacer(minLength: 0)
            }
            
            VStack(alignment: alignment, spacing: 0) {
                Text(title.value)
                    .font(title.font)
                    .fontWeight(title.fontWeight)
                    .foregroundColor(title.color)
                    .strikethrough(title.isStrikethrough)
                
                if let subtitle {
                    Text(subtitle.value)
                        .font(subtitle.font)
                        .fontWeight(subtitle.fontWeight)
                        .foregroundColor(subtitle.color)
                        .strikethrough(subtitle.isStrikethrough)
                        .minimumScaleFactor(0.5)
                }
            }
            
            if alignment != .trailing {
                Spacer(minLength: 0)
            }
        }
    }
}

#Preview {
    ButtonContent(
        alignment: .center,
        title: .init(
            value: "1970 T",
            font: .title,
            fontWeight: .semibold
        ),
        subtitle: .init(
            value: "1 шт",
            font: .caption,
            color: .secondary,
            isStrikethrough: true
        )
    )
}
