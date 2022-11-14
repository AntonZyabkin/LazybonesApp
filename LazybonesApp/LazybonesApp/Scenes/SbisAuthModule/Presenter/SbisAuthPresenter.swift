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
    func enterButtonDidPressed(_ login: String, _ password: String)
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
        enterButtonDidPressed(login, password)
    }
    
    func enterButtonDidPressed(_ login: String, _ password: String) {
        let sbisAuthRequest = SbisAuthRequest(login, password)
        sbisAPIService.sendAuthRequest(request: sbisAuthRequest) { [self] result in
            switch result {
            case .success(let authResponse):
                guard let token = authResponse.result else {
                    return
                }
                self.keychainService.save(token, for: .sbisSessionID)
                print("Token was saved")
            case .failure(let error):
                view?.showErrorAlert(error)
            }
        }
    }
}
