//
//  OnboardingViewController.swift
//  SeSAC_Recap
//
//  Created by 박지은 on 1/18/24.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    @IBOutlet var sesacShopping: UIImageView!
    @IBOutlet var mainImg: UIImageView!
    @IBOutlet var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Mark: - 버튼 addtarget 개념 정리하기
        startButton.addTarget(self, action: #selector(startButtonClicked), for: .touchUpInside)
        configureUI()

        
    }
    
    //Mark: - 화면 전환, push, present 개념 정리하기
    //Mark: - 타입캐스팅 개념 정리하기
    //Mark: - identifier와 withIdentifier 차이 정리하기
    @objc func startButtonClicked() {
        let vc = storyboard?.instantiateViewController(identifier: NicknameViewController.identifier) as! NicknameViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension OnboardingViewController {
    func configureUI() {
        sesacShopping.image = .sesacShopping
        mainImg.image = .onboarding
        
        startButton.configurePrimaryStyle(title: "시작하기")

        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = .white
        //Mark: - 아래 코드 왜 안되는지 확인하기
//        navigationItem.backBarButtonItem?.tintColor = .white
    
        
    }
}

//Mark: - Completion Handler, Instance, Property, Method, 연산 프로퍼티, 저장 프로퍼티 개념 정리하기
