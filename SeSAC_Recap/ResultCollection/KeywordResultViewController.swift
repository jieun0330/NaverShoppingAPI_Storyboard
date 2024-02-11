//
//  KeywordResultViewController.swift
//  SeSAC_Recap
//
//  Created by 박지은 on 1/20/24.
//

import UIKit
import Alamofire

class KeywordResultViewController: UIViewController {
    
    var list: Products = Products(total: 0, items: [])
    
    @IBOutlet var numberOfKeywords: UILabel!
    @IBOutlet var accuracy: UIButton!
    @IBOutlet var dateButton: UIButton!
    @IBOutlet var highPrice: UIButton!
    @IBOutlet var lowPrice: UIButton!
    @IBOutlet var resultView: UICollectionView!
    
    var index: Int = 0
    var display = 30
    var start = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
        resultView.delegate = self
        resultView.dataSource = self
        resultView.prefetchDataSource = self
        resultView.register(UINib(nibName: ResultCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: ResultCollectionViewCell.identifier)
        
        setLayout()
        
//        let searchedKeywordList = UserDefaults.standard.array(forKey: "키워드") as? [String] ?? [""]
        // [index]가 아닌 다른 방법이 있는지 찾아보자
//        navigationItem.title = searchedKeywordList[index]
        
        accuracyClicked(accuracy)
        // 아 왜 검정글씨 안보여
        accuracy.setTitleColor(.black, for: .normal)
        
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = .white
 
        buttonType(accuracy, title: "정확도")
        buttonType(dateButton, title: "날짜순")
        buttonType(highPrice, title: "가격높은순")
        buttonType(lowPrice, title: "가격낮은순")
    }
    
    func setButtonOff(sender: UIButton) {
        sender.backgroundColor = .black
        sender.setTitleColor(.white, for: .normal)
    }
    
    func setButtonOn(sender: UIButton) {
        sender.backgroundColor = .white
        sender.setTitleColor(.black, for: .normal)
    }
    
    func buttonClicked() {
        setButtonOff(sender: accuracy)
        setButtonOff(sender: dateButton)
        setButtonOff(sender: lowPrice)
        setButtonOff(sender: highPrice)
    }
    
    @IBAction func accuracyClicked(_ sender: UIButton) {
        
        let searchedKeywordList = UserDefaultManager.shared.keywords
        callRequest(text: searchedKeywordList[index], sort: "sim")
        
        buttonClicked()
        setButtonOn(sender: sender)
//        sender.setTitleColor(.black, for: .normal)
    }
    
    @IBAction func dateClicked(_ sender: UIButton) {
        let searchedKeywordList = UserDefaults.standard.array(forKey: "키워드") as? [String] ?? [""]
        callRequest(text: searchedKeywordList[index], sort: "date")
        
        buttonClicked()
        setButtonOn(sender: sender)
    }
    
    @IBAction func highPriceClicked(_ sender: UIButton) {
        let searchedKeywordList = UserDefaults.standard.array(forKey: "키워드") as? [String] ?? [""]
        callRequest(text: searchedKeywordList[index], sort: "dsc")
        
        buttonClicked()
        setButtonOn(sender: sender)
    }
    
    @IBAction func lowPriceClicked(_ sender: UIButton) {
        let searchedKeywordList = UserDefaults.standard.array(forKey: "키워드") as? [String] ?? [""]
        callRequest(text: searchedKeywordList[index], sort: "asc")
        
        buttonClicked()
        setButtonOn(sender: sender)
    }
    
    
    func callRequest(text: String, sort: String) {
        
        let query = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = "https://openapi.naver.com/v1/search/shop?query=\(query)&display=\(display)&sort=\(sort)&start=\(start)"
        let headers: HTTPHeaders = [
            "X-Naver-Client-Id": APIKey.clientID,
            "X-Naver-Client-Secret": APIKey.clientSecret
        ]
        
        AF
            .request(url, method: .get, headers: headers)
            .responseDecodable(of: Products.self) { response in
                switch response.result {
                case .success(let success):
                    
                    if self.start == 1 {
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
        // 아직 UICollectionViewFlowLayout이 무슨 역할을 하는지 모름
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
        sender.setTitleColor(UIColor.textColor, for: .normal)
        sender.layer.borderColor = UIColor.textColor.cgColor
        sender.layer.borderWidth = 1
        sender.layer.cornerRadius = 10
    }
}

extension KeywordResultViewController:  UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
        for item in indexPaths {
            if list.items.count - 3 == item.row {
                
                let searchKeywordList = UserDefaultManager.shared.keywords
                
//                start += display
                start += 30
                callRequest(text: searchKeywordList[index], sort: "sim")
            }
        }
    }
}

extension KeywordResultViewController {
    func configureUI() {
        
        numberOfKeywords.textColor = UIColor.pointColor
        numberOfKeywords.font = Fonts.font13
        
    }
}

extension KeywordResultViewController: UICollectionViewDataSource, UICollectionViewDelegate  {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: WebViewController.identifier) as! WebViewController
        vc.productID = list.items[indexPath.row].productID
        
        // push와 present와 pop을 구분해서 알아둬야 할 것 지은아
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return list.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResultCollectionViewCell.identifier, for: indexPath) as! ResultCollectionViewCell
        let row = indexPath.row
        let product = list.items[row]
        
        cell.mallName.text = product.mallName
        cell.image.kf.setImage(with: URL(string: product.image))
        // 두줄 구현 못함
        // 상품명에 <b> 삭제 못함
        cell.title.text = product.title
        
        let numberFormatter: NumberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let result: String = numberFormatter.string(from: NSNumber(value: Double(product.lprice)!))!
        
        cell.lprice.text = result
        cell.likeButton.setImage(UIImage(systemName: UserDefaultManager.shared.likes.contains(product.productID) ? "heart.fill" : "heart"), for: .normal)
        cell.likeButton.tag = row
        cell.likeButton.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)
        
        return cell
    }
    
    @objc func likeButtonClicked(sender: UIButton) {
        let product = list.items[sender.tag]
        
        if let index = UserDefaultManager.shared.likes.firstIndex(of: product.productID) {
            UserDefaultManager.shared.likes.remove(at: index)
        } else {
            UserDefaultManager.shared.likes.append(product.productID)
        }
        
        resultView.reloadData()
    }
}


