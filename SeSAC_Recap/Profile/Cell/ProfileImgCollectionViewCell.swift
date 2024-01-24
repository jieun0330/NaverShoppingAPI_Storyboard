//
//  ProfileImgCollectionViewCell.swift
//  SeSAC_Recap
//
//  Created by 박지은 on 1/19/24.
//

import UIKit

class ProfileImgCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var profileImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUI()

    }
}

extension ProfileImgCollectionViewCell {
    func configureUI() {
        
        profileImg.contentMode = .scaleAspectFill
        profileImg.layer.masksToBounds = false
        profileImg.layer.cornerRadius = profileImg.frame.height / 4.7
        profileImg.clipsToBounds = true
    
    }
}
