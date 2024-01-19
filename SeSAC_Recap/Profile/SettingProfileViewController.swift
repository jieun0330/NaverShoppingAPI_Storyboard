//
//  SettingProfileViewController.swift
//  SeSAC_Recap
//
//  Created by 박지은 on 1/19/24.
//

import UIKit

class SettingProfileViewController: UIViewController {

    

    @IBOutlet var profileImg: UIImageView!
    @IBOutlet var profileListView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureView()
        setLayout()


        
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
            
    }
    
    func configureView() {
        
        profileListView.delegate = self
        profileListView.dataSource = self
        
        let xib = UINib(nibName: ProfileImgCollectionViewCell.identifier, bundle: nil)
        profileListView.register(xib, forCellWithReuseIdentifier: ProfileImgCollectionViewCell.identifier)
    }
   
    func setLayout() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 10
        let cellWidth = UIScreen.main.bounds.width - (spacing * 5)
        
        layout.itemSize = CGSize(width: cellWidth / 2.5, height: cellWidth / 1.7)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        profileListView.collectionViewLayout = layout
    }

}


extension SettingProfileViewController: UICollectionViewDataSource, UICollectionViewDelegate  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 14
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileImgCollectionViewCell.identifier, for: indexPath)
        
        return cell
    }
    
}
