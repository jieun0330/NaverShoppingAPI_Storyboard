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

        
        for index in 0...3 {
            profileImg.image = UIImage(named: "profile\(index)")
//            
        }
        
        profileImg.contentMode = .scaleAspectFill
        profileImg.layer.masksToBounds = false
        profileImg.layer.cornerRadius = profileImg.frame.height / 2
        profileImg.clipsToBounds = true


    }

}
