//
//  PaymentViewController.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 25.10.2022.
//

import UIKit

protocol PaymentViewProtocol: UIViewController {
    var currentBalanceLabel: UILabel { get }
    var lastPaymentDateLabel: UILabel { get set }
    func reloadCollectionView()
    func showOrHidePayOffDebtButton()
    func showAlert()
}

final class PaymentViewController: UIViewController {
    var presenter: PaymentViewPresenterProtocol?
    lazy var currentBalanceLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.font = .mainBoldHelvetica(size: 45)
        label.textColor = .black
        return label
    }()
    lazy var lastPaymentDateLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.font = .mainBoldHelvetica(size: 16)
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.text = " "
        return label
    }()
    private lazy var summaryStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [currentBalanceLabel, lastPaymentDateLabel])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.backgroundColor = .myBackgroundPurpleLight
        stackView.layer.cornerRadius = 15
        return stackView
    }()
    private lazy var payOffDebtButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .myPurpleBold
        button.setTitle("Сформировать платежи", for: .normal)
        button.tintColor = .white
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = .mainBoldHelvetica(size: 22)
        button.isHidden = true
        return button
    }()
    lazy var paymentCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 30, left: 20, bottom: 0, right: 20)
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: (Int(view.frame.width) - 10), height: 160)
        var debtToSuppliersCollectionView = UICollectionView(
            frame: CGRect(x: 0, y: 0, width: 100, height: 100),
            collectionViewLayout: layout
        )
        return debtToSuppliersCollectionView
    }()
    private lazy var headerBackgroundView: UIView = {
       let view = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        view.backgroundColor = .myPurpleBold
        view.layer.opacity = 0.8
        return view
    }()
    private lazy var messageAllert: UIAlertController = {
        let alert = UIAlertController(title: "Успех!", message: "Все платежи были созданы и ожидают подписания в приложении Банка Точка", preferredStyle:  .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(alertAction)
        return alert
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configurePayOffDebtButton()
        paymentCollectionView.delegate = self
        paymentCollectionView.dataSource = self
        
        paymentCollectionView.register(
            PaymentCollectionViewCell.self,
            forCellWithReuseIdentifier: PaymentCollectionViewCell.identifier
        )
        payOffDebtButton.addTarget(self, action: #selector(payOffButtonDidPressed), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter?.startLoadData()
        paymentCollectionView.reloadData()
    }
    
    func configureDebtToSuppliersCollectionView() {
    }
    
    func configurePayOffDebtButton() {
        view.addSubview(headerBackgroundView)
        view.addSubview(summaryStackView)
        view.addSubview(paymentCollectionView)
        view.addSubview(payOffDebtButton)

        NSLayoutConstraint.activate([
            headerBackgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            headerBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerBackgroundView.bottomAnchor.constraint(equalTo: paymentCollectionView.topAnchor),
            
            payOffDebtButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -88),
            payOffDebtButton.heightAnchor.constraint(equalToConstant: 70),
            payOffDebtButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            payOffDebtButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            summaryStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 64),
            summaryStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            summaryStackView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -50),
            summaryStackView.heightAnchor.constraint(equalToConstant: 120),
            
            paymentCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height/4),
            paymentCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            paymentCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            paymentCollectionView.bottomAnchor.constraint(equalTo: payOffDebtButton.topAnchor)
        ])
        
        headerBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        paymentCollectionView.translatesAutoresizingMaskIntoConstraints = false
        payOffDebtButton.translatesAutoresizingMaskIntoConstraints = false
        summaryStackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc
    func payOffButtonDidPressed() {
        presenter?.payOffDebtButtonDidPressed()
    }
}


extension PaymentViewController: PaymentViewProtocol {
    func reloadCollectionView() {
        paymentCollectionView.reloadData()
    }
    
    func showOrHidePayOffDebtButton() {
        switch payOffDebtButton.isHidden {
        case true:
            payOffDebtButton.isHidden = false
        case false:
            payOffDebtButton.isHidden = true
        }
    }
    func showAlert() {
        present(messageAllert, animated: true)
    }
}

extension PaymentViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter?.numberOfItemsInSection() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = paymentCollectionView.dequeueReusableCell(
            withReuseIdentifier: PaymentCollectionViewCell.identifier,
            for: indexPath) as? PaymentCollectionViewCell else {
            return UICollectionViewCell()
        }
        guard let dataForPaymentCell = presenter?.dataForPaymentCell(by: indexPath) else { return cell }
        cell.configureCell(dataForCell: dataForPaymentCell)
        return cell
    }
}
