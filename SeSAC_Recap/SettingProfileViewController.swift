//
//  SettingProfileViewController.swift
//  SeSAC_Recap
//
//  Created by 박지은 on 1/19/24.
//

import UIKit

class SettingProfileViewController: UIViewController {

    @IBOutlet var profileImg: UIImageView!
    @IBOutlet var images: [UIImageView]!
    
    var test: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
        for index in 0...3 {
            images[index].image = UIImage(named: "profile\(index)")
            
            images[index].contentMode = .scaleAspectFit
        }

        
        
//        let randomNum = Int.random(in: 1...14)
//        profileImg.image = UIImage(named: "profile\(randomNum)")
        
    }

    
}

extension SettingProfileViewController {
    func configureUI() {
        navigationItem.title = "프로필 설정"
        
        profileImg.contentMode = .scaleAspectFill
        profileImg.layer.masksToBounds = false
        profileImg.layer.cornerRadius = profileImg.frame.height / 2
        profileImg.clipsToBounds = true
        profileImg.layer.borderWidth = 5
        profileImg.layer.borderColor = Colors.pointColor.cgColor
//        images[2].image.content
        
        
    }
}
