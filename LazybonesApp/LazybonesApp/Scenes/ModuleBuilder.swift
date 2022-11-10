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
    func buildComingViewCOntroller() -> ComingViewController
    func buildDashboardViewController() -> DashboardViewController
    func buildTeamViewController() -> TeamViewController
}

final class ModuleBuilder {
    
    private let sbisAPIService: (SbisApiServicable & SbisAuthApiServicable)
    private let networkService: Networkable
    private let decoderService: DecoderServicable
    
    init() {
        decoderService = DecoderService()
        networkService = NetworkService(decoderService: decoderService)
        sbisAPIService = SbisAPIService(networkService: networkService)
    }
}

extension ModuleBuilder: Builder {
    func buildTabBarController() -> TabBarController {
        let tabBarController = TabBarController(moduleBuilder: self)
        return tabBarController
    }
    
    func buildPaymentViewController() -> PaymentViewController {
        let viewControlelr = PaymentViewController()
        return viewControlelr
    }
    
    func buildComingViewCOntroller() -> ComingViewController {
        let viewController = ComingViewController()
        let presenter = ComingViewPresenter(sbisAPIService: sbisAPIService)
        viewController.presenter = presenter
        presenter.view = viewController
        
        return viewController
    }
    
    func buildDashboardViewController() -> DashboardViewController {
        let viewControlelr = DashboardViewController()
        return viewControlelr

    }
    
    func buildTeamViewController() -> TeamViewController {
        let viewControlelr = TeamViewController()
        return viewControlelr

    }
}
