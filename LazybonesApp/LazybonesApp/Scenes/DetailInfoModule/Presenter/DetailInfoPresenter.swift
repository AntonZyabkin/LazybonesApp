//
//  DetainInfoPresenter.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 09.10.2022.
//

import Foundation


protocol DetailInfoViewProtocol: AnyObject {
    
    func succes()
    func failure(error: Error)
}

protocol DetailInfoViewPresenterProtocol {
    
    init(view: DetailInfoViewProtocol, networkService: NetworkServiceProtocol, didSelectedURL: String)
    func getDataArray()
    var dataArray: [Any]? { get set }
}

class DetailInfoPresenter: DetailInfoViewPresenterProtocol {
    
    weak var view: (DetailInfoViewProtocol)?
    let networkService: NetworkServiceProtocol!
    let didSelectedURL: String!
    var dataArray: [Any]?

    required init(view: DetailInfoViewProtocol, networkService: NetworkServiceProtocol, didSelectedURL: String) {
        self.view = view
        self.networkService = networkService
        self.didSelectedURL = didSelectedURL
        getDataArray()
    }
    
    func getDataArray() {
        networkService.getData(url: didSelectedURL) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let dataArray):
                self.dataArray = dataArray
                self.view?.succes()
            case .failure(let error):
                self.view?.failure(error: error)
            }
        }
    }
    
}
