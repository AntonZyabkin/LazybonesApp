//
//  ComingDetailsViewController.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 26.10.2022.
//

import UIKit
import WebKit

protocol ComingDetailsViewControllerProtocol {
    
}

class ComingDetailsViewController: UIViewController {

    let webView = WKWebView()
    let activityIndicator = UIActivityIndicatorView()
     
//    var urlTest = "https://www.orimi.com/pdf-test.pdf"
    var urlTest = "https://online.sbis.ru/shared/disk/9a36ee65-fd08-4792-8a1e-fa48353ab733"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        openPDFFile(urlTest)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        webView.frame = view.bounds
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
    }
    
    
    func openPDFFile(_ filePath: String) {
        guard let url = URL(string: filePath) else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
