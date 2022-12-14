//
//  TochkaJWTPresenter.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 26.11.2022.
//

import Foundation


protocol TochkaJWTViewPresenterProtocol {
    func jwtInfoButtonDidPressed()
    func checkAndSaveJWTButtonDidPressed()
}

final class TochkaJWTViewPresenter {
    private let keychainService: KeychainServicable
    private let tochkaAPIService: TochkaAPIServicable
    let moduleBuilder: Builder
    weak var view: TochkaJWTViewControllerProtocol?
    
    init(keychainService: KeychainServicable,tochkaAPIService: TochkaAPIServicable, moduleBuilder: Builder) {
        self.keychainService = keychainService
        self.tochkaAPIService = tochkaAPIService
        self.moduleBuilder = moduleBuilder
    }
}

extension TochkaJWTViewPresenter: TochkaJWTViewPresenterProtocol {
    func jwtInfoButtonDidPressed() {
        let tochkaInfoViewController = moduleBuilder.buildWebPageViewController()
        tochkaInfoViewController.urlString = "https://enter.tochka.com/doc/v2/redoc/section/Algoritm-raboty#Veb-token-(JWT)"
        self.view?.navigationController?.pushViewController(tochkaInfoViewController, animated: true)
    }
    
    func checkAndSaveJWTButtonDidPressed() {
        if let jwt = view?.jwtTextField.text, let _ = view?.clientIdTextField.text {
            let balanceRequest = TochkaBalanceRequest(JWT:jwt)
            tochkaAPIService.getBalanceInfo(balanceRequest) { [weak self] resuls in
                guard let self = self else {
                    print("self is nil [checkAndSaveJWTButtonDidPressed]")
                    return
                }
                switch resuls {
                case .success(let response):
                    if let errorMessage = response.errors?.first?.message {
                        DispatchQueue.main.async {
                            self.view?.tipsLabel.text = errorMessage
                        }
                        return
                    }
                    if let responseMessage = response.message {
                        DispatchQueue.main.async {
                            self.view?.tipsLabel.text = responseMessage
                        }
                        return
                    }
                    print("status of savinf JWT: \(self.keychainService.save(jwt, for: .tochkaJWT))")
                    self.view?.navigationController?.popViewController(animated: true)
                    
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.view?.tipsLabel.text = error.localizedDescription
                    }
                }
            }
        } else {
            DispatchQueue.main.async {
                self.view?.tipsLabel.text = "Please fill in the empty fields"
            }
        }
    }
}
