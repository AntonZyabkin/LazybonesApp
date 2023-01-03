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
    var paymentCollectionView: UICollectionView { get set }
    func reloadCollectionView()
}

final class PaymentViewController: UIViewController {
    
    var presenter: PaymentViewPresenterProtocol?

    lazy var currentBalanceLabel: UILabel = {
        let currentBalanceLabel = UILabel()
        currentBalanceLabel.backgroundColor = .clear
        currentBalanceLabel.textAlignment = .center
        currentBalanceLabel.font = .mainBoldHelvetica(size: 45)
        currentBalanceLabel.textColor = .tochkaIncome
        return currentBalanceLabel
    }()
    
    lazy var lastPaymentDateLabel: UILabel = {
        let lastPaymentDateLabel = UILabel()
        lastPaymentDateLabel.backgroundColor = .clear
        lastPaymentDateLabel.textAlignment = .center
        lastPaymentDateLabel.font = .mainBoldHelvetica(size: 16)
        lastPaymentDateLabel.textColor = .darkGray
        lastPaymentDateLabel.numberOfLines = 0
        lastPaymentDateLabel.text = " "
        return lastPaymentDateLabel
    }()
    
    private lazy var summaryStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [currentBalanceLabel, lastPaymentDateLabel])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.backgroundColor = .tochkaPurpleBackground
        stackView.layer.cornerRadius = 20
        stackView.layer.shadowColor = UIColor.darkGray.cgColor
        stackView.layer.shadowRadius = 5
        stackView.layer.shadowOffset = CGSize(width: 0, height: 15)
        stackView.layer.shadowOpacity = 0.6
        stackView.layer.cornerRadius = 25
        return stackView
    }()
    
    private var payOffDebtButton: UIButton = {
        let payOffDebtButton = UIButton(type: .system)
        payOffDebtButton.backgroundColor = .tochkaPurpleAccent
        payOffDebtButton.layer.opacity = 0.9
        payOffDebtButton.layer.cornerRadius = 30
        payOffDebtButton.setTitle("Сформировать платежи", for: .normal)
        payOffDebtButton.tintColor = .white
        payOffDebtButton.titleLabel?.textAlignment = .center
        payOffDebtButton.titleLabel?.font = .tochkaBoldArial(size: 22)
        payOffDebtButton.layer.shadowColor = UIColor.tochkaPurpleAccent.cgColor
        payOffDebtButton.layer.shadowRadius = 5
        payOffDebtButton.layer.shadowOffset = CGSize(width: 0, height: 15)
        payOffDebtButton.layer.shadowOpacity = 0.9
        payOffDebtButton.layer.cornerRadius = 15
        return payOffDebtButton
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
        view.backgroundColor = .tochkaPurpleAccent
        view.layer.opacity = 0.8
        return view
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

            payOffDebtButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150),
            payOffDebtButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            payOffDebtButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -50),
            payOffDebtButton.heightAnchor.constraint(equalToConstant: 70),
            
            summaryStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 64),
            summaryStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            summaryStackView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -50),
            summaryStackView.heightAnchor.constraint(equalToConstant: 120),
            
            paymentCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height/4),
            paymentCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            paymentCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            paymentCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -(self.tabBarController?.tabBar.frame.height ?? 0))
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
