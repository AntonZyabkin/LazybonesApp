//
//  Игшдвук.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 09.10.2022.
//

import UIKit
import Moya

protocol Builder {
    func buildTabBarController() -> TabBarController
    func buildPaymentViewController() -> PaymentViewController
    func buildComingViewCOntroller() -> UINavigationController
    func buildDashboardViewController() -> DashboardViewController
    func buildTeamViewController() -> TeamViewController
    func buildComingDetailsViewController() -> ComingDetailsViewController
    func buildSbisAuthViewController() -> SbisAuthViewController
}

final class ModuleBuilder {
    private let sbisAPIService: (SbisApiServicable & SbisAuthApiServicable)
    private let networkService: Networkable
    private let decoderService: DecoderServicable
    private let keychainService: KeychainServicable
    private let tochkaAPIService: TochkaAPIServicable
    
    init() {
        decoderService = DecoderService()
        keychainService = KeychainService()
        networkService = NetworkService(decoderService: decoderService)
        sbisAPIService = SbisAPIService(networkService: networkService)
        tochkaAPIService = TochkaAPIService(networkService: networkService)
    }
}

extension ModuleBuilder: Builder {
    
    func buildTabBarController() -> TabBarController {
        let tabBarController = TabBarController(moduleBuilder: self)
        return tabBarController
    }
    
    func buildPaymentViewController() -> PaymentViewController {
        let viewController = PaymentViewController()
        let presenter = PaymentViewPresenter(tochkaAPIService: tochkaAPIService, keychainService: keychainService, moduleBuilder: self)
        viewController.presenter = presenter
        return viewController
    }
    
    func buildComingViewCOntroller() -> UINavigationController {
        let viewController = ComingViewController()
        let presenter = ComingViewPresenter(sbisAPIService: sbisAPIService, keychainService: keychainService, moduleBuilder: self)
        viewController.presenter = presenter
        presenter.view = viewController
        let navController = UINavigationController(rootViewController: viewController)
        return navController
    }
    
    func buildDashboardViewController() -> DashboardViewController {
        let viewControlelr = DashboardViewController()
        return viewControlelr
    }
    
    func buildTeamViewController() -> TeamViewController {
        let viewControlelr = TeamViewController()
        return viewControlelr
    }
    
    func buildComingDetailsViewController() -> ComingDetailsViewController {
        return ComingDetailsViewController()
    }
    
    func buildSbisAuthViewController() -> SbisAuthViewController {
        let viewController = SbisAuthViewController()
        let presenter = SbisAuthPresenter(sbisAPIService: sbisAPIService, keychainService: keychainService)
        viewController.presenter = presenter
        presenter.view = viewController
        return viewController
    }
    
}
