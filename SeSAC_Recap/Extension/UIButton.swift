//
//  UIButton+Extension.swift
//  SeSAC_Recap
//
//  Created by 박지은 on 1/19/24.
//

import UIKit

extension UIButton {
    func configureButtonPrimaryStyle(title: String) {
        self.setTitle(title, for: .normal)
        self.backgroundColor = Colors.pointColor
        self.layer.cornerRadius = 12
        self.setTitleColor(Colors.textColor, for: .normal)
        self.titleLabel?.font = Fonts.font13
    }
}
