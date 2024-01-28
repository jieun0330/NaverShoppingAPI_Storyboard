//
//  ProfileImageSettingCollectionViewCell.swift
//  SeSAC_Recap
//
//  Created by 박지은 on 1/28/24.
//

import UIKit

class ProfileImageSettingCollectionViewCell: UICollectionViewCell {
    
    let profileCollectionImg = UIImageView()
    
    
    // 왜 override 자동 생성 안되어있는거야
    // 직접 만들었었나 기억력 상실
    // collectionView.register 하면 나오려나? -> 아님
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // configureHierachy
        // 콜렉션뷰도 contentview해야되나????
        contentView.addSubview(profileCollectionImg)
        
        // configureView
        profileCollectionImg.contentMode = .scaleAspectFill
        profileCollectionImg.layer.masksToBounds = false
        profileCollectionImg.layer.cornerRadius = profileCollectionImg.frame.height / 4.7
        profileCollectionImg.clipsToBounds = true
        
        // configureConstraints
        profileCollectionImg.snp.makeConstraints { make in
            make.size.equalTo(200)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 이거 안쓰면 그냥 없어도 되는건가
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
