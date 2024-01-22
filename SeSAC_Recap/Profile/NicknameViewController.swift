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
    
    let nickname = UserDefaults.standard.string(forKey: "Nickname")
    let randomNum = Int.random(in: 1...14)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImg.image = UIImage(named: "profile\(randomNum)")
        configureUI()
        
        nicknameTextField.delegate = self
        nicknameTextField.smartDashesType = .no
        nicknameTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        doneButton.addTarget(self, action: #selector(doneButtonClicked), for: .touchUpInside)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if let num = Int(UserDefaults.standard.string(forKey: "clickImg")!) {
            profileImg.image = UIImage(named: "profile\(num+1)")
        }
    }
    
    @objc func textFieldDidChange() {
        
        let num = CharacterSet(charactersIn: "0123456789")
        let char = CharacterSet(charactersIn: "#@$%")
        
        if nicknameTextField.text!.count < 2 || nicknameTextField.text!.count >= 10 {
            nicknameCondition.text = "2글자 이상 10글자 미만으로 설정해주세요"
            nicknameCondition.textColor = .red
            doneButton.isEnabled = false
        } else if ((nicknameTextField.text?.rangeOfCharacter(from: num)) != nil) {
            nicknameCondition.text = "닉네임에 숫자는 포함할 수 없어요."
            
        } else if ((nicknameTextField.text?.rangeOfCharacter(from: char)) != nil) {
            nicknameCondition.text = "닉네임에 @,#,$,%는 포함할 수 없어요."
        }
        else {
            nicknameCondition.text = ""
            doneButton.isEnabled = true
        }
    }
    
    @objc func doneButtonClicked() {
        let vc = storyboard?.instantiateViewController(identifier: MainViewController.identifier) as! MainViewController
        navigationController?.pushViewController(vc, animated: true)
        
        UserDefaults.standard.set(nicknameTextField.text, forKey: "Nickname")
    }
    
    @IBAction func imageClicked(_ sender: UITapGestureRecognizer) {
        let vc = storyboard?.instantiateViewController(identifier: SettingProfileViewController.identifier) as! SettingProfileViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func keyboardDismiss(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
        UserDefaults.standard.set(nicknameTextField.text, forKey: "Nickname")
    }
}

extension NicknameViewController {
    func configureUI() {
        navigationItem.title = "프로필 설정"
        
        profileImg.contentMode = .scaleAspectFill
        profileImg.layer.masksToBounds = false
        profileImg.layer.cornerRadius = profileImg.frame.height / 2
        profileImg.clipsToBounds = true
        profileImg.layer.borderWidth = 5
        profileImg.layer.borderColor = Colors.pointColor.cgColor
        
        cameraImg.image = .camera
        
        nicknameTextField.placeholder = "닉네임을 입력해주세요 :)"
        nicknameTextField.font = Fonts.font13
        
        nicknameCondition.textColor = Colors.pointColor
        nicknameCondition.font = Fonts.font13
        nicknameCondition.text = ""
        
        doneButton.configurePrimaryStyle(title: "완료")
        
        navigationItem.backButtonTitle = ""
        
    }
}

