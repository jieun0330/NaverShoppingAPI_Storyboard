//
//  KeywordResultViewController.swift
//  SeSAC_Recap
//
//  Created by 박지은 on 1/20/24.
//

import UIKit
import Alamofire

class ResultViewController: UIViewController {
    
    @IBOutlet var numberOfKeywords: UILabel!
    @IBOutlet var accuracyButton: UIButton!
    @IBOutlet var dateButton: UIButton!
    @IBOutlet var highPriceButton: UIButton!
    @IBOutlet var lowPriceButton: UIButton!
    @IBOutlet var resultView: UICollectionView!
    
    var list: Products = Products(total: 0, items: [])
    
    let searchedKeywordList = UserDefaultManager.shared.keywords
    
    var index: Int = 0
    var display = 30
    var start = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        setLayout()
        accuracyClicked(accuracyButton)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        resultView.reloadData()
    }
    
    func configureUI() {
        
        let searchedKeywordList = UserDefaultManager.shared.keywords
        navigationItem.title = searchedKeywordList[index]
        
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = .white
        
        numberOfKeywords.textColor = UIColor.pointColor
        numberOfKeywords.font = Fonts.font13
        
        resultView.delegate = self
        resultView.dataSource = self
        resultView.prefetchDataSource = self
        resultView.register(UINib(nibName: ResultCollectionViewCell.identifier, bundle: nil),
                            forCellWithReuseIdentifier: ResultCollectionViewCell.identifier)
        
        accuracyButton.setTitleColor(.black, for: .normal)
        
        buttonType(accuracyButton, title: "정확도")
        buttonType(dateButton, title: "날짜순")
        buttonType(highPriceButton, title: "가격높은순")
        buttonType(lowPriceButton, title: "가격낮은순")
    }
    
    // 좋아요 버튼
    func setButtonOff(sender: UIButton) {
        sender.backgroundColor = .black
        sender.setTitleColor(.white, for: .normal)
    }
    
    func setButtonOn(sender: UIButton) {
        sender.backgroundColor = .white
        sender.setTitleColor(.black, for: .normal)
    }
    
    func buttonClicked() {
        setButtonOff(sender: accuracyButton)
        setButtonOff(sender: dateButton)
        setButtonOff(sender: lowPriceButton)
        setButtonOff(sender: highPriceButton)
    }
    
    // 정확도
    @IBAction func accuracyClicked(_ sender: UIButton) {
        sortButtonClicked(sort: .sim, sender: accuracyButton)
    }
    
    // 날짜순
    @IBAction func dateClicked(_ sender: UIButton) {
        sortButtonClicked(sort: .date, sender: dateButton)
    }
    
    // 가격높은순
    @IBAction func highPriceClicked(_ sender: UIButton) {
        sortButtonClicked(sort: .dsc, sender: highPriceButton)
    }
    
    // 가격낮은순
    @IBAction func lowPriceClicked(_ sender: UIButton) {
        sortButtonClicked(sort: .asc, sender: lowPriceButton)
    }
    
    func sortButtonClicked(sort: SortType, sender: UIButton) {
        //        callRequest(text: searchedKeywordList[index], sort: sort.rawValue)
        
        Task {
            let result = try await fetchProductAsyncAwait(text: searchedKeywordList[index],
                                                          sort: sort.rawValue)
            self.list = result
            
            let resultCount = NumberFormatManager.shared.numberFormat(number: self.list.total)
            self.numberOfKeywords.text = "\(resultCount)개의 검색 결과"
            
            self.resultView.reloadData()
        }
        
        buttonClicked()
        setButtonOn(sender: sender)
    }
    
    func setLayout() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 5
        let cellWidth = UIScreen.main.bounds.width - (spacing * 3)
        
        layout.itemSize = CGSize(width: cellWidth / 2, height: cellWidth / 1.5)
        layout.sectionInset = UIEdgeInsets(top: spacing,
                                           left: spacing,
                                           bottom: spacing,
                                           right: spacing)
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
    
    //    func callRequest(text: String, sort: String) {
    //
    //        let query = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    //        let url = "https://openapi.naver.com/v1/search/shop?query=\(query)&display=\(display)&sort=\(sort)&start=\(start)"
    //        let headers: HTTPHeaders = [
    //            "X-Naver-Client-Id": APIKey.clientID,
    //            "X-Naver-Client-Secret": APIKey.clientSecret
    //        ]
    //
    //        AF
    //            .request(url, method: .get, headers: headers)
    //            .responseDecodable(of: Products.self) { response in
    //                switch response.result {
    //                case .success(let success):
    //
    //                    if self.start == 1 {
    //                        self.list = success
    //
    //                        let result = NumberFormatManager.shared.numberFormat(number: self.list.total)
    //                        self.numberOfKeywords.text = "\(result)개의 검색 결과"
    //
    //                    } else {
    //                        self.list.items.append(contentsOf: success.items)
    //                    }
    //                    self.resultView.reloadData()
    //
    //                case .failure(let failure):
    //                    print(failure)
    //                }
    //            }
    //    }
    
    func fetchProductAsyncAwait(text: String, sort: String) async throws -> Products {
        
        let query = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let urlString = "https://openapi.naver.com/v1/search/shop?query=\(query)&display=\(display)&sort=\(sort)&start=\(start)"
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(APIKey.clientID, forHTTPHeaderField: "X-Naver-Client-Id")
        request.setValue(APIKey.clientSecret, forHTTPHeaderField: "X-Naver-Client-Secret")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw APIError.invalidResponse
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .useDefaultKeys // 내가 정한걸로 해! , camelcase -> 대문자를 만날때마다 앞에 언더바를 넣어줌
        
        let result = try decoder.decode(Products.self, from: data)
        return result
    }
    
}

