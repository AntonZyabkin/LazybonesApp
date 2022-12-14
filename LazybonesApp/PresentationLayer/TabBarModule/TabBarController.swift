//
//  MainTabBapController.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 25.10.2022.
//

import UIKit

final class TabBarController: UITabBarController {
    
    private var moduleBuilder: Builder
    
    init(moduleBuilder: Builder){
        self.moduleBuilder = moduleBuilder
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarController()
    }
    
    private func setupTabBarController() {
        
        let paymentViewController = moduleBuilder.buildPaymentViewController()
        let comingViewController = moduleBuilder.buildComingViewCOntroller()
        let teamViewController = moduleBuilder.buildTeamViewController()
        let dashboardViewController = moduleBuilder.buildDashboardViewController()
        
        //внедрение зависимости между экранами оплаты и поступления
        (comingViewController.topViewController as? ComingViewController)?.presenter?.dataSource = (paymentViewController.topViewController as? PaymentViewController)?.presenter as? PaymentViewPresenterDataSource
        
        paymentViewController.tabBarItem.title = "Оплата"
        paymentViewController.tabBarItem.image = UIImage(systemName: "creditcard.fill")

        comingViewController.tabBarItem.title = "Приход"
        comingViewController.tabBarItem.image = UIImage(systemName: "shippingbox.fill")

        teamViewController.tabBarItem.title = "Команда"
        teamViewController.tabBarItem.image = UIImage(systemName: "person.3.fill")

        dashboardViewController.tabBarItem.title = "Показатели"
        dashboardViewController.tabBarItem.image = UIImage(systemName: "chart.bar.xaxis")

        viewControllers = [
            dashboardViewController,
            comingViewController,
            teamViewController,
            paymentViewController
        ]
    }
}
