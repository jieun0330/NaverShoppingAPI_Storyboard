//
//  NicknameViewController.swift
//  SeSAC_Recap
//
//  Created by 박지은 on 1/18/24.
//

import UIKit

class NicknameViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var profileImg: UIImageView!
    @IBOutlet var cameraImg: UIImageView!
    @IBOutlet var nicknameTextField: UITextField!
    @IBOutlet var nicknameCondition: UILabel!
    @IBOutlet var doneButton: UIButton!
    
    let randomNum = Int.random(in: 1...14)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
    }
    
    func configureUI() {
        
        navigationItem.title = "프로필 설정"
        
        UserDefaultManager.shared.profileImg = randomNum
        profileImg.image = UIImage(named: "profile\(UserDefaultManager.shared.profileImg)")
        configureProfileImage(profileImg)
        
        cameraImg.image = .camera
        
        nicknameTextField.placeholder = "닉네임을 입력해주세요 :)"
        nicknameTextField.font = Fonts.font13
        UserDefaultManager.shared.nickname = nicknameTextField.text!
        
        nicknameCondition.textColor = UIColor.pointColor
        nicknameCondition.font = Fonts.font13
        nicknameCondition.text = ""
        nicknameTextField.delegate = self
        nicknameTextField.smartDashesType = .no
        nicknameTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        doneButton.configureButtonPrimaryStyle(title: "완료")
        doneButton.addTarget(self, action: #selector(doneButtonClicked), for: .touchUpInside)
        doneButton.isEnabled = false
        
        navigationItem.backButtonTitle = ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        profileImg.image = UIImage(named: "profile\(UserDefaultManager.shared.profileImg)")
    }
    
    @objc func textFieldDidChange(_ sender: UITextField, condition: UILabel, done: UIButton) {
        
        let num = CharacterSet(charactersIn: "0123456789")
        let char = CharacterSet(charactersIn: "#@$%")
        
        if sender.text!.count < 2 || sender.text!.count >= 10 {
            condition.text = "2글자 이상 10글자 미만으로 설정해주세요"
            condition.textColor = .red
            done.isEnabled = false
        } else if ((sender.text?.rangeOfCharacter(from: num)) != nil) {
            condition.text = "닉네임에 숫자는 포함할 수 없어요."
        } else if ((sender.text?.rangeOfCharacter(from: char)) != nil) {
            condition.text = "닉네임에 @,#,$,%는 포함할 수 없어요."
        } else {
            condition.text = ""
            done.isEnabled = true
        }
    }
    
    @objc func doneButtonClicked() {
        
        UserDefaults.standard.setValue(true, forKey: "UserState")
        
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "mainTabBarController") as! UITabBarController
        
        sceneDelegate?.window?.rootViewController = vc
        sceneDelegate?.window?.makeKeyAndVisible()
    }
    
    @IBAction func profileImageClicked(_ sender: UITapGestureRecognizer) {
        let vc = storyboard?.instantiateViewController(identifier: SettingProfileViewController.identifier) as! SettingProfileViewController
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func keyboardDismiss(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}
