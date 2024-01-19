//
//  NicknameViewController.swift
//  SeSAC_Recap
//
//  Created by 박지은 on 1/18/24.
//

import UIKit
import TextFieldEffects

class NicknameViewController: UIViewController {

    @IBOutlet var profileImg: UIImageView!
    @IBOutlet var cameraImg: UIImageView!
    @IBOutlet var nicknameTextField: IsaoTextField!
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
        
        let randomNum = Int.random(in: 1...14)
        profileImg.image = UIImage(named: "profile\(randomNum)")
        
        profileImg.contentMode = .scaleAspectFill
        profileImg.layer.masksToBounds = false
        profileImg.layer.cornerRadius = profileImg.frame.height / 2
        profileImg.clipsToBounds = true
        profileImg.layer.borderWidth = 1
//        profileImg.layer.borderColor =
        cameraImg.image = .camera
        
        nicknameTextField.placeholder = "닉네임을 입력해주세요 :)"
        nicknameTextField.font = Fonts.font13
        
        nicknameCondition.text = "닉네임에 뭐가 포함될 수 없대"
        nicknameCondition.textColor = Colors.pointColor
        nicknameCondition.font = Fonts.font13
        
        doneButton.setTitle("완료", for: .normal)
        doneButton.backgroundColor = Colors.pointColor
        doneButton.layer.cornerRadius = 12
        doneButton.setTitleColor(Colors.textColor, for: .normal)
        doneButton.titleLabel?.font = Fonts.font13


    }
}




