//
//  TochkaJWTViewController.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 26.11.2022.
//

import UIKit

protocol TochkaJWTViewControllerProtocol: UIViewController {
    var jwtTextField: UITextField { get }
    var clientIdTextField: UITextField { get }
    var tipsLabel: UILabel { get }
}
final class TochkaJWTViewController: UIViewController {
    
    let jwtTextField = UITextField()
    let clientIdTextField = UITextField()
    private let checkAndSaveJWTButton = UIButton()
    private let jwtInfoButton = UIButton()
    let tipsLabel = UILabel()
    
    var presenter: TochkaJWTViewPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9352212548, green: 0.8417765498, blue: 0.9561126828, alpha: 1)
        configureJWTTextView()
        configurePasswordTextfield()
        configureCheckAndSaveJWTButton()
        configureJWTInfoButton()
        configureTipsLabel()
    }
    
    
    @objc private func checkAndSaveJWTButtonDidPressed() {
        animateView(checkAndSaveJWTButton)
        presenter?.checkAndSaveJWTButtonDidPressed()
    }
    
    @objc private func jwtInfoButtonDidPressed() {
        animateView(jwtInfoButton)
        presenter?.jwtInfoButtonDidPressed()
    }
    
    private func configureJWTTextView() {
        view.addSubview(jwtTextField)
        jwtTextField.placeholderRect(forBounds: CGRect(x: 20, y: 0, width: 0, height: 0))
        jwtTextField.backgroundColor = .white
        jwtTextField.placeholder = "Введине JWT"
        jwtTextField.layer.cornerRadius = 10
        jwtTextField.layer.masksToBounds = true
        
        jwtTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height/5).isActive = true
        jwtTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/10).isActive = true
        jwtTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/10).isActive = true
        jwtTextField.heightAnchor.constraint(equalToConstant: 150).isActive = true
        jwtTextField.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configurePasswordTextfield() {
        view.addSubview(clientIdTextField)
        clientIdTextField.backgroundColor = .white
        clientIdTextField.placeholder = "Введите clientId"
        clientIdTextField.layer.cornerRadius = 10
        clientIdTextField.layer.masksToBounds = true
        
        clientIdTextField.topAnchor.constraint(equalTo: jwtTextField.bottomAnchor, constant: view.frame.height/40).isActive = true
        clientIdTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/10).isActive = true
        clientIdTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/10).isActive = true
        clientIdTextField.heightAnchor.constraint(equalToConstant: 45).isActive = true
        clientIdTextField.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureCheckAndSaveJWTButton() {
        view.addSubview(checkAndSaveJWTButton)
        checkAndSaveJWTButton.backgroundColor = #colorLiteral(red: 0.4625588059, green: 0.3441475034, blue: 0.8773947954, alpha: 1)
        checkAndSaveJWTButton.setTitle("Check and save JWT and clientId", for: .normal)
        checkAndSaveJWTButton.layer.cornerRadius = 10
        checkAndSaveJWTButton.layer.masksToBounds = true
        checkAndSaveJWTButton.addTarget(self, action: #selector(checkAndSaveJWTButtonDidPressed), for: .touchUpInside)
        
        checkAndSaveJWTButton.topAnchor.constraint(equalTo: clientIdTextField.bottomAnchor, constant: view.frame.height/20).isActive = true
        checkAndSaveJWTButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/10).isActive = true
        checkAndSaveJWTButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/10).isActive = true
        checkAndSaveJWTButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        checkAndSaveJWTButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureJWTInfoButton() {
        view.addSubview(jwtInfoButton)
        jwtInfoButton.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        jwtInfoButton.setTitle("Where to find JWT", for: .normal)
        jwtInfoButton.layer.cornerRadius = 10
        jwtInfoButton.layer.masksToBounds = true
        jwtInfoButton.addTarget(self, action: #selector(jwtInfoButtonDidPressed), for: .touchUpInside)
        
        jwtInfoButton.topAnchor.constraint(equalTo: checkAndSaveJWTButton.bottomAnchor, constant: view.frame.height/15).isActive = true
        jwtInfoButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/10).isActive = true
        jwtInfoButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/10).isActive = true
        jwtInfoButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        jwtInfoButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureTipsLabel() {
        view.addSubview(tipsLabel)
        tipsLabel.sizeToFit()
        tipsLabel.numberOfLines = 0
        tipsLabel.lineBreakMode = .byWordWrapping
        
        tipsLabel.bottomAnchor.constraint(equalTo: checkAndSaveJWTButton.topAnchor).isActive = true
        tipsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/10).isActive = true
        tipsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/10).isActive = true
        tipsLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        tipsLabel.translatesAutoresizingMaskIntoConstraints = false
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
extension TochkaJWTViewController: TochkaJWTViewControllerProtocol {
    
}
