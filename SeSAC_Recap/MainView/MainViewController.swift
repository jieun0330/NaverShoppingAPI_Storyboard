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
    
    var list: Products = Products(total: 0, items: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
    }
    
    func configureUI() {
        
        navigationItem.title = "\(UserDefaultManager.shared.nickname)님의 새싹쇼핑"
        navigationItem.backButtonTitle = ""
        navigationItem.setHidesBackButton(true, animated: true)
        
        searchBar.placeholder = "브랜드, 상품, 프로필 태그 등"
        searchBar.delegate = self
        keywordView.delegate = self
        keywordView.dataSource = self
        keyword.text = ""
        
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

extension MainViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        UserDefaultManager.shared.keywords.insert(searchBar.text!, at: 0)
        keywordView.reloadData()
        
        let vc = storyboard?.instantiateViewController(identifier: KeywordResultViewController.identifier) as! KeywordResultViewController
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
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
            tableView.isUserInteractionEnabled = false
            
            return cell
            
        } else {
            tableView.isUserInteractionEnabled = true
            
            keyword.text = "최근 검색"
            keyword.font = Fonts.font13
            deleteAll.setTitle("모두 지우기", for: .normal)
            deleteAll.titleLabel?.font = Fonts.font13
            deleteAll.setTitleColor(UIColor.pointColor, for: .normal)
            
            let cell = tableView.dequeueReusableCell(withIdentifier: KeywordResultsTableViewCell.identifier, for: indexPath) as! KeywordResultsTableViewCell
            cell.keyword.text = UserDefaultManager.shared.keywords[indexPath.row]
            cell.selectionStyle = .none
            cell.deleteButton.tag = indexPath.row
            cell.deleteButton.addTarget(self, action: #selector(deleteButtonClicked(_:)), for: .touchUpInside)
            
            return cell
        }
    }
    
    @objc func deleteButtonClicked(_ sender: UIButton) {
        UserDefaultManager.shared.keywords.remove(at: sender.tag)
        keywordView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if UserDefaultManager.shared.keywords.count == 0 {
            return 300
        } else {
            return 52
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: KeywordResultsTableViewCell.identifier, for: indexPath) as! KeywordResultsTableViewCell
        
        keywordView.reloadData()
        
        let vc = storyboard?.instantiateViewController(identifier: KeywordResultViewController.identifier) as! KeywordResultViewController
        vc.index = indexPath.row
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
