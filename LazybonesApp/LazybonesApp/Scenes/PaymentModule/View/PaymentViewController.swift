//
//  PaymentViewController.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 25.10.2022.
//

import UIKit

protocol PaymentViewProtocol: UIViewController {
    
    var currentBalanceLabel: UILabel { get }

}
final class PaymentViewController: UIViewController {
    
    let currentBalanceLabel = UILabel()
    @objc private let payOffDebtButton = UIButton()
    var debtToSuppliersCollectionView: UICollectionView!
    var presenter: PaymentViewPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureCurrentBalanceLabel()
        configureDebtToSuppliersCollectionView()
        configurePayOffDebtButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        presenter?.viewDidLoad()
    }
    
    func configureCurrentBalanceLabel() {
        view.addSubview(currentBalanceLabel)
        currentBalanceLabel.layer.cornerRadius = 10
        currentBalanceLabel.layer.masksToBounds = true
        currentBalanceLabel.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 0.6005604725)
        currentBalanceLabel.textAlignment = .center

        currentBalanceLabel.translatesAutoresizingMaskIntoConstraints =                                                             false
        currentBalanceLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height/7).isActive =                 true
        currentBalanceLabel.heightAnchor.constraint(equalToConstant: view.frame.height/10).isActive =                                true
        currentBalanceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/10).isActive =         true
        currentBalanceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/10).isActive =      true
        currentBalanceLabel.font = UIFont.systemFont(ofSize: view.frame.width/10, weight: .heavy)
    }
    
    func configureDebtToSuppliersCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: (Int(view.frame.width) - 10), height: 150)
        debtToSuppliersCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.addSubview(debtToSuppliersCollectionView)
        debtToSuppliersCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "test")
        debtToSuppliersCollectionView.translatesAutoresizingMaskIntoConstraints = false
        debtToSuppliersCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height/4).isActive = true
        debtToSuppliersCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        debtToSuppliersCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        debtToSuppliersCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -(self.tabBarController?.tabBar.frame.height ?? 0)).isActive = true
        debtToSuppliersCollectionView.delegate = self
        debtToSuppliersCollectionView.dataSource = self
    }
    
    func configurePayOffDebtButton() {
        view.addSubview(payOffDebtButton)
        payOffDebtButton.backgroundColor = #colorLiteral(red: 0.8708042971, green: 0.5296641443, blue: 1, alpha: 0.5981608006)
        payOffDebtButton.layer.cornerRadius = 15
        payOffDebtButton.layer.masksToBounds = true
        payOffDebtButton.setTitle("Сформировать платежи", for: .normal)
        payOffDebtButton.tintColor = #colorLiteral(red: 0.1185451327, green: 0.1170155068, blue: 0.1250142976, alpha: 1)
        payOffDebtButton.titleLabel?.text = "Сформировать платежи"
        payOffDebtButton.titleLabel?.textAlignment = .center
        payOffDebtButton.titleLabel?.textColor = #colorLiteral(red: 0.1185451327, green: 0.1170155068, blue: 0.1250142976, alpha: 1)
        payOffDebtButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        
        payOffDebtButton.addTarget(self, action: #selector(payOffButtonDidPressed), for: .touchUpInside)
        
        payOffDebtButton.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -view.frame.height/5).isActive = true
        payOffDebtButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -view.frame.height/7).isActive = true
        payOffDebtButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.frame.width/10).isActive =         true
        payOffDebtButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -view.frame.width/10).isActive =      true
        payOffDebtButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc func payOffButtonDidPressed() {
        animateView(payOffDebtButton)
        presenter?.payOffDebtButtonDidPressed()
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


extension PaymentViewController: PaymentViewProtocol {
    
}


extension PaymentViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = debtToSuppliersCollectionView.dequeueReusableCell(withReuseIdentifier: "test", for: indexPath)
        cell.backgroundColor = .systemPink
        return cell
    }
}
