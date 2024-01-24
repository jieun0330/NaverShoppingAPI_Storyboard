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
        case likeNum
//        case target
    }
    
    let ud = UserDefaults.standard
    
    var likeNum: String {
        // 값 가지고 오기
        get {
            ud.string(forKey: UDKey.likeNum.rawValue) ?? ""
        }
        // 값 저장
        set {
            ud.set(newValue, forKey: UDKey.likeNum.rawValue)
        }
    }
//
//    
//    
//    var target: String {
//        // 값 가지고 오기
//        get {
//            ud.string(forKey: UDKey.target.rawValue) ?? "ko"
//        }
//        // 값 저장
//        set {
//            ud.set(newValue, forKey: UDKey.target.rawValue)
//        }
//    }
//    
}
