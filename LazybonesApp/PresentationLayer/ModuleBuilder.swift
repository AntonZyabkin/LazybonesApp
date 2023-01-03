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
    func buildPaymentViewController() -> UINavigationController
    func buildComingViewCOntroller() -> UINavigationController
    func buildDashboardViewController() -> UINavigationController
    func buildTeamViewController() -> TeamViewController
    func buildWebPageViewController() -> WebPageViewController
    func buildSbisAuthViewController() -> SbisAuthViewController
    func buildTochkaJWTViewController() -> TochkaJWTViewController
    func buildOFDAuthViewController() -> OfdAuthViewController
}

final class ModuleBuilder {
    private let sbisAPIService: (SbisApiServicable & SbisAuthApiServicable)
    private let tochkaAPIService: TochkaAPIServicable
    private let ofdAPIService: OfdAPIServicable
    private let networkService: Networkable
    private let decoderService: DecoderServicable
    private let keychainService: KeychainServicable
    
    init() {
        decoderService = DecoderService()
        keychainService = KeychainService(decoder: decoderService)
        networkService = NetworkService(decoderService: decoderService)
        sbisAPIService = SbisAPIService(networkService: networkService)
        tochkaAPIService = TochkaAPIService(networkService: networkService)
        ofdAPIService = OfdAPIService(networkService: networkService)
    }
}

extension ModuleBuilder: Builder {
    
    func buildTabBarController() -> TabBarController {
        let tabBarController = TabBarController(moduleBuilder: self)
        return tabBarController
    }
    
    func buildPaymentViewController() -> UINavigationController {
        let viewController = PaymentViewController()
        let presenter = PaymentViewPresenter(tochkaAPIService: tochkaAPIService, keychainService: keychainService, moduleBuilder: self)
        viewController.presenter = presenter
        presenter.view = viewController
        let navigationController = UINavigationController(rootViewController: viewController)
        return navigationController
    }
    
    func buildComingViewCOntroller() -> UINavigationController {
        let viewController = ComingViewController()
        let presenter = ComingViewPresenter(sbisAPIService: sbisAPIService, keychainService: keychainService, moduleBuilder: self)
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.viewDidLoad()
        let navigationController = UINavigationController(rootViewController: viewController)
        return navigationController
    }
    
    func buildDashboardViewController() -> UINavigationController {
        let viewController = DashboardViewController()
        let presenter = DashboardViewPresenter(ofdAPIService: ofdAPIService, keychainService: keychainService, moduleBuilder: self)
        viewController.presenter = presenter
        presenter.view = viewController
        return UINavigationController(rootViewController: viewController)
    }
    
    func buildTeamViewController() -> TeamViewController {
        let viewControlelr = TeamViewController()
        return viewControlelr
    }
    
    func buildWebPageViewController() -> WebPageViewController {
        return WebPageViewController()
    }
    
    func buildSbisAuthViewController() -> SbisAuthViewController {
        let viewController = SbisAuthViewController()
        let presenter = SbisAuthPresenter(sbisAPIService: sbisAPIService, keychainService: keychainService)
        viewController.presenter = presenter
        presenter.view = viewController
        return viewController
    }
    
    func buildTochkaJWTViewController() -> TochkaJWTViewController {
        let viewController = TochkaJWTViewController()
        let presenter = TochkaJWTViewPresenter(keychainService: keychainService, tochkaAPIService: tochkaAPIService, moduleBuilder: self)
        presenter.view = viewController
        viewController.presenter = presenter
        return viewController
    }
    
    func buildOFDAuthViewController() -> OfdAuthViewController {
        let viewController = OfdAuthViewController()
        let presenter = OfdAuthViewPresenter(ofdAPIService: ofdAPIService, keychainService: keychainService)
        viewController.presenter = presenter
        presenter.view = viewController
        return viewController
    }
}
