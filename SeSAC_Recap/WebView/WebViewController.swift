//
//  WebViewController.swift
//  SeSAC_Recap
//
//  Created by 박지은 on 1/22/24.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    @IBOutlet var webView: WKWebView!
    
    var list: Products = Products(total: 0, items: [])
    var productID: String = ""
    var index: Int = 0
    var productTitle: String = "물품 타이틀 받을 공간"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    func configureView() {
        let button = UIBarButtonItem(image: UIImage(systemName: UserDefaultManager.shared.likes.contains(productID) ? "heart.fill" : "heart"), style: .plain, target: self, action: #selector(rightBarButtonItemClicked))
        
        navigationItem.title = productTitle
        navigationItem.rightBarButtonItem = button
        
        let urlString = "https://msearch.shopping.naver.com/product/\(productID)"
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            
            webView.load(request)
        }
    }
    
    @objc func rightBarButtonItemClicked() {
        
        if let index = UserDefaultManager.shared.likes.firstIndex(of: productID) {
            UserDefaultManager.shared.likes.remove(at: index)
        } else {
            UserDefaultManager.shared.likes.append(productID)
        }
        configureView()
    }
}
