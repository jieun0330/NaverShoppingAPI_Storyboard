//
//  SettingViewController.swift
//  SeSAC_Recap
//
//  Created by 박지은 on 1/20/24.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet var profileImg: UIImageView!
    @IBOutlet var id: UILabel!
    @IBOutlet var numberOfProduct: UILabel!
    @IBOutlet var likeLabel: UILabel!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
}

extension SettingViewController {
    func configureUI() {
        navigationItem.title = "설정"
        
//        profileImg.image = .profile1
//        UserDefaults.standard.string(forKey: "Nickname")
        guard let profile = UserDefaults.standard.string(forKey: "Nickname") else { return }
        profileImg.image = UIImage(named: profile)
        profileImg.contentMode = .scaleAspectFill
        profileImg.layer.masksToBounds = false
        profileImg.layer.cornerRadius = profileImg.frame.height / 2
        profileImg.clipsToBounds = true
        profileImg.layer.borderWidth = 3
        profileImg.layer.borderColor = Colors.pointColor.cgColor
        
        id.text = "아이디"
        id.font = Fonts.font13
        
        numberOfProduct.text = "00개의 상품"
        numberOfProduct.textColor = Colors.pointColor
        
        likeLabel.text = "을 좋아하고 있어요!"
 
    }
}
