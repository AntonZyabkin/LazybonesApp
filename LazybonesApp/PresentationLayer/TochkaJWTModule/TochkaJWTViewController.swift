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
        var jwtTextField = UITextField()
        jwtTextField.placeholderRect(forBounds: CGRect(x: 20, y: 0, width: 0, height: 0))
        jwtTextField.backgroundColor = .white
        jwtTextField.placeholder = "Введине JWT"
        jwtTextField.layer.cornerRadius = 10
        jwtTextField.layer.masksToBounds = true
        jwtTextField.frame.size.height = 100
        return jwtTextField
    }()
    
    lazy var clientIdTextField: UITextField = {
        let clientIdTextField = UITextField()
        clientIdTextField.backgroundColor = .white
        clientIdTextField.placeholder = "Введите clientId"
        clientIdTextField.layer.cornerRadius = 10
        clientIdTextField.layer.masksToBounds = true
        return clientIdTextField
    }()
    
    lazy var tipsLabel: UILabel = {
        var tipsLabel = UILabel()
        tipsLabel.sizeToFit()
        tipsLabel.numberOfLines = 0
        tipsLabel.lineBreakMode = .byWordWrapping
        tipsLabel.text = " "
        return tipsLabel
    }()
    
    private let checkAndSaveJWTButton: UIButton = {
        let checkAndSaveJWTButton = UIButton(type: .system)
        checkAndSaveJWTButton.backgroundColor = UIColor.tochkaPurpleAccent
        checkAndSaveJWTButton.setTitle("Check and save JWT and clientId", for: .normal)
        checkAndSaveJWTButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 22)
        checkAndSaveJWTButton.tintColor = .white
        checkAndSaveJWTButton.layer.cornerRadius = 10
        checkAndSaveJWTButton.layer.masksToBounds = true
        return checkAndSaveJWTButton
    }()
    
    private let jwtInfoButton: UIButton = {
        let jwtInfoButton = UIButton(type: .system)
        jwtInfoButton.backgroundColor = UIColor.tochkaGreenAccent
        jwtInfoButton.setTitle("Where to find JWT", for: .normal)
        jwtInfoButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 22)
        jwtInfoButton.tintColor = .white
        jwtInfoButton.layer.cornerRadius = 10
        jwtInfoButton.layer.masksToBounds = true
        return jwtInfoButton
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
        view.backgroundColor = .tochkaPurpleBackground
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
