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
    func logOutItemDidPress()
    var dataSource: PaymentViewPresenterDataSource? { get set }
}

protocol ComigDataProtocol {
    var documentsArray: [Document] { get }
}

final class ComingViewPresenter {
    weak var view: ComingViewProtocol?
    weak var dataSource: PaymentViewPresenterDataSource?
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
        view?.configeActivityIndicator()
        guard let sbisToken = keychainService.fetch(for: .sbisSessionID) else {
            self.view?.navigationController?.pushViewController(moduleBuilder.buildSbisAuthViewController(), animated: true)
            return
        }
        let request = SbisComingListRequest(sbisToken)
        sbisAPIService.fetchComingList(request: request) { [weak self] result in
            switch result {
            case .success(let response):
                self?.documentsArray = response.result.document
                self?.view?.updateTableView(viewModel: response.result.document)
                self?.dataSource?.updateModel(response)
            case .failure(let error):
                self?.view?.showErrorAlert(error)
            }
        }
    }
    
    func didTabComingDocument(at index: Int) {
        let vc = moduleBuilder.buildWebPageViewController()
        vc.urlString = documentsArray[index].linkToPDF
        print(documentsArray[index].linkToPDF)
        self.view?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func logOutItemDidPress() {
        self.view?.updateTableView(viewModel: [])
        viewDidLoad()
    }
}
