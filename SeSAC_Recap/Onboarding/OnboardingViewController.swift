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
        
        // Button.addTarget과 button IBAction의 차이는?
        startButton.addTarget(self, action: #selector(startButtonClicked), for: .touchUpInside)
        configureUI()
        
    }
    
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
        
    }
}
