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
    var likeNum = 0
    var start = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        // 버튼 클릭 효과 구현 못함
        // 상품 하트 구현 못함
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
        // [index]가 아닌 다른 방법이 있는지 찾아보고싶다
        navigationItem.title = searchedKeywordList[index]
        
        callRequest(text: searchedKeywordList[index], sort: "sim")
        
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = .white
        
    }
    
    @IBAction func accurayClicked(_ sender: UIButton) {
        let searchedKeywordList = UserDefaults.standard.array(forKey: "키워드") as? [String] ?? [""]
        callRequest(text: searchedKeywordList[index], sort: "sim")
        
        sender.backgroundColor = .white
        sender.setTitleColor(.black, for: .normal)
    }
    
    @IBAction func dateClicked(_ sender: UIButton) {
        let searchedKeywordList = UserDefaults.standard.array(forKey: "키워드") as? [String] ?? [""]
        callRequest(text: searchedKeywordList[index], sort: "date")
        
        sender.backgroundColor = .white
        sender.setTitleColor(.black, for: .normal)
    }
    
    @IBAction func highPriceClicked(_ sender: UIButton) {
        let searchedKeywordList = UserDefaults.standard.array(forKey: "키워드") as? [String] ?? [""]
        callRequest(text: searchedKeywordList[index], sort: "dsc")
        
        sender.backgroundColor = .white
        sender.setTitleColor(.black, for: .normal)
    }
    
    @IBAction func lowPriceClicked(_ sender: UIButton) {
        let searchedKeywordList = UserDefaults.standard.array(forKey: "키워드") as? [String] ?? [""]
        callRequest(text: searchedKeywordList[index], sort: "asc")
        
        sender.backgroundColor = .white
        sender.setTitleColor(.black, for: .normal)
    }
    
    
    func callRequest(text: String, sort: String) {
        
        print("1", start)
        let query = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = "https://openapi.naver.com/v1/search/shop?query=\(query)&display=\(display)&sort=\(sort)&start=\(start)"
        let headers: HTTPHeaders = [
            "X-Naver-Client-Id": APIKey.clientID,
            "X-Naver-Client-Secret": APIKey.clientSecret
        ]
        
        AF
            .request(url, method: .get, headers: headers)
            .responseDecodable(of: Welcome.self) { response in
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
        sender.setTitleColor(Colors.textColor, for: .normal)
        sender.layer.borderColor = Colors.textColor.cgColor
        sender.layer.borderWidth = 1
        sender.layer.cornerRadius = 10
    }
    
}

extension KeywordResultViewController:  UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
        for item in indexPaths {
            if list.items.count - 3 == item.row {
                
                // as!와 as?의 역할을 잘 모름
                guard let searchKeywordList = UserDefaults.standard.array(forKey: "키워드") as? [String] else { return }

                start += 30
                callRequest(text: searchKeywordList[index], sort: "sim")
            
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
        
        cell.mallName.text = list.items[indexPath.row].mallName
        cell.image.kf.setImage(with: URL(string: list.items[indexPath.row].image))
        // 두줄 구현 못함
        // 상품명에 <b> 삭제 못함
        cell.title.text = list.items[indexPath.row].title
        
        let numberFormatter: NumberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let result: String = numberFormatter.string(from: NSNumber(value: Double(list.items[indexPath.row].lprice)!))!
        
        cell.lprice.text = result
        
        cell.likeButton.addTarget(self, action: #selector(likeButtonClicked(sender:)), for: .touchUpInside)
        
        return cell
    }
    
    @objc func likeButtonClicked(sender: UIButton) {
        sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        UserDefaultManager.shared.likeNum.append(list.items[sender.tag].productID)
        resultView.reloadData()
    }
}


