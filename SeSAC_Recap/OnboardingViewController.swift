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

    }
}

extension OnboardingViewController {
    func configureUI() {
        sesacShopping.image = .sesacShopping
        mainImg.image = .onboarding
        startButton.setTitle("시작하기", for: .normal)
        startButton.backgroundColor = Colors.pointColor
        startButton.layer.cornerRadius = 12
        startButton.setTitleColor(Colors.textColor, for: .normal)
        startButton.titleLabel?.font = Fonts.font13
    }
}
