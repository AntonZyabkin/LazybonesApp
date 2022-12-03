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
    
    //MARK: - Производит проверку наличия токера в КииЧейн
    private func checkJWT() {
        if let token = keychainService.fetch(for: .tochkaJWT) {
            fetchBalance(token)
        } else {
            print("where is no JWT")
            self.showJWTViewController()
        }
    }
    
    private func fetchBalance(_ JWT: String) {
        let getJWTrequest = TochkaBalanceRequest(JWT: JWT)
        tochkaAPIService.getBalanceInfo(getJWTrequest) { [weak self] result in
            switch result {
            case .success(let responce):
                if let currentAmount = responce.data?.balance.first?.amount.amount {
                    self?.setBalanceLabel(currentAmount)
                    self?.initStatement(jwt: JWT, accountId: responce.data?.balance.first?.accountID ?? "")
                } else if responce.errors != nil {
                    self?.showJWTViewController()
                    print(responce.errors?.first?.message ?? "unexpected error")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    private func setBalanceLabel(_ balance: Double) {
        self.view?.currentBalanceLabel.text = String(balance) + " \u{20BD}"
    }
    
    private func showJWTViewController() {
        self.view?.navigationController?.pushViewController(moduleBuilder.buildTochkaJWTViewController(), animated: true)
    }
    
    
    //MARK: - Создаем выписку по выбранному диапазону времени
    func initStatement(jwt: String, accountId: String) {
        let initStatemenrRequest = TochkaInitStatementRequest(
            JWT: jwt,
            accountID: accountId+"/044525999",
            startDateTime: "2022-11-10",
            endDateTime: "2022-11-13")
        tochkaAPIService.initStatement(initStatemenrRequest) { result in
            switch result {
            case .success(let response):
                guard
                    let statementId = response.data?.statement.statementID,
                    let accountId = response.data?.statement.accountID
                else {
                    print(response.message)
                    print(response.errors)
                    return
                }
                let getStatementRequest = TochkaGetStatementRequest(
                    statementId: statementId,
                    accountId: accountId,
                    jwt: jwt
                )
                self.getStatement(getStatementRequest)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    //MARK: - Запрашиваем конкретную выписку с транзакциями по счету, созданную в initStatement
    func getStatement(_ request: TochkaGetStatementRequest) {
        tochkaAPIService.getStatement(request) { result in
            switch result {
            case .success(let responce):
                print(responce)
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension PaymentViewPresenter: PaymentViewPresenterProtocol {
    func viewDidLoad() {
        checkJWT()
        guard let lastPaymentDate = keychainService.fetch(for: .lastPaymentDate) else {
            print(keychainService.save("28.11.2022", for: .lastPaymentDate))
            return
        }
        print(lastPaymentDate)
    }
}
