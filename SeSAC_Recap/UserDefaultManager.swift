//
//  UserDefaultManager.swift
//  SeSAC_Recap
//
//  Created by 박지은 on 1/24/24.
//

import Foundation

class UserDefaultManager {
    
    private init() { }
    static let shared = UserDefaultManager()
    
    enum UDKey: String {
        case likes      // 좋아요 누른 상품 넣어놓기
        case keywords   // 검색한 상품 넣어놓기
    }
    
    let ud = UserDefaults.standard
    
    var likes: [String] {
        get {
            ud.stringArray(forKey: UDKey.likes.rawValue) ?? []
        }
        set {
            ud.set(newValue, forKey: UDKey.likes.rawValue)
        }
    }
    
    var keywords: [String] {
        get {
            ud.stringArray(forKey: UDKey.keywords.rawValue) ?? []
        }
        set {
            ud.set(newValue, forKey: UDKey.keywords.rawValue)
        }
    }
}
