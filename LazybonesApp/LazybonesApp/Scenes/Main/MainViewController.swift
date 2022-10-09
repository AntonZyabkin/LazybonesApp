//
//  MainViewController.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 05.10.2022.
//

import UIKit

// MARK: - MainDisplayLogic

protocol MainDisplayLogic: AnyObject {
    func updateView()
}

// MARK: - MainViewController

final class MainViewController: UIViewController {
    
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("All requests", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var presenter: MainPresentatisonLogic?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewController()
        presenter?.viewDidLoad()
    }
    
    @objc
    private func didTapButton() {
        presenter?.didTapButton()
        let plaseHolderVC = PlaseHolderViewController()
        show(plaseHolderVC, sender: nil)
    }
}

// MARK: - MainDisplayLogic Impl

extension MainViewController: MainDisplayLogic {
    func updateView() {
        print(#function)
    }
}

// MARK: - Private mathod

private extension MainViewController {
    
    func setupViewController() {
        view.backgroundColor = .lightGray
        
        addSubviews()
        setupConstrainst()
    }
    
    func addSubviews() {
        view.addSubview(button)
    }
    
    func setupConstrainst() {
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200),
            button.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
