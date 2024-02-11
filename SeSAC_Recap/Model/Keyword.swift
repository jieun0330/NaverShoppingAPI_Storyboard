//
//  Keyword.swift
//  SeSAC_Recap
//
//  Created by 박지은 on 1/20/24.
//

import Foundation

// MARK: - Welcome
struct Products: Codable {
    let total: Int
    var items: [Item]
}

// MARK: - Item
struct Item: Codable {
    let title: String
    let link: String
    let image: String
    let lprice, mallName, productID: String
//    let productType: String
//    let brand, maker: Brand
//    let category1: Category1
//    let category2: Category2
//    let category3: Category3
//    let category4: String

    enum CodingKeys: String, CodingKey {
        case title, link, image, lprice, mallName
        case productID = "productId"
//        case productType, brand, maker, category1, category2, category3, category4
    }
}
