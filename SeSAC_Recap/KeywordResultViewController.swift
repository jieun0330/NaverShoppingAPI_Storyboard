//
//  KeywordResultViewController.swift
//  SeSAC_Recap
//
//  Created by 박지은 on 1/20/24.
//

import UIKit
import Alamofire

class KeywordResultViewController: UIViewController {
    
    var list: Welcome = Welcome(total: 0, items: [])
    
    @IBOutlet var numberOfKeywords: UILabel!
    @IBOutlet var accuracy: UIButton!
    @IBOutlet var dateButton: UIButton!
    @IBOutlet var highPrice: UIButton!
    @IBOutlet var lowPrice: UIButton!
    @IBOutlet var resultView: UICollectionView!
    
    let item = MainViewController().keywordList
    var index: Int = 0
    var display = 30
    var sort = "sim"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        buttonType(accuracy, title: "정확도")
        buttonType(dateButton, title: "날짜순")
        buttonType(highPrice, title: "가격높은순")
        buttonType(lowPrice, title: "가격낮은순")
        
        resultView.delegate = self
        resultView.dataSource = self
        resultView.prefetchDataSource = self
        
        resultView.register(UINib(nibName: ResultCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: ResultCollectionViewCell.identifier)
        
        setLayout()
        
        let searchedKeywordList = UserDefaults.standard.array(forKey: "키워드") as? [String] ?? [""]
        navigationItem.title = searchedKeywordList[index]
        
        callRequest(text: searchedKeywordList[index])
        
    }
    
    func callRequest(text: String) {
        
        let query = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = "https://openapi.naver.com/v1/search/shop?query=\(query)&display=\(display)&sort=\(sort)"
        let headers: HTTPHeaders = [
            "X-Naver-Client-Id": APIKey.clientID,
            "X-Naver-Client-Secret": APIKey.clientSecret
        ]
        
        AF
            .request(url, method: .get, headers: headers)
            .responseDecodable(of: Welcome.self) { response in
                switch response.result {
                case .success(let success):
                    
                    if self.display == 30 {
                        self.list = success
                        
                        let numberFormatter: NumberFormatter = NumberFormatter()
                        numberFormatter.numberStyle = .decimal
                        let result: String = numberFormatter.string(for: self.list.total)!
                        self.numberOfKeywords.text = "\(result)개의 검색 결과"
                        
                    } else {
                        self.list.items.append(contentsOf: success.items)
                    }
                    
                    self.resultView.reloadData()
                    
                case .failure(let failure):
                    print(failure)
                }
            }
    }
    
    func setLayout() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 5
        let cellWidth = UIScreen.main.bounds.width - (spacing * 3)
        
        layout.itemSize = CGSize(width: cellWidth / 2, height: cellWidth / 1.5)
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
    
}

extension KeywordResultViewController:  UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        print("prefetch \(indexPaths)")
        
        for item in indexPaths {
            if list.items.count - 3 == item.row {
                
                guard let searchKeywordList = UserDefaults.standard.array(forKey: "키워드") as? [String] else { return }
                
                display += 30
                callRequest(text: searchKeywordList[index])
                
            }
        }
        
    }
    
}

extension KeywordResultViewController {
    func configureUI() {
        
        numberOfKeywords.textColor = Colors.pointColor
        numberOfKeywords.font = Fonts.font13
        
    }
    
}

extension KeywordResultViewController: UICollectionViewDataSource, UICollectionViewDelegate  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        print(list.items.count)
        return list.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResultCollectionViewCell.identifier, for: indexPath) as! ResultCollectionViewCell
        
        cell.mallName.text = list.items[indexPath.row].mallName
        cell.image.kf.setImage(with: URL(string: list.items[indexPath.row].image))
        cell.title.text = list.items[indexPath.row].title
        
        let numberFormatter: NumberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let result: String = numberFormatter.string(from: NSNumber(value: Double(list.items[indexPath.row].lprice)!))!
        
        cell.lprice.text = result
        
        return cell
    }
}


