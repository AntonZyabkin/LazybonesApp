//
//  ComingDetailsViewController.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 26.10.2022.
//

import UIKit
import WebKit

protocol WebPageViewControllerProtocol {
    
}

final class WebPageViewController: UIViewController {

    let webView = WKWebView()
    let activityIndicator = UIActivityIndicatorView()
     
    var urlString = "https://online.sbis.ru/shared/disk/9a36ee65-fd08-4792-8a1e-fa48353ab733"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        openWebPage(from: urlString)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        webView.frame = view.bounds
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
    }
    
    
    func openWebPage(from url: String) {
        guard let url = URL(string: url) else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
