//
//  KeywordResultViewController.swift
//  SeSAC_Recap
//
//  Created by 박지은 on 1/20/24.
//

import UIKit
import Alamofire

class KeywordResultViewController: UIViewController {

    var list: Welcome = Welcome(total: 50, items: [])

    @IBOutlet var numberOfKeywords: UILabel!
    @IBOutlet var accuracy: UIButton!
    @IBOutlet var dateButton: UIButton!
    @IBOutlet var highPrice: UIButton!
    @IBOutlet var lowPrice: UIButton!
    @IBOutlet var resultView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        buttonType(accuracy, title: "정확도")
        buttonType(dateButton, title: "날짜순")
        buttonType(highPrice, title: "가격높은순")
        buttonType(lowPrice, title: "가격낮은순")

        
        resultView.delegate = self
        resultView.dataSource = self
//        resultView.prefetchDataSource = self
        resultView.register(UINib(nibName: ResultCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: ResultCollectionViewCell.identifier)
        


    }
    
    func buttonType(_ sender: UIButton, title: String) {
        sender.contentEdgeInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        sender.setTitle(title, for: .normal)
        sender.setTitleColor(Colors.textColor, for: .normal)
        sender.layer.borderColor = Colors.textColor.cgColor
        sender.layer.borderWidth = 1
        sender.layer.cornerRadius = 10
    }

    func callRequest() {
        let url = "https://openapi.naver.com/v1/search/shop?query=%EC%BA%A0%ED%95%91%EC%B9%B4"
        
        AF
            .request(url, method: .get)
            .responseDecodable(of: Welcome.self) { response in
                switch response.result {
                case .success(let success):
                    print(success)
                case .failure(let failure):
                    print(failure)
                }
            }
        
    }

}
extension KeywordResultViewController {
    func configureUI() {
        
        navigationItem.title = "캠핑카"
        numberOfKeywords.text = "00개의 검색 결과"
        numberOfKeywords.textColor = Colors.pointColor
        numberOfKeywords.font = Fonts.font13

        
    }
    

}


extension KeywordResultViewController: UICollectionViewDataSource, UICollectionViewDelegate  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return list.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResultCollectionViewCell.identifier, for: indexPath) as! ResultCollectionViewCell
        
        return cell
    }
}

