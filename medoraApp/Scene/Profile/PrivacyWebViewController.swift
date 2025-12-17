//
//  PrivacyWebViewController.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 18.12.25.
//

import UIKit
import WebKit

class PrivacyWebViewController: BaseController {
    
    private lazy var webView: WKWebView = {
        let view = WKWebView(frame: view.bounds)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configUI() {
        self.title = "Privacy & Security"
        view.addSubview(webView)
        if let url = URL(string: "https://gist.githubusercontent.com/NazrinAsgarova7/ef7440cd0a8c01254a07bcbc2e7cd452/raw/9133e8294c101922044eaeccbe16332f810a47ff/privacy.html") {
            
            URLSession.shared.dataTask(with: url) { data, _, error in
                guard let data, error == nil else { return }
                DispatchQueue.main.async {
                    self.webView.load(
                        data,
                        mimeType: "text/html",
                        characterEncodingName: "utf-8",
                        baseURL: url.deletingLastPathComponent()
                    )
                }
            }.resume()
        }
    }
}
