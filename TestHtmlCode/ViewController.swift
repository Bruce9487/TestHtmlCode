//
//  ViewController.swift
//  TestHtmlCode
//
//  Created by Bruce Chen on 2019/3/4.
//  Copyright © 2019 APP技術部-陳冠志. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    @IBOutlet weak var webview: WKWebView!
    
    let data = "<p>親愛的用戶你好</p><p>您還有證券帳戶未申請手機存摺，歡迎您參考以下資訊並洽往來證券商申辦手機存摺服務！</p><br><p>申辦活動好康：</p><a href=\"https://epassbook.tdcc.com.tw/\">https://epassbook.tdcc.com.tw/</a><br><br><p>可以申辦手機存摺帳戶：</p><p>戶數：1戶</p><p>帳戶列表：</p><p>您的往來證券商　　　聯絡電話</p><p>尚達證券信義分公司　<a href=\"tel:02-22335566\">02-22335566</a></p>"
    
    let data2 = "<!DOCTYPE html><html lang=\"en\"><head><meta charset=\"UTF-8\"><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"><meta http-equiv=\"X-UA-Compatible\" content=\"ie=edge\"><title>Document</title><style>body, p {margin: 0px;}p {padding: 0px 5px;}</style></head><body><p>親愛的用戶你好</p><p style=\"text-indent: 2em\">您還有證券帳戶未申請手機存摺，歡迎您參考以下資訊並洽往來證券商申辦手機存摺服務！</p><br><p>申辦活動好康：</p><p><a href=\"https://epassbook.tdcc.com.tw/\">https://epassbook.tdcc.com.tw/</a></p><br><p>可以申辦手機存摺帳戶：</p><p>戶數：1戶</p><p>帳戶列表：</p><div style=\"display:flex;\"><p style=\"flex: 0; flex-basis: 180px;\">您的往來證券商</p><p style=\"flex: 1;\">聯絡電話</p></div><div style=\"display:flex;\"><p style=\"flex: 0; flex-basis: 180px;\">尚達證券信義分公司　</p><p style=\"flex: 1;\"><a href=\"tel:02-22335566\">02-22335566</a></p></div></body></html>"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webview.navigationDelegate = self

        webview.loadHTMLString(data2, baseURL: Bundle.main.bundleURL)
    }
}

extension ViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Swift.Void) {
        
        if navigationAction.navigationType == .linkActivated {
         
            if let url = navigationAction.request.url {
                UIApplication.shared.open(url)
                decisionHandler(.cancel)
            } else {
                decisionHandler(.allow)
            }
        } else {
            if navigationAction.request.url?.scheme == "tel" {
                UIApplication.shared.open(navigationAction.request.url!)
                decisionHandler(.cancel)
            } else {
                decisionHandler(.allow)
            }
        }
    }
    
}

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}

