//
//  NicknameViewController.swift
//  SeSAC_Recap
//
//  Created by 박지은 on 1/18/24.
//

import UIKit

class NicknameViewController: UIViewController {

    @IBOutlet var profileImg: UIImageView!
    @IBOutlet var nicknameTextField: UITextField!
    @IBOutlet var nicknameCondition: UILabel!
    @IBOutlet var doneButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }

}

extension NicknameViewController {
    func configureUI() {
        navigationItem.title = "프로필 설정"
        
        // 2. 프로필 이미지 랜덤으로 가져오기
        let randomNum = Int.random(in: 1...14)
        profileImg.image = UIImage(named: "profile\(randomNum)")
//        profileImg.image =
//        emotionButton[tagNum].setImage(UIImage(named: "slime\(tagNum+1)"), for: .normal)

    }
}



// 인스펙터 지정하고 -> outlet 연결하기

