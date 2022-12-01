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
    var view: PaymentViewProtocol?
    
    init(tochkaAPIService: TochkaAPIServicable, keychainService: KeychainServicable, moduleBuilder: Builder) {
        self.tochkaAPIService = tochkaAPIService
        self.keychainService = keychainService
        self.moduleBuilder = moduleBuilder
    }
    //MARK: - создает лист разрешений - то какие методы может обрабатывать сервер по ауф данным
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
    
    //MARK: - запрашивает accessToken по clientID и clientSecret, осхраняет его в keychain
    private func accessTokenRequest() {
        let request = TochkaAccessTokenRequest(" ", clientSecret: " ")
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
    
    private func checkJWT() {
        if let token = keychainService.fetch(for: .tochkaJWT) {
            fetchBalance(token)
        } else {
            print("where is no JWT")
            self.view?.navigationController?.pushViewController(moduleBuilder.buildTochkaJWTViewController(), animated: true)
        }
    }
    
    private func fetchBalance(_ JWT: String) {
        let getJWTrequest = TochkaBalanceRequest(JWT: JWT)
        tochkaAPIService.getBalanceInfo(getJWTrequest) { [weak self] result in
            switch result {
            case .success(let responce):
                if let currentAmount = responce.data?.balance.first?.amount.amount {
                    print(currentAmount)
                } else {
                    print(responce.errors?.first?.message ?? "unexpected error")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension PaymentViewPresenter: PaymentViewPresenterProtocol {
    func viewDidLoad() {
        checkJWT()
    }
}
