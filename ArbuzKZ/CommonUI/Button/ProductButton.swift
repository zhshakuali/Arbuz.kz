//
//  ProductButton.swift
//  ArbuzKZ
//
//  Created by Жансая Шакуали on 18.05.2024.
//

import SwiftUI

struct ProductButton<Content: View>: View {
    
    struct ButtonConfig {
        enum Size {
            case small
            case medium
            case large
            
            var value: Font {
                switch self {
                case .small:
                    return Font.caption2
                case .medium:
                    return Font.caption
                case .large:
                    return Font.body
                }
            }
            
            var size: CGFloat {
                switch self {
                case .small:
                    return 20
                case .medium:
                    return 32
                case .large:
                    return 48
                }
            }
        }
        
        let image: String
        let isHidden: Bool
        let size: Size
        let isEnabled: Bool
        let accentColor: Color
        let action: () -> Void
        
        init(image: String, isHidden: Bool = false, size: Size = .small, isEnabled: Bool = true, accentColor: Color = .primary, action: @escaping () -> Void) {
            self.image = image
            self.isHidden = isHidden
            self.size = size
            self.isEnabled = isEnabled
            self.accentColor = accentColor
            self.action = action
        }
    }
    
    let leftButtonConfig: ButtonConfig
    let rightButtonConfig: ButtonConfig
    let content: () -> Content
    
    init(
        leftButtonConfig: ButtonConfig,
        rightButtonConfig: ButtonConfig,
        content: @escaping () -> Content
    ) {
        self.leftButtonConfig = leftButtonConfig
        self.rightButtonConfig = rightButtonConfig
        self.content = content
    }
    
    var body: some View {
        HStack(spacing: 0) {
            Button(action: {
                leftButtonConfig.action()
            }, label: {
                Image(systemName: leftButtonConfig.image)
                    .font(leftButtonConfig.size.value.weight(.bold))
            })
            .accentColor(leftButtonConfig.accentColor)
            .frame(width: leftButtonConfig.size.size, height: leftButtonConfig.size.size)
            .disabled(!leftButtonConfig.isEnabled)
            .opacity(leftButtonConfig.isHidden ? 0 : 1)
            
            Spacer(minLength: 0)
            
            content()
            
            Spacer(minLength: 0)
            
            Button(action: {
                rightButtonConfig.action()
            }, label: {
                Image(systemName: rightButtonConfig.image)
                    .font(rightButtonConfig.size.value.weight(.bold))
            })
            .accentColor(rightButtonConfig.accentColor)
            .frame(width: rightButtonConfig.size.size, height: rightButtonConfig.size.size)
            .disabled(!rightButtonConfig.isEnabled)
            .opacity(rightButtonConfig.isHidden ? 0 : 1)
        }
    }
}

#Preview {
    ProductButton(
        leftButtonConfig: .init(image: "minus", action: {}),
        rightButtonConfig: .init(image: "plus", action: {}),
        content: {
            Text("1 шт")
        }
    )
}
