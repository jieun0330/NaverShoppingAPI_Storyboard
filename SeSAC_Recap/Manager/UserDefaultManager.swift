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
        case profileImg //프로필 이미지
        case nickname   // 닉네임
        case likes      // 좋아요 누른 상품 넣어놓기
        case keywords   // 검색한 상품 넣어놓기
    }
    
    let userDefaults = UserDefaults.standard
    
    var profileImg: Int {
        get {
            userDefaults.integer(forKey: UDKey.profileImg.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: UDKey.profileImg.rawValue)
        }
    }
    
    var nickname: String {
        get {
            userDefaults.string(forKey: UDKey.nickname.rawValue) ?? ""
        }
        set {
            userDefaults.set(newValue, forKey: UDKey.nickname.rawValue)
        }
    }
    
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
