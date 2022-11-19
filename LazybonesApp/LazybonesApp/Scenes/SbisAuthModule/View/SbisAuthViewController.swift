//
//  SbisAuthViewController.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 11.11.2022.
//

import UIKit


protocol SbisAuthViewProtocol: UIViewController {
    func showErrorMessage(_ message: String)
}


final class SbisAuthViewController: UIViewController {
    
    var presenter: SbisAuthPresenterProtocol?
    
    private let loginTextfield = UITextField()
    private let passwordTextfield = UITextField()
    private let tipsLabel = UILabel()
    private var authButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        configureLoginTextfield()
        configurePasswordTextfield()
        configureAuthButton()
        configureTipsLabel()
    }
    
    private func configureLoginTextfield() {
        view.addSubview(loginTextfield)
        loginTextfield.backgroundColor = .systemGray2
        loginTextfield.layer.cornerRadius = 10
        loginTextfield.layer.masksToBounds = true
        loginTextfield.placeholder = "Enter Sbis login"
        
        loginTextfield.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height/5).isActive = true
        loginTextfield.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/10).isActive = true
        loginTextfield.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/10).isActive = true
        loginTextfield.heightAnchor.constraint(equalToConstant: 45).isActive = true
        loginTextfield.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configurePasswordTextfield() {
        view.addSubview(passwordTextfield)
        passwordTextfield.backgroundColor = .systemGray2
        passwordTextfield.layer.cornerRadius = 10
        passwordTextfield.layer.masksToBounds = true
        passwordTextfield.placeholder = "Enter password"
        
        passwordTextfield.topAnchor.constraint(equalTo: loginTextfield.bottomAnchor, constant: view.frame.height/40).isActive = true
        passwordTextfield.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/10).isActive = true
        passwordTextfield.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/10).isActive = true
        passwordTextfield.heightAnchor.constraint(equalToConstant: 45).isActive = true
        passwordTextfield.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureAuthButton() {
        view.addSubview(authButton)
        authButton.backgroundColor = #colorLiteral(red: 0.08571257442, green: 0.110325627, blue: 0.7462227941, alpha: 1)
        authButton.setTitle("Enter", for: .normal)
        authButton.layer.cornerRadius = 10
        authButton.layer.masksToBounds = true
        authButton.addTarget(self, action: #selector(authRequest), for: .touchUpInside)
        
        authButton.topAnchor.constraint(equalTo: passwordTextfield.bottomAnchor, constant: view.frame.height/20).isActive = true
        authButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/10).isActive = true
        authButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/10).isActive = true
        authButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        authButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureTipsLabel() {
        view.addSubview(tipsLabel)
        tipsLabel.sizeToFit()
        tipsLabel.numberOfLines = 0
        tipsLabel.lineBreakMode = .byWordWrapping
        
        tipsLabel.bottomAnchor.constraint(equalTo: authButton.topAnchor).isActive = true
        tipsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/10).isActive = true
        tipsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/10).isActive = true
        tipsLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        tipsLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc func authRequest() {
        guard let login = loginTextfield.text, let password = passwordTextfield.text else {
            print("Enter login and/or password")
            return
        }
        presenter?.authButtonDidPressed(login, password)
        animateView(authButton)
    }
    
    fileprivate func animateView (_ viewToAnimate : UIView) {
        UIView.animate(withDuration: 0.05, delay: 0, usingSpringWithDamping: 20, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
            viewToAnimate.transform = CGAffineTransform (scaleX: 0.95, y: 0.95)
        }) { (_) in
            UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 2, options: .curveEaseIn, animations: {
                viewToAnimate.transform = CGAffineTransform (scaleX: 1, y: 1)
            }, completion: nil)
        }
    }
}


extension SbisAuthViewController: SbisAuthViewProtocol {
    func showErrorMessage(_ error: String) {
        tipsLabel.text = error
    }
}
