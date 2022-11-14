//
//  ComingViewPresenter.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 25.10.2022.
//

import Foundation
import SwiftKeychainWrapper

protocol ComingViewPresenterProtocol{
    func viewDidLoad()
    func didTabComingDocument(at index: Int)
}

final class ComingViewPresenter {
    weak var view: ComingViewProtocol?
    
    private var documentsArray: [Document] = []
    
    private let moduleBuilder: Builder
    private let sbisAPIService: SbisApiServicable
    private let keychainService: KeychainServicable
    
    init(sbisAPIService: SbisApiServicable, keychainService: KeychainServicable, moduleBuilder: Builder) {
        self.sbisAPIService = sbisAPIService
        self.keychainService = keychainService
        self.moduleBuilder = moduleBuilder
    }
}

extension ComingViewPresenter: ComingViewPresenterProtocol {
    func viewDidLoad() {
        guard let sbisToken = keychainService.fetch(for: .sbisSessionID) else {
            print("Token error")
            //если нет токена,  пушим экран авторизации
            self.view?.navigationController?.pushViewController(moduleBuilder.buildSbisAuthViewController(), animated: true)
            return
        }
        let request = SbisComingListRequest(sbisToken)
        sbisAPIService.fetchComingList(request: request) { result in
            switch result {
            case .success(let response):
                self.view?.updateTableView(viewModel: response.result.document)
            case .failure(let error):
                self.view?.showErrorAlert(error)
            }
        }
    }
    
    func didTabComingDocument(at index: Int) {
        let vc = moduleBuilder.buildComingDetailsViewController()
        vc.urlTest = documentsArray[index].linkToPDF
        self.view?.navigationController?.pushViewController(vc, animated: true)
    }
}
