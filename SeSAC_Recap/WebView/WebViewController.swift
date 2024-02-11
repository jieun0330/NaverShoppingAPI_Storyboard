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
        
        navigationItem.title = productTitle

        let urlString = "https://msearch.shopping.naver.com/product/\(productID)"
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            
            webView.load(request)
        }
    }
}
