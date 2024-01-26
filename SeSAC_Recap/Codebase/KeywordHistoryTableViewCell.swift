//
//  KeywordHistoryTableViewCell.swift
//  SeSAC_Recap
//
//  Created by 박지은 on 1/26/24.
//

import UIKit

class KeywordHistoryTableViewCell: UITableViewCell {
    
    let searchIcon = UIButton()
    let product = UILabel()
    let deleteButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(searchIcon)
        contentView.addSubview(product)
        
        searchIcon.tintColor = .white
        
        product.textColor = .white
        
        deleteButton.tintColor = .white
        
        searchIcon.snp.makeConstraints { make in
            make.size.equalTo(20)
            make.leading.equalToSuperview().offset(20)
        }
        
        product.snp.makeConstraints { make in
            make.leading.equalTo(searchIcon.snp.trailing).offset(20)
        }
        
//        deleteButton.snp.makeConstraints { make in
//            make.trailing.equalToSuperview().offset(-20)
//        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }


}
