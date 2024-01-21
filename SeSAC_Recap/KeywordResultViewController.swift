//
//  KeywordResultViewController.swift
//  SeSAC_Recap
//
//  Created by 박지은 on 1/20/24.
//

import UIKit
import Alamofire

class KeywordResultViewController: UIViewController {
    
    var list: Welcome = Welcome(items: [])

    @IBOutlet var numberOfKeywords: UILabel!
    @IBOutlet var accuracy: UIButton!
    @IBOutlet var dateButton: UIButton!
    @IBOutlet var highPrice: UIButton!
    @IBOutlet var lowPrice: UIButton!
    @IBOutlet var resultView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        print(list.items)
        
        callRequest(text: "캠핑카")
//        print(list.items[0].mallName)

        configureUI()
        buttonType(accuracy, title: "정확도")
        buttonType(dateButton, title: "날짜순")
        buttonType(highPrice, title: "가격높은순")
        buttonType(lowPrice, title: "가격낮은순")

        
        resultView.delegate = self
        resultView.dataSource = self
//        resultView.prefetchDataSource = self
        resultView.register(UINib(nibName: ResultCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: ResultCollectionViewCell.identifier)
        

        setLayout()
        

    }
    
    func setLayout() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 5
        let cellWidth = UIScreen.main.bounds.width - (spacing * 3)
        
//        layout.itemSize = CGSize(width: cellWidth / 2.5, height: cellWidth / 2.5)
        layout.itemSize = CGSize(width: cellWidth / 2.4, height: cellWidth / 1.5)

        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        resultView.collectionViewLayout = layout
    }
    
    
    func buttonType(_ sender: UIButton, title: String) {
        sender.contentEdgeInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        sender.setTitle(title, for: .normal)
        sender.setTitleColor(Colors.textColor, for: .normal)
        sender.layer.borderColor = Colors.textColor.cgColor
        sender.layer.borderWidth = 1
        sender.layer.cornerRadius = 10
    }

    func callRequest(text: String) {
        
        let query = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let url = "https://openapi.naver.com/v1/search/shop?query=%EC%BA%A0%ED%95%91%EC%B9%B4"
        
        let headers: HTTPHeaders = [
            "X-Naver-Client-Id": APIKey.clientID,
            "X-Naver-Client-Secret": APIKey.clientSecret
        ]
        
        AF
            .request(url, method: .get, headers: headers)
            .responseDecodable(of: Welcome.self) { response in
                switch response.result {
                case .success(let success):
//                    print("success")
                    self.list = success
                    
                    self.resultView.reloadData()
                    
                    
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
        
//        print(indexPath.row)
        cell.mallName.text = list.items[indexPath.row].mallName
        cell.image.kf.setImage(with: URL(string: list.items[indexPath.row].image))
        cell.title.text = list.items[indexPath.row].title
        cell.lprice.text = list.items[indexPath.row].lprice
        
        
        
       
        
        return cell
    }
    
    
}


