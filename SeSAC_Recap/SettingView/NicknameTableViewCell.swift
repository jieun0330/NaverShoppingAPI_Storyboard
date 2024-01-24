//
//  NicknameTableViewCell.swift
//  SeSAC_Recap
//
//  Created by 박지은 on 1/24/24.
//

import UIKit

class NicknameTableViewCell: UITableViewCell {
    
    @IBOutlet var profileImg: UIImageView!
    @IBOutlet var nickname: UILabel!
    @IBOutlet var numberOfProducts: UILabel!
    @IBOutlet var likeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        profileImg.image = UIImage(named: "profile\(UserDefaults.standard.integer(forKey: "clickImg"))")
        profileImg.contentMode = .scaleAspectFill
        profileImg.layer.masksToBounds = false
        profileImg.layer.cornerRadius = profileImg.frame.height / 2.7
        profileImg.clipsToBounds = true
        profileImg.layer.borderWidth = 4
        profileImg.layer.borderColor = Colors.pointColor.cgColor
        
        nickname.text = UserDefaults.standard.string(forKey: "Nickname")
        nickname.font = Fonts.font15
        
        numberOfProducts.textColor = Colors.pointColor
        numberOfProducts.font = Fonts.font13
        
        likeLabel.text = "을 좋아하고 있어요!"
        likeLabel.font = Fonts.font13
    }
    
}
