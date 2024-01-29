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
        case profileImg //프로필 이미지
        case nickname   // 닉네임
        case likes      // 좋아요 누른 상품 넣어놓기
        case keywords   // 검색한 상품 넣어놓기
    }
    
    let userDefaults = UserDefaults.standard
    
    // 아니 값을 저장해야 가져올 수 있는건데 왜 set이 밑에 있는거야 헷갈리게 짱나누
    // UserDefaults.standard.object(forKey: key.rawValue)
    // UserDefaults.standard.set(object, forKey: key.rawValue)
    // key.rawValue값을 object에 저장하면
    // key.rawValue값이 저장된 object를 찾아서 꺼내주는거지???
    
    // @propertyWrapper 속성을사용하여 UserDefaults를 간소화하는 방법이 있다고 한다
    // ㅇㅋ도전
    // @propertyWrapper는 저장에 대한 사용자 정의 동작을 정의할 수 있게 해준다
    // 네?
    // @propertyWrapper를 사용하면 데이터를 UserDefaults에 저장하고 검색하는 과정을 간소화하여 보일러플레이트 코드와 오류 발생 가능성을 줄일 수 있다
    // 네? 보일러요?
    // 보일러플레이트 코드: 여러 가지 상황에서 거의 또는 전혀 변경하지 않고 재사용할 수 있는 컴퓨터 언어 텍스트
    // 배움은 끝이 없고 ^.^
    // 최소한의 변경으로 여러곳에서 재사용되며, 반복적으로 비슷한 형태를 띄는 코드를 말한다
    
    // 그치 userDefault 형태가 다 비슷하니까 ㅇㅋㅇㅋㅇ 써볼게
    // 포기 다음에 보자
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
