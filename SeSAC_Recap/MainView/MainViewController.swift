//
//  MainViewController.swift
//  SeSAC_Recap
//
//  Created by 박지은 on 1/19/24.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var keyword: UILabel!
    @IBOutlet var deleteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()



    }

}

extension MainViewController {
    
    func configureUI() {
        navigationItem.title = "님의 새싹쇼핑"
        searchBar.placeholder = "브랜드, 상품, 프로필 태그 등"
        keyword.text = "최근 검색어"
        keyword.font = Fonts.font13
        deleteButton.setTitle("모두 지우기", for: .normal)
        deleteButton.titleLabel?.font = Fonts.font13
        deleteButton.setTitleColor(Colors.pointColor, for: .normal)
//        mainImg.image = .empty
//        emptyLabel.text = "최근 검색어가 없어요"
//        emptyLabel.textAlignment = .center
//        navigationController?.navigationBar.isHidden = true
//        MainViewController.separator
        

        
    }
}
