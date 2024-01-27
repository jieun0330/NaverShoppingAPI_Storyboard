//
//  UserDefaultManager.swift
//  SeSAC_Recap
//
//  Created by 박지은 on 1/24/24.
//

import Foundation

class UserDefaultManager {
    
    // 싱글톤 패턴
    // 유일하게 1개만 존재하는 객체
    // 외부에서 또다른 새로운 객체 생성을 금지하고 싶은 경우에 private init 메서드를 작성한다
    private init() { }
    static let shared = UserDefaultManager()
    
    enum UDKey: String {
        case likes      // 좋아요 누른 상품 넣어놓기
        case keywords   // 검색한 상품 넣어놓기
    }
    
    let userDefaults = UserDefaults.standard
    
    var likes: [String] {
        get {
            userDefaults.stringArray(forKey: UDKey.likes.rawValue) ?? []
        }
        set {
            userDefaults.set(newValue, forKey: UDKey.likes.rawValue)
        }
    }
    
    var keywords: [String] {
        get {
            userDefaults.stringArray(forKey: UDKey.keywords.rawValue) ?? []
        }
        set {
            userDefaults.set(newValue, forKey: UDKey.keywords.rawValue)
        }
    }
}
