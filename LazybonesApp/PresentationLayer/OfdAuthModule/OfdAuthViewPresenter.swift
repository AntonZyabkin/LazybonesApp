//
//  File.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 16.12.2022.
//

import Foundation

final class OfdAuthViewPresenter {
    weak var view: SbisAuthViewProtocol?
    
    private let ofdAPIService: OfdAPIServicable
    private let keychainService: KeychainServicable
    
    init(ofdAPIService: OfdAPIServicable, keychainService: KeychainServicable) {
        self.ofdAPIService = ofdAPIService
        self.keychainService = keychainService
    }
}

extension OfdAuthViewPresenter: SbisAuthPresenterProtocol {
    
    func viewWasLoaded() {
        guard let login = keychainService.fetch(for: .ofdLogin), let password = keychainService.fetch(for: .ofdPassword) else {
            return
        }
        view?.showAuthData(login: login, password: password)
    }
    
    func authButtonDidPressed(_ login: String, _ password: String) {
        let request = OfdAuthRequest(login: login, password: password)
        //TODO: Нужно ли объявлять лист захвата с слабыv селф [weak self] на след строке?
        ofdAPIService.sendAuthRequest(request: request) { response in
            switch response {
            case .success(let result):
                self.keychainService.save(result.authToken, for: .ofdAuthToken)
                self.keychainService.save(login, for: .ofdLogin)
                self.keychainService.save(password, for: .ofdPassword)
                self.view?.navigationController?.popViewController(animated: true)
            case .failure(let error):
                self.view?.showErrorMessage("Неверный логин или пароль")
                print(error)
            }
        }
    }
}
