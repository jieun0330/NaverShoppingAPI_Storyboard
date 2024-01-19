//
//  UIViewControllerExtension.swift
//  SeSAC_Recap
//
//  Created by 박지은 on 1/18/24.
//

import UIKit

// SeSAC4NFourthWeek -> UIViewControllerExtension
struct Colors {
    static let pointColor = UIColor.init(red: 73, green: 200, blue: 146)
    static let backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 1)
    static let textColor = UIColor.init(red: 255, green: 255, blue: 255, alpha: 1)
}

struct Fonts {
    static let font13 = UIFont.systemFont(ofSize: 13)
    static let font14 = UIFont.systemFont(ofSize: 14)
    static let font15 = UIFont.systemFont(ofSize: 15)
    static let font16 = UIFont.systemFont(ofSize: 16)
    static let font17 = UIFont.systemFont(ofSize: 17)
}

// color extension 정리하기
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
            self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
        }
}


// 3. 컴플리션 핸들러, 인스턴스, 프로퍼티, 메소드, 연산 프로퍼티, 저장 프로퍼티
