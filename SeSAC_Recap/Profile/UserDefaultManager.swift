//
//  UserDefaultManager.swift
//  SeSAC_Recap
//
//  Created by 박지은 on 1/21/24.
//

import Foundation

class UserDefaultManager {
    
    private init() { }
    
    static let shared = UserDefaultManager()
    
//    let randomNum = Int.random(in: 1...14)
//    profileImg.image = UIImage(named: "profile\(randomNum)")
    
//    var UDKey: String
    
    var test: String {
        get {
            UserDefaults.standard.string(forKey: "test") ?? "testtest"
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "test")
        }
        
    }
    
    
    
}
