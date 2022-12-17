//
//  DashboardViewPresenter.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 16.12.2022.
//

import Foundation

protocol DashboardViewPresenterProtocol {
    func viewDidLoad()
    func logOutItemDidPress()
}

final class DashboardViewPresenter {
    private let moduleBuilder: Builder
    private let ofdAPIService: OfdAPIServicable
    private let keychainService: KeychainServicable
    
    var view: DashboardViewControllerProtocol?
    
    init(ofdAPIService: OfdAPIServicable, keychainService: KeychainServicable, moduleBuilder: Builder) {
        self.ofdAPIService = ofdAPIService
        self.keychainService = keychainService
        self.moduleBuilder = moduleBuilder
    }
    
    private func sendGetReportsRequest(token: String, inn: String, dateFrom: String, dateTo: String) {
        let request = OfdGetReportsRequest(inn: inn, authToken: token, dateFrom: dateFrom, dateTo: dateTo)

    }
}

extension DashboardViewPresenter: DashboardViewPresenterProtocol {
    
    func viewDidLoad() {
        print("did load DashBoard")
        guard let ofdAuthToket = keychainService.fetch(for: .ofdAuthToken) else {
            let authViewController = moduleBuilder.buildOFDAuthViewController()
            view?.navigationController?.pushViewController(authViewController, animated: true)
            print("go to auth OFD")
            return
        }
        let request = OfdGetReportsRequest(inn: "5024198006", authToken: ofdAuthToket, dateFrom: "2022-12-01T09:28:54", dateTo: "2022-12-17T15:47:36")
//        ofdAPIService.gerReportsRequest(request: request) { response in
//            switch response {
//            case .success(let result):
//                print(result)
//            case .failure(let error):
//                print(error)
//            }
//        }
    }
    
    func logOutItemDidPress() {
        keychainService.deleteItem(for: .ofdAuthToken)
        self.view?.navigationController?.pushViewController(moduleBuilder.buildOFDAuthViewController(), animated: true)
        view?.chengeBabButtonItem(title: "Войти в OFD.RU")
    }
}
