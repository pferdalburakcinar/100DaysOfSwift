//
//  webVikiViewController.swift
//  Project16
//
//  Created by ecinar on 14.07.2021.
//

import UIKit
import WebKit

class webVikiViewController: UIViewController, WKNavigationDelegate{
    
    var websiteUrlString: String!
    var webView: WKWebView!
    
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
        let url = URL(string: "https://en.wikipedia.org/wiki/" + websiteUrlString!)
        
        webView.load(URLRequest(url: url!))
        webView.allowsBackForwardNavigationGestures = true
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
