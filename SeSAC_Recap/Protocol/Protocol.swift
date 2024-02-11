//
//  Protocol.swift
//  SeSAC_Recap
//
//  Created by 박지은 on 1/19/24.
//

import UIKit

protocol ReusableProtocol {
    static var identifier: String { get }
}

extension UIViewController: ReusableProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell: ReusableProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}
