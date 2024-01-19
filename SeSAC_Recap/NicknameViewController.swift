//
//  NicknameViewController.swift
//  SeSAC_Recap
//
//  Created by 박지은 on 1/18/24.
//

import UIKit

class NicknameViewController: UIViewController {
    
    @IBOutlet var profileImg: UIImageView!
    @IBOutlet var cameraImg: UIImageView!
    @IBOutlet var nicknameTextField: UITextField!
    @IBOutlet var nicknameCondition: UILabel!
    @IBOutlet var doneButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    @IBAction func nickNameTextFieldTapped(_ sender: UITextField) {
        if sender.text!.count < 2 || sender.text!.count > 10 {
            nicknameCondition.text = "2글자 이상 10글자 미만으로 설정해주세요"
        }
    }
    
    //Mark: - image - TapGeture 연결 정리하기
    @IBAction func imageClicked(_ sender: UITapGestureRecognizer) {
        let vc = storyboard?.instantiateViewController(identifier: SettingProfileViewController.identifier) as! SettingProfileViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    

    
}

extension NicknameViewController {
    func configureUI() {
        navigationItem.title = "프로필 설정"
        
        let randomNum = Int.random(in: 1...14)
        profileImg.image = UIImage(named: "profile\(randomNum)")
        
        //Mark: - 이미지 동그랗게 하는 방법 정리하기
        //Mark: - Autolayout 개념 정리하기
        //Mark: - 이미지를 클릭했을 때 ? -> 버튼으로 바꿔야하나?
        profileImg.contentMode = .scaleAspectFill
        profileImg.layer.masksToBounds = false
        profileImg.layer.cornerRadius = profileImg.frame.height / 2
        profileImg.clipsToBounds = true
        profileImg.layer.borderWidth = 1
        //Mark: - borderColor = CGColor
        profileImg.layer.borderColor = Colors.pointColor.cgColor
        cameraImg.image = .camera
        
        nicknameTextField.placeholder = "닉네임을 입력해주세요 :)"
        nicknameTextField.font = Fonts.font13
        
        nicknameCondition.text = "닉네임에 뭐가 포함될 수 없대"
        nicknameCondition.textColor = Colors.pointColor
        nicknameCondition.font = Fonts.font13
        
        doneButton.configurePrimaryStyle(title: "완료")
        
    }
    
    
}




