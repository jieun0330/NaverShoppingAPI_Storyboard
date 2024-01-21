//
//  MainViewController.swift
//  SeSAC_Recap
//
//  Created by 박지은 on 1/19/24.
//

import UIKit
import Alamofire

class MainViewController: UIViewController {
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var keyword: UILabel!
    @IBOutlet var deleteButton: UIButton!
    @IBOutlet var keywordView: UITableView!
    
    var list: Welcome = Welcome(items: [])
    var keywordList: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        searchBar.delegate = self
        keywordView.delegate = self
        keywordView.dataSource = self
        let xib = UINib(nibName: KeywordResultsTableViewCell.identifier, bundle: nil)
        keywordView.register(xib, forCellReuseIdentifier: KeywordResultsTableViewCell.identifier)
        
        let xib2 = UINib(nibName: NoKeywordTableViewCell.identifier, bundle: nil)
        keywordView.register(xib2, forCellReuseIdentifier: NoKeywordTableViewCell.identifier)

    }
    

    
    func callRequest(text: String) {
        
        let query = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = "https://openapi.naver.com/v1/search/shop?query=\(query)"
        let headers: HTTPHeaders = [
            "X-Naver-Client-Id": APIKey.clientID,
            "X-Naver-Client-Secret": APIKey.clientSecret
        ]
        
        AF
            .request(url, method: .get, headers: headers)
            .responseDecodable(of: Welcome.self) { response in
                switch response.result {
                case .success(let success):
                    self.list = success
                    print(success)
                    
                case .failure(let failure):
                    print(failure)
                }
            }
    }
//    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            keywordList.remove(at: indexPath.row)
//            keywordView.reloadData()
//        }
//    }
    
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
        
    }
}

extension MainViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        keywordList.append(searchBar.text!)
//        self.keywordView.endUpdates()
//        keywordView.endUpdates()
        keywordView.reloadData()
        searchBar.text = ""
    }
}


extension MainViewController: UITableViewDataSource, UITableViewDelegate  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return keywordList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: KeywordResultsTableViewCell.identifier, for: indexPath) as! KeywordResultsTableViewCell
        cell.keyword.text = keywordList[indexPath.row]
        
        cell.selectionStyle = .none
        
        return cell
    }
}
