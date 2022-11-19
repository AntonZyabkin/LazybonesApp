//
//  PaymentViewController.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 25.10.2022.
//

import UIKit

protocol PaymentViewProtocol {
    
}
final class PaymentViewController: UIViewController {

    var presenter: PaymentViewPresenterProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        presenter?.viewDidLoad()
    }
}


extension PaymentViewController: PaymentViewProtocol {
    
}
