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
}

extension PaymentViewPresenter: PaymentViewPresenterProtocol {
    func viewDidLoad() {
        let request = TochkaAccessTokenRequest("", clientSecret: "")
        tochkaAPIService.getAccessToken(request) { result in
            switch result {
            case .success(let responce):
                print(responce)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
