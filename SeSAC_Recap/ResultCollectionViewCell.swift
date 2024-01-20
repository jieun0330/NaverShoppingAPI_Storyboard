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
        
        
        
        
    }
    
    func configureCell(_ data: Welcome) {
        image.kf.setImage(with: URL(string: data.items[0].image))
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        mallName.text = data.items[0].mallName
        title.text = data.items[0].title
        lprice.text = data.items[0].lprice
    }

}
