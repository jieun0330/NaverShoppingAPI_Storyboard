//
//  SettingViewController.swift
//  SeSAC_Recap
//
//  Created by 박지은 on 1/20/24.
//

import UIKit

enum Setting: CaseIterable {
    case setting
    
    var title: [String] {
        switch self {
        case .setting:
            return ["공지사항", "자주 묻는 질문", "1:1 문의", "알림 설정", "처음부터 시작하기"]
        }
    }
}

class SettingViewController: UIViewController {
    
    @IBOutlet var settingView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureView()
        settingView.delegate = self
        settingView.dataSource = self
        
    }
}

extension SettingViewController {
    func configureUI() {
        navigationItem.title = "설정"
    }
    
    func configureView() {
        let xib = UINib(nibName: NicknameTableViewCell.identifier, bundle: nil)
        settingView.register(xib, forCellReuseIdentifier: NicknameTableViewCell.identifier)
        
        let xib2 = UINib(nibName: SettingTableViewCell.identifier, bundle: nil)
        settingView.register(xib2, forCellReuseIdentifier: SettingTableViewCell.identifier)
    }
}


extension SettingViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 5
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: NicknameTableViewCell.identifier, for: indexPath) as! NicknameTableViewCell
            
            return cell
        } else {
            let cell2 = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier, for: indexPath) as! SettingTableViewCell
            
            cell2.setting.text = Setting.setting.title[indexPath.row]
            
            return cell2
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 80
        } else {
            return 50
        }
    }
    
}
