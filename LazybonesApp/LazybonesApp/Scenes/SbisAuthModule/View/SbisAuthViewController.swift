//
//  SbisAuthViewController.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 11.11.2022.
//

import UIKit


protocol SbisAuthViewProtocol: UIViewController {
    func showErrorAlert(_ error: Error)
}


final class SbisAuthViewController: UIViewController {
    
    var presenter: SbisAuthPresenterProtocol?
    
    private let loginTextfield = UITextField()
    private let passwordTextfield = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureLoginTextfield()
        view.backgroundColor = .white
    }
    
    private func configureLoginTextfield() {
        view.addSubview(loginTextfield)
        loginTextfield.frame = CGRect (x: 50, y: 300, width: 400, height: 50)
        loginTextfield.backgroundColor = .red
    }
}


extension SbisAuthViewController: SbisAuthViewProtocol {
    func showErrorAlert(_ error: Error) {
        print(error.localizedDescription)
    }
}
