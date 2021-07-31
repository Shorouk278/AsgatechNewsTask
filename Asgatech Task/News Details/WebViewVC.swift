//
//  WebViewVC.swift
//  Asgatech Task
//
//  Created by Shorouk Mohamed on 7/31/21.
//  Copyright © 2021 Shorouk Mohamed. All rights reserved.
//

import UIKit
import WebKit
import KRProgressHUD

class WebViewVC: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var webView: WKWebView!
    
    // MARK:- Var and Objects
    var urlString = "https://www.google.com"
    // MARK:- Events
    override func viewDidLoad() {
        super.viewDidLoad()
        showIndicator()
        let url = URL(string: urlString)
        let urlRequest = URLRequest(url: url!)
        webView.navigationDelegate = self
        webView.load(urlRequest)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        hideIndicator()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        hideIndicator()
        showAlert(view: self, message: "Sorry,There is a problem in loading source.")
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        hideIndicator()
        showAlert(view: self, message: "The Internet connection appears to be offline.")
    }
    
    
    
}







