//
//  ResultCollectionViewCell.swift
//  SeSAC_Recap
//
//  Created by 박지은 on 1/20/24.
//

import UIKit
import Kingfisher

class ResultCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var image: UIImageView!
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var mallName: UILabel!
    @IBOutlet var title: UILabel!
    @IBOutlet var lprice: UILabel!
    

    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 20
        mallName.font = Fonts.font13
        mallName.textColor = Colors.textColor
        title.font = Fonts.font14
        lprice.font = Fonts.font15
        

        
        
        
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        likeButton.tintColor = .black
        
        
    }


}
