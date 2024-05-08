//
//  Keyword.swift
//  SeSAC_Recap
//
//  Created by 박지은 on 1/20/24.
//

import Foundation

struct Products: Codable {
    let total: Int
    var items: [Item]
}

struct Item: Codable {
    let title: String
    let link: String
    let image: String
    let lprice, mallName, productID: String

    enum CodingKeys: String, CodingKey {
        case title, link, image, lprice, mallName
        case productID = "productId"
    }
}
