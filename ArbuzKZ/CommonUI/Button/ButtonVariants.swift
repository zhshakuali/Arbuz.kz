//
//  ButtonVariants.swift
//  ArbuzKZ
//
//  Created by Жансая Шакуали on 18.05.2024.
//

import SwiftUI

struct BasketButton: View {
    
    @StateObject var valueHandler: ProductValueHandler
    
    var leftButtonImage: String {
        valueHandler.currentValueIsOneOrLessThanZero ? "trash" : "minus"
    }
    
    let product: ProductModel
    @Binding var currentValue: Double
    let onIncrement: () -> Void
    let onDecrement: () -> Void
    
    init(product: ProductModel, currentValue: Binding<Double>, onIncrement: @escaping () -> Void, onDecrement: @escaping () -> Void) {
        self.product = product
        self._valueHandler = StateObject(wrappedValue: ProductValueHandler(currentValue: currentValue.wrappedValue, product: product))
        self._currentValue = currentValue
        self.onIncrement = onIncrement
        self.onDecrement = onDecrement
    }
    
    var body: some View {
        ProductButton(
            leftButtonConfig: .init(
                image: leftButtonImage,
                accentColor: .primary,
                action: {
                    valueHandler.decrement {
                        onDecrement()
                    }
                }
            ),
            rightButtonConfig: .init(
                image: "plus",
                isEnabled: !valueHandler.isCurrentValueMax,
                accentColor: .primary,
                action: {
                    valueHandler.increment()
                    onIncrement()
                }
            ),
            content: {
                ButtonContent(
                    alignment: .center,
                    title: .init(value: valueHandler.formattedCurrentValue, font: .caption2),
                    subtitle: .init(value: product.measure.prefix, font: .caption2)
                )
            }
        )
        .frame(width: 96, height: 36)
        .padding(.horizontal, 12)
        .background(Color.gray)
        .clipped()
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .onChange(of: currentValue) {
            valueHandler.currentValue = $0
        }
    }
}

struct DefaultButton: View {
    @StateObject var valueHandler: ProductValueHandler
    
    let product: ProductModel
    @Binding var currentValue: Double
    let onIncrement: () -> Void
    let onDecrement: () -> Void
    
    init(product: ProductModel, currentValue: Binding<Double>, onIncrement: @escaping () -> Void, onDecrement: @escaping () -> Void) {
        self.product = product
        self._valueHandler = StateObject(wrappedValue: ProductValueHandler(currentValue: currentValue.wrappedValue, product: product))
        self._currentValue = currentValue
        self.onIncrement = onIncrement
        self.onDecrement = onDecrement
    }
    
    var body: some View {
        ProductButton(
            leftButtonConfig: .init(
                image: "minus",
                isHidden: !valueHandler.currentValusMoreThanZero,
                accentColor: valueHandler.currentValusMoreThanZero ? .white : .green,
                action: {
                    valueHandler.decrement {
                        onDecrement()
                    }
                }
            ),
            rightButtonConfig: .init(
                image: "plus",
                isEnabled: !valueHandler.isCurrentValueMax,
                accentColor: valueHandler.currentValusMoreThanZero ? .white : .green,
                action: {
                    valueHandler.increment()
                    onIncrement()
                }
            ),
            content: {
                ButtonContent(
                    alignment: valueHandler.currentValusMoreThanZero ? .center : .leading,
                    title: .init(value: valueHandler.currentValusMoreThanZero ? valueHandler.formattedCurrentValue : product.formattedPrice, font: .caption, fontWeight: .bold, color: valueHandler.currentValusMoreThanZero ? .white : .primary),
                    subtitle: nil
                )
            }
        )
        .frame(height: 32)
        .padding(.horizontal, 16)
        .background(valueHandler.currentValusMoreThanZero ? Color.green : Color.gray)
        .clipped()
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .onChange(of: currentValue) {
            valueHandler.currentValue = $0
        }
    }
}

struct ProductDetailButton: View {
    @StateObject var valueHandler: ProductValueHandler
    
    let product: ProductModel
    @Binding var currentValue: Double
    let onIncrement: () -> Void
    let onDecrement: () -> Void
    
    init(product: ProductModel, currentValue: Binding<Double>, onIncrement: @escaping () -> Void, onDecrement: @escaping () -> Void) {
        self.product = product
        self._valueHandler = StateObject(wrappedValue: ProductValueHandler(currentValue: currentValue.wrappedValue, product: product))
        self._currentValue = currentValue
        self.onIncrement = onIncrement
        self.onDecrement = onDecrement
    }
    
    var body: some View {
        ProductButton(
            leftButtonConfig: .init(
                image: "minus",
                isHidden: !valueHandler.currentValusMoreThanZero,
                accentColor: .white,
                action: {
                    valueHandler.decrement {
                        onDecrement()
                    }
                }
            ),
            rightButtonConfig: .init(
                image: "plus",
                isEnabled: !valueHandler.isCurrentValueMax,
                accentColor: .white,
                action: {
                    valueHandler.increment()
                    onIncrement()
                }
            ),
            content: {
                ButtonContent(
                    alignment: .center,
                    title: .init(value: valueHandler.formattedCurrentValue, font: .caption, fontWeight: .bold, color: .white),
                    subtitle: nil
                )
            }
        )
        .frame(height: 56)
        .padding(.horizontal, 16)
        .background(Color.green)
        .clipped()
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .onChange(of: currentValue) {
            valueHandler.currentValue = $0
        }
    }
}

#Preview {
    VStack(spacing: 40) {
        BasketButton(
            product: .mockProduct1,
            currentValue: .constant(0),
            onIncrement: {
                
            },
            onDecrement: {
                
            }
        )
        
        DefaultButton(
            product: .mockProduct3,
            currentValue: .constant(0),
            onIncrement: {
                
            },
            onDecrement: {
                
            }
        )
        
        ProductDetailButton(
            product: .mockProduct4,
            currentValue: .constant(0),
            onIncrement: {
                
            },
            onDecrement: {
                
            }
        )
    }
    .padding()
}
