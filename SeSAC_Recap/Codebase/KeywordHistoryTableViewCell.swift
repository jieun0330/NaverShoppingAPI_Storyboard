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
    let xmarkButton = UIButton()
    
    // ???????/왓
    var xmarkButtonAction: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // configureHierachy
        contentView.addSubview(searchIcon)
        contentView.addSubview(product)
        contentView.addSubview(xmarkButton)
        
        //configureView
        searchIcon.tintColor = .white
        product.textColor = .white
        xmarkButton.tintColor = .white
        // 3.2 버튼에 추가해줄 action을 생성해준다
        xmarkButton.addTarget(self, action: #selector(xmarkButtonClicked), for: .touchUpInside)
        
        //configureConstraints
        searchIcon.snp.makeConstraints { make in
            make.size.equalTo(20)
            make.leading.equalToSuperview().offset(20)
        }
        
        product.snp.makeConstraints { make in
            make.leading.equalTo(searchIcon.snp.trailing).offset(20)
        }
        
        xmarkButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    
    @objc func xmarkButtonClicked() {
        xmarkButtonAction?()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
