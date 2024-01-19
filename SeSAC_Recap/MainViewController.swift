//
//  MainViewController.swift
//  SeSAC_Recap
//
//  Created by 박지은 on 1/19/24.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var mainImg: UIImageView!
    @IBOutlet var emptyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()



    }

}

extension MainViewController {
    
    func configureUI() {
        navigationItem.title = "님의 새싹쇼핑"
        searchBar.placeholder = "브랜드, 상품, 프로필 태그 등"
        mainImg.image = .empty
        emptyLabel.text = "최근 검색어가 없어요"
        emptyLabel.textAlignment = .center
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.isHidden = true

        
    }
}
