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
        let textfield = UITextField()
        textfield.backgroundColor = .white
        textfield.layer.cornerRadius = 10
        textfield.layer.masksToBounds = true
        textfield.placeholder = "Введите логин SBIS.RU"
        textfield.font = UIFont(name: "HelveticaNeue-Light", size: 18)
        return textfield
    }()
    private let passwordTextfield: UITextField = {
        let textfield = UITextField()
        textfield.backgroundColor = .white
        textfield.layer.cornerRadius = 10
        textfield.layer.masksToBounds = true
        textfield.placeholder = "Введите пароль"
        textfield.font = UIFont(name: "HelveticaNeue-Light", size: 18)
        return textfield
    }()
    private lazy var authButton: UIButton =  {
        let button = UIButton(type: .system)
        button.backgroundColor = .myPurpleBold
        button.setTitle("Enter", for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 18)
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(authRequest), for: .touchUpInside)
        return button
    }()
    lazy var tipsLabel: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        return label
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
        view.backgroundColor = .myPurpleLight
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
