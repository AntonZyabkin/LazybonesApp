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
    
    private func sendComingListRequest(_ token: String) {
        let request = SbisComingListRequest(token, pageSize: "100", numberOfPage: "0")
        sbisAPIService.fetchComingList(request: request) { [weak self] result in
            switch result {
            case .success(let response):
                self?.documentsArray = response.result.document
                self?.view?.updateTableView(response.result.document)
                self?.dataSource?.updateModel(response)
            case .failure(let error):
                self?.view?.showErrorAlert(error)
            }
        }
    }
}

extension ComingViewPresenter: ComingViewPresenterProtocol {
    func viewDidLoad() {
        view?.configeActivityIndicator()
        guard let sbisToken = keychainService.fetch(for: .sbisSessionID) else {
            view?.updateTableView([])
            return
        }
        sendComingListRequest(sbisToken)
    }
    
    func didTabComingDocument(at index: Int) {
        let webPageViewController = moduleBuilder.buildWebPageViewController()
        webPageViewController.urlString = documentsArray[index].linkToPDF
        print(documentsArray[index].linkToPDF)
        //TODO: как осуществить передачу данных между контроллерами в стеке НавВЬю?
        self.view?.navigationController?.pushViewController(webPageViewController, animated: true)
    }
    //TODO:  можно ли посмотреть список запущенных функций до срабатывания какого либо БрейкПоинта?
    func logOutItemDidPress() {
        keychainService.deleteItem(for: .sbisSessionID)
        self.view?.updateTableView([])
        self.view?.navigationController?.pushViewController(moduleBuilder.buildSbisAuthViewController(), animated: true)
    }
}
