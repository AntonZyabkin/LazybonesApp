//
//  SbisAuthPresenter.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 11.11.2022.
//

import Foundation

protocol SbisAuthPresenterProtocol{
    //проверить есть ли в Keychain Log + Pass
    func viewDidLoad()
    //выполнить авторизацию
    func authButtonDidPressed(_ login: String, _ password: String)
}

final class SbisAuthPresenter {
    weak var view: SbisAuthViewProtocol?
    
    private let sbisAPIService: SbisAuthApiServicable
    private let keychainService: KeychainServicable
    
    init(sbisAPIService: SbisAuthApiServicable, keychainService: KeychainServicable) {
        self.sbisAPIService = sbisAPIService
        self.keychainService = keychainService
    }
}

extension SbisAuthPresenter: SbisAuthPresenterProtocol {
    
    func viewDidLoad() {
        guard let login = keychainService.fetch(for: .sbisLogon), let password = keychainService.fetch(for: .sbisPassword) else {
            return
        }
        authButtonDidPressed(login, password)
    }
    
    func authButtonDidPressed(_ login: String, _ password: String) {
        let sbisAuthRequest = SbisAuthRequest(login, password)
        sbisAPIService.sendAuthRequest(request: sbisAuthRequest) { [weak self] result in
            switch result {
            case .success(let authResponse):
                guard let token = authResponse.result else {
                    if let errorMassege = authResponse.error?.message {
                        self?.view?.showErrorMessage(errorMassege)
                    }
                    return
                }
                self?.view?.showErrorMessage("")
                self?.keychainService.save(login, for: .sbisLogon)
                self?.keychainService.save(password, for: .sbisPassword)
                self?.keychainService.save(token, for: .sbisSessionID)
                self?.view?.navigationController?.popViewController(animated: true)
            case .failure(let error):
                self?.view?.showErrorMessage(error.localizedDescription)
            }
        }
    }
}
