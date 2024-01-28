//
//  OnboardingCodeViewController.swift
//  SeSAC_Recap
//
//  Created by 박지은 on 1/28/24.
//

import UIKit
import SnapKit

class OnboardingCodeViewController: UITabBarController {
    
    let onboardingTitle = UIImageView()
    let onboardingImg = UIImageView()
    let startButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierachy()
        configureView()
        configureConstraints()
    }
    
    func configureHierachy() {
        [onboardingTitle, onboardingImg, startButton].forEach {
            view.addSubview($0)
        }
    }
    
    func configureView() {
        onboardingTitle.image = .sesacShopping
        onboardingImg.image = .onboarding
        startButton.setTitle("시작하기", for: .normal)
        startButton.setTitleColor(Colors.textColor, for: .normal)
        startButton.backgroundColor = Colors.pointColor
        startButton.layer.cornerRadius = 10
    }
    
    func configureConstraints() {
        onboardingTitle.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(onboardingImg.snp.top).offset(-50)
        }
        
        onboardingImg.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        startButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(45)
        }
    }
}
