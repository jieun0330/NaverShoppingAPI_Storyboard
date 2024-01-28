//
//  KeywordHistoryTableViewCell.swift
//  SeSAC_Recap
//
//  Created by 박지은 on 1/26/24.
//

import UIKit

class KeywordHistoryTableViewCell: UITableViewCell {
    
    let searchIcon = UIButton()
    let productName = UILabel()
    let xmarkButton = UIButton()
    
    // 3.1 Cell에 클로저 프로퍼티를 추가한다
    // ???????/왓
    var xmarkButtonAction: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // configureHierachy
        contentView.addSubview(searchIcon)
        contentView.addSubview(productName)
        contentView.addSubview(xmarkButton)
        
        //configureView
        searchIcon.tintColor = .white
        searchIcon.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        productName.textColor = Colors.textColor
        xmarkButton.tintColor = .white
        // 3.2 버튼에 추가해줄 action을 생성해준다
        xmarkButton.addTarget(self, action: #selector(xmarkButtonClicked), for: .touchUpInside)
        xmarkButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        
        //configureConstraints
        searchIcon.snp.makeConstraints { make in
            make.size.equalTo(20)
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
        }
        
        productName.snp.makeConstraints { make in
            make.leading.equalTo(searchIcon.snp.trailing).offset(20)
            make.centerY.equalToSuperview()
        }
        
        xmarkButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
        }
    }
    
    @objc func xmarkButtonClicked() {
        xmarkButtonAction?()
    }
    
    // 요건 또 무엇이고하니
    // 이게 무슨 코드를 작성해서 만들어진 코드지? 🚨🚨🚨🚨🚨
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
