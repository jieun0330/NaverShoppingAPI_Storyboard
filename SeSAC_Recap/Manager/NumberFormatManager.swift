//
//  NumberFormatManager.swift
//  SeSAC_Recap
//
//  Created by 박지은 on 5/8/24.
//

import Foundation

final class NumberFormatManager {
    static let shared = NumberFormatManager()
    
    private init() { }
    
    let numberFormatter: NumberFormatter = NumberFormatter()
    
    func numberFormat<T>(number: T) -> String {
        numberFormatter.numberStyle = .decimal
        
        return numberFormatter.string(for: number)!
    }
}
