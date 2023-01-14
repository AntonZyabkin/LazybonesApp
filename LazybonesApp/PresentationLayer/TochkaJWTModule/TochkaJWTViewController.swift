//
//  TochkaJWTViewController.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 26.11.2022.
//

import UIKit

//MARK: - PROTOCOLS
protocol TochkaJWTViewControllerProtocol: UIViewController {
    var jwtTextField: UITextField { get }
    var clientIdTextField: UITextField { get }
    var tipsLabel: UILabel { get }
}

final class TochkaJWTViewController: UIViewController {
    //MARK: - PROPERTIES
    var presenter: TochkaJWTViewPresenterProtocol?
    lazy var jwtTextField: UITextField = {
        var textField = UITextField()
        textField.placeholderRect(forBounds: CGRect(x: 20, y: 0, width: 0, height: 0))
        textField.backgroundColor = .white
        textField.placeholder = "Введине JWT"
        textField.layer.cornerRadius = 10
        textField.layer.masksToBounds = true
        textField.frame.size.height = 100
        return textField
    }()
    
    lazy var clientIdTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.placeholder = "Введите clientId"
        textField.layer.cornerRadius = 10
        textField.layer.masksToBounds = true
        return textField
    }()
    
    lazy var tipsLabel: UILabel = {
        var label = UILabel()
        label.sizeToFit()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.text = " "
        return label
    }()
    
    private lazy var checkAndSaveJWTButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.myPurpleBold
        button.setTitle("Check and save JWT and clientId", for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 22)
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        return button
    }()
    
    private lazy var jwtInfoButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .myGreenText
        button.setTitle("Where to find JWT", for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 22)
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        return button
    }()
    
    private lazy var  tochkaJWTStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [jwtTextField, clientIdTextField, tipsLabel, checkAndSaveJWTButton, jwtInfoButton])
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    //MARK: - METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .myPurpleLight
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(tochkaJWTStackView)
        tochkaJWTStackView.translatesAutoresizingMaskIntoConstraints = false
        checkAndSaveJWTButton.addTarget(nil, action: #selector(checkAndSaveJWTButtonDidPressed), for: .touchUpInside)
        jwtInfoButton.addTarget(nil, action: #selector(jwtInfoButtonDidPressed), for: .touchUpInside)

        NSLayoutConstraint.activate([
            tochkaJWTStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 128),
            tochkaJWTStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tochkaJWTStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:  -16),
            tochkaJWTStackView.heightAnchor.constraint(equalToConstant: 400),
            jwtTextField.heightAnchor.constraint(equalToConstant: 120)
        ])
    }

    @objc
    private func checkAndSaveJWTButtonDidPressed() {
        presenter?.checkAndSaveJWTButtonDidPressed()
        tipsLabel.text = " "
    }
    
    @objc
    private func jwtInfoButtonDidPressed() {
        presenter?.jwtInfoButtonDidPressed()
    }
}

//MARK: - EXTENSIONS
extension TochkaJWTViewController: TochkaJWTViewControllerProtocol {
    
}
