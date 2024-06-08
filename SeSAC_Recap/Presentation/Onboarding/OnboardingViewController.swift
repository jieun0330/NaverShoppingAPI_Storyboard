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
        
        configureUI()
        startButton.addTarget(self, action: #selector(startButtonClicked), for: .touchUpInside)
    }
    
    func configureUI() {
        
        sesacShopping.image = .sesacShopping
        mainImg.image = .onboarding
        startButton.configureButtonPrimaryStyle(title: "시작하기")
        
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = .white
    }
    
    @objc func startButtonClicked() {
        let vc = storyboard?.instantiateViewController(identifier: NicknameViewController.identifier) as! NicknameViewController
        navigationController?.pushViewController(vc, animated: true)
    }
}
