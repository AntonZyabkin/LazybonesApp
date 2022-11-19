//
//  PaymentViewPresenter.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 19.11.2022.
//

import Foundation

protocol PaymentViewPresenterProtocol {
    func viewDidLoad()
}

final class PaymentViewPresenter {
    
    private let moduleBuilder: Builder
    private let tochkaAPIService: TochkaAPIServicable
    private let keychainService: KeychainServicable
    private var view: PaymentViewProtocol?
    
    init(tochkaAPIService: TochkaAPIServicable, keychainService: KeychainServicable, moduleBuilder: Builder) {
        self.tochkaAPIService = tochkaAPIService
        self.keychainService = keychainService
        self.moduleBuilder = moduleBuilder
    }
    
    private func createPermissionList() {
        guard let accessToken = self.keychainService.fetch(for: .tochkaAccessToken) else {
            print("fetch access token from keychainService error")
            return
        }
        let request = TochkaPermissionsListRequest(accessToken)
        tochkaAPIService.createPermissionsList(request) { result in
            switch result {
            case .success(let responce):
                print(responce)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension PaymentViewPresenter: PaymentViewPresenterProtocol {
    func viewDidLoad() {
        let request = TochkaAccessTokenRequest("ygkOmK173dqPQzF8ZVIE8kVaceBMAFcM", clientSecret: "JANSdSxEEhds44L3uMV6ENbEiuuDCrxM")
        tochkaAPIService.getAccessToken(request) { [weak self] result in
            switch result {
            case .success(let responce):
                if let tochkaAccessToken = responce.accessToken {
                    self?.keychainService.save(tochkaAccessToken, for: .tochkaAccessToken)
                    self?.createPermissionList()
                } else {
                    print(responce.errorDescription ?? "unexpected error")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
