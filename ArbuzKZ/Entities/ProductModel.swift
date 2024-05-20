//
//  ProductModel.swift
//  ArbuzKZ
//
//  Created by Жансая Шакуали on 17.05.2024.
//

import Foundation

class ProductModel: Identifiable, Hashable, Equatable, Decodable {
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
    let balance: Double
    let description: String
    let image: String
    
    init(
        id: Int,
        category: String,
        title: String,
        measure: Measure,
        price: Double,
        prefix: String,
        balance: Double,
        description: String,
        image: String
    ) {
        self.id = id
        self.category = category
        self.title = title
        self.measure = measure
        self.price = price
        self.prefix = prefix
        self.balance = balance
        self.description = description
        self.image = image
    }
    
    var formattedPrice: String {
        String(price)
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
            balance: 5,
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
            balance: 3.5,
            description: "Голубика улучшает аппетит, укрепляет стенки сосудов и считается отличным противовоспалительным, желчегонным и мочегонным средством. Также голубика препятствует проявлению склероза, защищает от радиоактивного излучения, снижает уровень сахара в крови и помогает при желудочных и сердечных заболеваниях.",
            image: "a2"
        )
    }
    
    static var mockProduct3: ProductModel {
        .init(
            id: 3,
            category: "Фрукты",
            title: "Лимон Аргентина",
            measure: .init(count: 1, prefix: "шт"),
            price: 300,
            prefix: "т/шт",
            balance: 3,
            description: "Лимон является основой для приготовления лимонада и ликера Лимончелло. Из лимона варят мармелады и джемы, его часто сочетают с имбирём и перцем чили. Лимонный сок основа салатных заправок и домашнего майонеза. Лимон является начинкой для пирогов и ароматной добавкой в сдобную выпечку.",
            image: "a3"
        )
    }
    
    static var mockProduct4: ProductModel {
        .init(
            id: 4,
            category: "Молочные продукты",
            title: "Сметана 15%",
            measure: .init(count: 1, prefix: "шт"),
            price: 885,
            prefix: "т/шт",
            balance: 3000,
            description: "Сметана «Простоквашино» - натуральный продукт, приготовленный по традиционным рецептам из свежих заквасок и сливок. Продукт используется как добавка к пельменям и вареникам, салатная заправка или самостоятельный соус. Хозяйки часто используют сметану в составе кондитерских кремов, а также добавляют в подливы для мясных, грибных и овощных блюд. Сметана «Простоквашино» обладает 5 гарантиями качества: ﻿﻿﻿Ежедневная забота и здоровье коров. ﻿﻿﻿Проверка по 80 параметрам качества. ﻿﻿﻿Перевозка и хранение в правильных условиях. ﻿﻿﻿Только сливки и закваска в составе. ﻿﻿﻿Вкус настоящей сметаны. Состав: Сливки нормализованные, заквасочные микроорганизмы.",
            image: "b1"
        )
    }
}