extension ResultViewController:  UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView,
                        prefetchItemsAt indexPaths: [IndexPath]) {
        
        for item in indexPaths {
            if list.items.count - 3 == item.row {
                
                let searchKeywordList = UserDefaultManager.shared.keywords
                
                start += 30
                
                Task {
                    let result = try await fetchProductAsyncAwait(text: searchedKeywordList[index], sort: "sim")
                    self.list.items.append(contentsOf: result.items)
                    self.resultView.reloadData()
                }
            }
        }
    }
}

extension ResultViewController: UICollectionViewDataSource, UICollectionViewDelegate  {
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: WebViewController.identifier) as! WebViewController
        let productTitle = list.items[indexPath.item].title.replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "</b>", with: "")
        
        vc.productID = list.items[indexPath.row].productID
        vc.productTitle = productTitle
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return list.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResultCollectionViewCell.identifier,
                                                      for: indexPath) as! ResultCollectionViewCell
        let product = list.items[indexPath.row]
        let productTitle = list.items[indexPath.item].title.replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "</b>", with: "")
        
        cell.mallName.text = product.mallName
        cell.image.kf.setImage(with: URL(string: product.image))
        cell.productDetail.text = productTitle
        
        let result = NumberFormatManager.shared.numberFormat(number: Double(product.lprice)!)
        cell.lprice.text = result
        
        cell.likeButton.setImage(UIImage(systemName: UserDefaultManager.shared.likes.contains(product.productID) ? "heart.fill" : "heart"), for: .normal)
        cell.likeButton.tag = indexPath.row
        cell.likeButton.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)
        
        return cell
    }
    
    @objc func likeButtonClicked(sender: UIButton) {
        let product = list.items[sender.tag]
        
        // 만약 product의 product가 likes의 포함되어있으면
        if let index = UserDefaultManager.shared.likes.firstIndex(of: product.productID) {
            // 지우고
            UserDefaultManager.shared.likes.remove(at: index)
            // 없으면
        } else {
            // 추가해줘라
            UserDefaultManager.shared.likes.append(product.productID)
        }
        resultView.reloadData()
    }
}


