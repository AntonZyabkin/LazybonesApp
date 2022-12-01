//
//  PaymentViewController.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 25.10.2022.
//

import UIKit

protocol PaymentViewProtocol: UIViewController {
    
}
final class PaymentViewController: UIViewController {

    var presenter: PaymentViewPresenterProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter?.viewDidLoad()
    }
}


extension PaymentViewController: PaymentViewProtocol {
    
}
