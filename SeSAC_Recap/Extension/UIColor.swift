//
//  UIColor.swift
//  SeSAC_Recap
//
//  Created by 박지은 on 2/11/24.
//

import UIKit

extension UIColor {
    static let pointColor = UIColor.init(red: 73, green: 200, blue: 146)
    static let backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 1)
    static let textColor = UIColor.init(red: 255, green: 255, blue: 255, alpha: 1)
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
}
