//
//  NoKeywordTableViewCell.swift
//  SeSAC_Recap
//
//  Created by 박지은 on 1/21/24.
//

import UIKit

class NoKeywordTableViewCell: UITableViewCell {
    
    @IBOutlet var noKeywordImg: UIImageView!
    @IBOutlet var noKeywordLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        noKeywordImg.image = .empty
        noKeywordLabel.text = "최근 검색어가 없어요"
        noKeywordLabel.font = Fonts.font13
        noKeywordLabel.textColor = .white
        noKeywordLabel.textAlignment = .center
    }
}
