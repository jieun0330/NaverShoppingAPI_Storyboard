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
        
        deleteAll.addTarget(self, action: #selector(deleteAllClicked), for: .touchUpInside)
        
    }
    
    @objc func deleteAllClicked() {
        keywordList.removeAll()
        keywordView.reloadData()
    }
    

}

extension MainViewController {
    
    func configureUI() {
        
        let name = UserDefaults.standard.string(forKey: "Nickname")
        
        navigationItem.title = "\(name ?? "")님의 새싹쇼핑"
        searchBar.placeholder = "브랜드, 상품, 프로필 태그 등"
        keyword.text = ""
        navigationItem.backButtonTitle = ""
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if keywordList.count == 0 {
            return UIScreen.main.bounds.height
        } else {
            return 52
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: KeywordResultsTableViewCell.identifier, for: indexPath) as! KeywordResultsTableViewCell
        
        UserDefaults.standard.set(keywordList, forKey: "키워드")
        keywordView.reloadData()
        
        let vc = storyboard?.instantiateViewController(identifier: KeywordResultViewController.identifier) as! KeywordResultViewController
        vc.index = indexPath.row
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

extension MainViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        keywordList.insert(searchBar.text!, at: 0)
        UserDefaults.standard.set(keywordList, forKey: "키워드")
        keywordView.reloadData()
        
        let vc = storyboard?.instantiateViewController(identifier: KeywordResultViewController.identifier) as! KeywordResultViewController
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if keywordList.count == 0 {
            return 1
        } else {
            return keywordList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        tableView.separatorStyle = .none
        
        if keywordList.count == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: NoKeywordTableViewCell.identifier, for: indexPath) as! NoKeywordTableViewCell
            
            cell.selectionStyle = .none
            return cell
            
        } else {
            
            keyword.text = "최근 검색"
            keyword.font = Fonts.font13
            deleteAll.setTitle("모두 지우기", for: .normal)
            deleteAll.titleLabel?.font = Fonts.font13
            deleteAll.setTitleColor(Colors.pointColor, for: .normal)
            
            let cell = tableView.dequeueReusableCell(withIdentifier: KeywordResultsTableViewCell.identifier, for: indexPath) as! KeywordResultsTableViewCell
            cell.keyword.text = keywordList[indexPath.row]
            
            cell.selectionStyle = .none
            
            cell.deleteButton.tag = indexPath.row
            cell.deleteButton.addTarget(self, action: #selector(deleteButtonClicked(sender:)), for: .touchUpInside)
            
            return cell
        }
        
    }
    
    @objc func deleteButtonClicked(sender: UIButton) {
        UserDefaults.standard.removeObject(forKey: "키워드")
        keywordList.remove(at: sender.tag)
        keywordView.reloadData()
    }
    
}
