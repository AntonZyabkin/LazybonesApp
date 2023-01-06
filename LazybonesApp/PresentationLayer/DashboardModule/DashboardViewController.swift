//
//  DashboardViewController.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 25.10.2022.
//

import UIKit

protocol DashboardViewControllerProtocol: UIViewController {
    func chengeBabButtonItem(title: String)
}
final class DashboardViewController: UIViewController {
    
    var presenter: DashboardViewPresenterProtocol?
    private lazy var logOutOfdNavBarItem = UIBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemTeal
        configeNavBar()
        presenter?.startLoadData()
    }
    
    private func configeNavBar() {
        logOutOfdNavBarItem = UIBarButtonItem(title: "Выйти из OFD.RU", style: .plain, target: self, action: #selector(logOutItemDidPress))
        navigationItem.rightBarButtonItem = logOutOfdNavBarItem
    }
    
    @objc
    func logOutItemDidPress() {
        presenter?.logOutItemDidPress()
    }
}

extension DashboardViewController: DashboardViewControllerProtocol {
    func chengeBabButtonItem(title: String) {
        logOutOfdNavBarItem.title = title
    }
}
