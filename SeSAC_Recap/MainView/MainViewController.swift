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
    @IBOutlet var deleteAll: UIButton!
    @IBOutlet var keywordView: UITableView!
    
    var list: Welcome = Welcome(total: 0, items: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
        // delegate는 viewDidLoad에 있어야되는건가? 아님 extension쪽으로 빼도 되는건가?
        // searchBar 위아래 라인 지워야함
        searchBar.delegate = self
        keywordView.delegate = self
        keywordView.dataSource = self
        
        let xib = UINib(nibName: KeywordResultsTableViewCell.identifier, bundle: nil)
        keywordView.register(xib, forCellReuseIdentifier: KeywordResultsTableViewCell.identifier)
        
        let xib2 = UINib(nibName: NoKeywordTableViewCell.identifier, bundle: nil)
        keywordView.register(xib2, forCellReuseIdentifier: NoKeywordTableViewCell.identifier)
        
        deleteAll.addTarget(self, action: #selector(deleteAllClicked), for: .touchUpInside)
    }
    
    @objc func deleteAllClicked() {
        UserDefaultManager.shared.keywords.removeAll()
        keywordView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        searchBar.text = ""
    }
}

extension MainViewController {
    
    func configureUI() {
        
        let name = UserDefaultManager.shared.nickname
        
        
        navigationItem.title = "\(name)님의 새싹쇼핑"
        searchBar.placeholder = "브랜드, 상품, 프로필 태그 등"
        keyword.text = ""
        navigationItem.backButtonTitle = ""
        navigationItem.setHidesBackButton(true, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if UserDefaultManager.shared.keywords.count == 0 {
            // 스크롤 없애기
            return 300
        } else {
            return 52
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: KeywordResultsTableViewCell.identifier, for: indexPath) as! KeywordResultsTableViewCell
        
        UserDefaults.standard.set(UserDefaultManager.shared.keywords, forKey: "키워드")
        keywordView.reloadData()
        
        let vc = storyboard?.instantiateViewController(identifier: KeywordResultViewController.identifier) as! KeywordResultViewController
        vc.index = indexPath.row
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension MainViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        UserDefaultManager.shared.keywords.insert(searchBar.text!, at: 0)
        UserDefaults.standard.set(UserDefaultManager.shared.keywords, forKey: "키워드")
        keywordView.reloadData()
        
        let vc = storyboard?.instantiateViewController(identifier: KeywordResultViewController.identifier) as! KeywordResultViewController
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(UserDefaultManager.shared.keywords.count)
        
        if UserDefaultManager.shared.keywords.count == 0 {
            return 1
        } else {
            return UserDefaultManager.shared.keywords.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        tableView.separatorStyle = .none
        
        if UserDefaultManager.shared.keywords.count == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: NoKeywordTableViewCell.identifier, for: indexPath) as! NoKeywordTableViewCell
            
            cell.selectionStyle = .none
            return cell
            
        } else {
            
            keyword.text = "최근 검색"
            keyword.font = Fonts.font13
            deleteAll.setTitle("모두 지우기", for: .normal)
            deleteAll.titleLabel?.font = Fonts.font13
            deleteAll.setTitleColor(UIColor.pointColor, for: .normal)
            
            let cell = tableView.dequeueReusableCell(withIdentifier: KeywordResultsTableViewCell.identifier, for: indexPath) as! KeywordResultsTableViewCell
            cell.keyword.text = UserDefaultManager.shared.keywords[indexPath.row]
            
            cell.selectionStyle = .none
            
            cell.deleteButton.tag = indexPath.row
            // sender:를 쓰는건 모아나가 알려줘서 썼는데, 다시 로직 흐름을 이해해야겠다
            cell.deleteButton.addTarget(self, action: #selector(deleteButtonClicked(sender:)), for: .touchUpInside)
            
            return cell
        }
    }
    
    @objc func deleteButtonClicked(sender: UIButton) {
        UserDefaults.standard.removeObject(forKey: "키워드")
        // at: 다음에 뭘 써야 할지 몰라서 위에 sender:
        UserDefaultManager.shared.keywords.remove(at: sender.tag)
        keywordView.reloadData()
    }
}
