//
//  CellTotalPriceView.swift
//  ArbuzKZ
//
//  Created by Жансая Шакуали on 18.05.2024.
//

import SwiftUI

//struct CellTotalPriceView: View {
//    
//    let title: String
//    
//    var body: some View {
//        Text(title)
//            .font(.headline)
//            .fontWeight(.bold)
//    }
//}

struct CellTotalPriceView: View {
    
    let totalPrice: Int
    
    var body: some View {
        Text("\(totalPrice) T")
            .font(.headline)
            .fontWeight(.bold)
    }
}



#Preview {
    CellTotalPriceView(totalPrice: 6000)
}
