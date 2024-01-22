//
//  KeywordResultsTableViewCell.swift
//  SeSAC_Recap
//
//  Created by 박지은 on 1/21/24.
//

import UIKit

class KeywordResultsTableViewCell: UITableViewCell {
    
    @IBOutlet var searchIcon: UIButton!
    @IBOutlet var keyword: UILabel!
    @IBOutlet var deleteButton: UIButton!
    
    var keywordList = MainViewController().keywordList
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureCell()
                
    }
    

}

extension KeywordResultsTableViewCell {
    func configureCell() {
        searchIcon.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchIcon.tintColor = Colors.textColor
        deleteButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        deleteButton.tintColor = Colors.textColor
        
    }
}
