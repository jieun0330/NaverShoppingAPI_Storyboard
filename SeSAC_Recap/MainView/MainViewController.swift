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
    
    // 아래 탭바 구현을 Window 뭐 해야하는데 진짜 절대 못함 절대 모름
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
        keywordList.removeAll()
        keywordView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        searchBar.text = ""
    }

}

extension MainViewController {
    
    func configureUI() {
        
        let name = UserDefaults.standard.string(forKey: "Nickname")
        
        navigationItem.title = "\(name ?? "")님의 새싹쇼핑"
        searchBar.placeholder = "브랜드, 상품, 프로필 태그 등"
        keyword.text = ""
        navigationItem.backButtonTitle = ""
        navigationItem.setHidesBackButton(true, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if keywordList.count == 0 {
            // height를 이렇게 주면 안될것같긴 하지만(?), 이미지는 잘 보이는데 이 화면에선 스크롤이 없었으면 좋겠음
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
            // sender:를 쓰는건 모아나가 알려줘서 썼는데, 다시 로직 흐름을 이해해야겠다
            cell.deleteButton.addTarget(self, action: #selector(deleteButtonClicked(sender:)), for: .touchUpInside)
            
            return cell
        }
        
    }
    
    @objc func deleteButtonClicked(sender: UIButton) {
        UserDefaults.standard.removeObject(forKey: "키워드")
        // at: 다음에 뭘 써야 할지 몰라서 위에 sender:
        keywordList.remove(at: sender.tag)
        keywordView.reloadData()
    }
    
}
