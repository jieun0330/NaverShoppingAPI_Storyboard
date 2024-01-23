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
    
    var list: Welcome = Welcome(total: 0, items: [])
    var productID: String = ""
    var index: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = "https://msearch.shopping.naver.com/product/\(productID)"
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            
            webView.load(request)
        }
        
        // as? 뒤에도 그리드가 알려줬는데 그리드가 안알려줬으면 한 일주일동안 붙잡고있었을듯
        let searchedKeywordList = UserDefaults.standard.array(forKey: "키워드") as? [String] ?? [""]
        navigationItem.title = searchedKeywordList[index]
        
    }
    
}
