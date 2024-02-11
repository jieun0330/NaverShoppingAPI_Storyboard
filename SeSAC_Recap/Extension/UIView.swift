//
//  UIView.swift
//  SeSAC_Recap
//
//  Created by 박지은 on 2/11/24.
//

import UIKit

extension UIViewController {
    func configureProfileImage(_ sender: UIImageView) {
        sender.contentMode = .scaleAspectFill
        sender.layer.masksToBounds = false
        sender.layer.cornerRadius = sender.frame.height / 2
        sender.clipsToBounds = true
        sender.layer.borderWidth = 5
        sender.layer.borderColor = UIColor.pointColor.cgColor
    }
}
