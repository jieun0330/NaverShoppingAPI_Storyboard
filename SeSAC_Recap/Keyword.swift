//
//  Keyword.swift
//  SeSAC_Recap
//
//  Created by 박지은 on 1/20/24.
//

import Foundation

// MARK: - Welcome
struct Welcome: Codable {
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

//enum Brand: String, Codable {
//    case empty = ""
//    case 스타모빌 = "스타모빌"
//    case 쌍용 = "쌍용"
//}
//
//enum Category1: String, Codable {
//    case 스포츠레저 = "스포츠/레저"
//}
//
//enum Category2: String, Codable {
//    case 캠핑 = "캠핑"
//}
//
//enum Category3: String, Codable {
//    case 기타캠핑용품 = "기타캠핑용품"
//}
//
