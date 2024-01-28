//
//  NickcnameSettingViewController.swift
//  SeSAC_Recap
//
//  Created by 박지은 on 1/28/24.
//

import UIKit
import SnapKit

class NickcnameSettingViewController: UIViewController {
    
    let profileImg = UIImageView()
    let cameraImg = UIImageView()
    let nicknameTextField = UITextField()
    let divider = UIView()
    let nicknameCondition = UILabel()
    let doneButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "프로필 설정"
        
        configureHierachy()
        configureView()
        configureConstraints()
    }
    
    func configureHierachy() {
        
        // 스토리보드 없이 레이아웃을 구성할 때, 뷰 위에 다른 뷰를 추가하는 경우 addSubview()를 써준다
        // 이런 방법이?
        // 그냥 단순히 $0 요 자리에 넣어주는 foreach의 역할이라고 한다 ㅇㅋㅇㅋ 많이 쓰다보면 알겠지 🚨
        [profileImg, cameraImg, nicknameTextField, divider, nicknameCondition, doneButton].forEach {
            view.addSubview($0)
        }
    }
    
    func configureView() {
        profileImg.layer.borderWidth = 5
        profileImg.layer.borderColor = Colors.pointColor.cgColor
        profileImg.image = .profile1
        profileImg.contentMode = .scaleAspectFill
        // 아래 size 35주면 반영이 안되나 ? ? ? 숫자로 줘야되나 ? ? ? ?🚨🚨🚨🚨🚨
        //        profileImg.layer.cornerRadius = profileImg.frame.height / 2
        profileImg.layer.cornerRadius = 40
        profileImg.clipsToBounds = true
        
        cameraImg.image = .camera
        
        nicknameTextField.placeholder = "닉네임을 입력해주세요 :)"
        nicknameTextField.font = Fonts.font13
        
        // 홀리몰리~ tintColor가 아니라 backgroundColor로 줘야 나옴 지은아
        divider.backgroundColor = .white
        
        nicknameCondition.text = "닉네임 조건"
        nicknameCondition.font = Fonts.font13
        nicknameCondition.textColor = Colors.pointColor
        
        doneButton.setTitle("완료", for: .normal)
        doneButton.setTitleColor(Colors.textColor, for: .normal)
        doneButton.backgroundColor = Colors.pointColor
        doneButton.layer.cornerRadius = 5
    }
    
    func configureConstraints() {
        profileImg.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.size.equalTo(80)
        }
        
        cameraImg.snp.makeConstraints { make in
            make.size.equalTo(35)
            make.trailing.equalTo(profileImg).offset(5)
            make.bottom.equalTo(profileImg).offset(5)
        }
        
        nicknameTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(profileImg.snp.bottom).offset(20)
        }
        
        divider.snp.makeConstraints { make in
            // 홀리몰리~2 height만 주고 width값 안주니까 안보이지 몽총아~
            make.width.equalTo(nicknameTextField.snp.width)
            make.height.equalTo(1)
            make.top.equalTo(nicknameTextField.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(nicknameTextField)
        }
        
        nicknameCondition.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.top.equalTo(divider.snp.bottom).offset(20)
        }
        
        doneButton.snp.makeConstraints { make in
            // 얘도 다른애들이랑 똑같이 줬는데 왜 한쪽으로 쏠림? 희하헎나허네~
            // 수업시간엔 되던게 혼자 하면 안되는 힇핞한 현실~
            // 홀리몰리~3 inset으로 줘야함~
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(45)
            make.top.equalTo(nicknameCondition.snp.bottom).offset(20)
        }
    }
}
