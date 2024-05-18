//
//  ProductModel.swift
//  ArbuzKZ
//
//  Created by Жансая Шакуали on 17.05.2024.
//

import Foundation

class ProductModel: Hashable, Equatable, Decodable {
    struct Measure: Hashable, Equatable, Decodable {
        let count: Double
        let prefix: String

        var formattedMeasure: String {
            String(format: "%.1f %@", count, prefix)
        }
    }

    let id: Int
    let category: String
    let title: String
    let measure: Measure
    let price: Double
    let prefix: String
    let description: String
    let image: String
    
    init(
        id: Int,
        category: String,
        title: String,
        measure: Measure,
        price: Double,
        prefix: String,
        description: String,
        image: String
    ) {
        self.id = id
        self.category = category
        self.title = title
        self.measure = measure
        self.price = price
        self.prefix = prefix
        self.description = description
        self.image = image
    }
    
    var formattedPrice: String {
        String(format: "%.1f", price)
    }
    
    static func == (lhs: ProductModel, rhs: ProductModel) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension ProductModel {
    static var mockProduct1: ProductModel {
        .init(
            id: 1,
            category: "Фрукты",
            title: "Бананы",
            measure: .init(count: 1, prefix: "кг"),
            price: 890,
            prefix: "т/кг",
            description: "Бананы десертные обладают плотной, сладкой мякотью и освежающим ароматом с травянистыми нотками. Цвет бананов может варьироваться от салатного до желтого цвета. Спелые и сладкие бананы не нуждаются в представлении: этот тропический фрукт - один из самых популярных в Казахстане! Когда-то за бананами выстраивались очереди, а сейчас они есть в каждом доме. Бананы вкусные, сытные, их легко взять В дорогу.",
            image: "a1"
        )
    }
    
    static var mockProduct2: ProductModel {
        .init(
            id: 2,
            category: "Фрукты",
            title: "Голубика",
            measure: .init(count: 0.5, prefix: "кг"),
            price: 8350,
            prefix: "т/кг",
            description: "Голубика улучшает аппетит, укрепляет стенки сосудов и считается отличным противовоспалительным, желчегонным и мочегонным средством. Также голубика препятствует проявлению склероза, защищает от радиоактивного излучения, снижает уровень сахара в крови и помогает при желудочных и сердечных заболеваниях.",
            image: "a2"
        )
    }
}
