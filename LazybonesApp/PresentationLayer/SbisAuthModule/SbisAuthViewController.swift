//
//  SbisAuthViewController.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 11.11.2022.
//

import UIKit


protocol SbisAuthViewProtocol: UIViewController {
    func showErrorMessage(_ message: String)
    func showAuthData(login: String, password: String)
}

class SbisAuthViewController: UIViewController {
    var presenter: SbisAuthPresenterProtocol?
    //TODO: как изменить приватное свойство в дочернем класе
    var loginTextfield: UITextField = {
        let loginTextfield = UITextField()
        loginTextfield.backgroundColor = .white
        loginTextfield.layer.cornerRadius = 10
        loginTextfield.layer.masksToBounds = true
        loginTextfield.placeholder = "Введите логин SBIS.RU"
        loginTextfield.font = UIFont(name: "HelveticaNeue-Light", size: 18)
        return loginTextfield
    }()
    
    private let passwordTextfield: UITextField = {
        let passwordTextfield = UITextField()
        passwordTextfield.backgroundColor = .white
        passwordTextfield.layer.cornerRadius = 10
        passwordTextfield.layer.masksToBounds = true
        passwordTextfield.placeholder = "Введите пароль"
        passwordTextfield.font = UIFont(name: "HelveticaNeue-Light", size: 18)
        return passwordTextfield
    }()
    
    private lazy var authButton: UIButton =  {
        let authButton = UIButton(type: .system)
        authButton.backgroundColor = .tochkaPurpleAccent
        authButton.setTitle("Enter", for: .normal)
        authButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 18)
        authButton.tintColor = .white
        authButton.layer.cornerRadius = 10
        authButton.layer.masksToBounds = true
        authButton.addTarget(self, action: #selector(authRequest), for: .touchUpInside)
        return authButton
    }()

    lazy var tipsLabel: UILabel = {
        let tipsLabel = UILabel()
        tipsLabel.sizeToFit()
        tipsLabel.numberOfLines = 0
        tipsLabel.lineBreakMode = .byWordWrapping
        tipsLabel.textAlignment = .center
        return tipsLabel
    }()
    
    private lazy var authViewsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [loginTextfield, passwordTextfield, tipsLabel, authButton])
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    //MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewWasLoaded()
        view.backgroundColor = .tochkaPurpleBackground
        configureView()
    }
    
    @objc
    func authRequest() {
        guard let login = loginTextfield.text, let password = passwordTextfield.text else {
            tipsLabel.text = "Enter login and/or password"
            return
        }
        tipsLabel.text = " "
        presenter?.authButtonDidPressed(login, password)
    }
    
    private func configureView() {
        view.addSubview(authViewsStackView)

        authViewsStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 128).isActive = true
        authViewsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        authViewsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        authViewsStackView.heightAnchor.constraint(equalToConstant: 256).isActive = true
        authViewsStackView.translatesAutoresizingMaskIntoConstraints = false
    }
}

extension SbisAuthViewController: SbisAuthViewProtocol {
    func showErrorMessage(_ error: String) {
        tipsLabel.text = error
    }
    
    func showAuthData(login: String, password: String) {
        loginTextfield.text = login
        passwordTextfield.text = password
    }
}
