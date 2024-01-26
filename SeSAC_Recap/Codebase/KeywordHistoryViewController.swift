//
//  KeywordHistoryViewController.swift
//  SeSAC_Recap
//
//  Created by 박지은 on 1/26/24.
//

import UIKit
import SnapKit

class KeywordHistoryViewController: UIViewController {
    
    let searchBar = UISearchBar()
    let keyword = UILabel()
    let deleteAll = UILabel()
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        navigationItem.title = "떠나고싶은 고래밥님의 새싹쇼핑"
        
        configureHierachy()
        configureView()
        configureConstraints()
    }
    
    func configureHierachy() {
        view.addSubview(searchBar)
        view.addSubview(keyword)
        view.addSubview(deleteAll)
        view.addSubview(tableView)
    }
    
    func configureView() {
        searchBar.placeholder = "브랜드, 상품, 프로필, 태그 등"
        
        keyword.text = "최근 검색"
        keyword.textColor = Colors.textColor
        
        deleteAll.text = "모두 지우기"
        deleteAll.textColor = Colors.pointColor
        
        tableView.delegate = self
        tableView.dataSource = self
        // 
        tableView.register(KeywordHistoryTableViewCell.self, forCellReuseIdentifier: "KeywordHistoryTableViewCell")
        tableView.backgroundColor = .black
        tableView.rowHeight = 60
    }
    
    func configureConstraints() {
        searchBar.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.width.equalTo(300)
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        
        keyword.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(10)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(10)
        }
        
        deleteAll.snp.makeConstraints { make in
            make.top.equalTo(keyword)
            make.trailing.equalTo(view.safeAreaInsets).offset(-10)
        }
        
        tableView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(keyword.snp.bottom).offset(20)
            make.bottom.equalToSuperview()
        }
    }
}

extension KeywordHistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "KeywordHistoryTableViewCell", for: indexPath) as! KeywordHistoryTableViewCell
        
        cell.searchIcon.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        cell.backgroundColor = .black
        cell.product.text = "맥북 거치대"
        // 왜 얘만 쓰면 죽냐
//        cell.deleteButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        
        return cell
    }
}

//#Preview {
//    KeywordHistoryViewController()
//}
