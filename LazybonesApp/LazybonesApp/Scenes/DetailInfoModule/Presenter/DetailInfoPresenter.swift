//
//  DetainInfoPresenter.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 09.10.2022.
//

import Foundation

private let urlArray = ["https://jsonplaceholder.typicode.com/posts",
                        "https://jsonplaceholder.typicode.com/users",
                        "https://jsonplaceholder.typicode.com/comments"]

protocol DetailInfoViewProtocol: AnyObject {
    
    func succes()
    func failure(error: Error)
}

protocol DetailInfoViewPresenterProtocol {
    
    init(view: DetailInfoViewProtocol, networkService: NetworkServiceProtocol, didSelectURL: Int)
    func getDataArray()
    var data: [Codable]? { get set }
}

class DetailInfoPresenter: DetailInfoViewPresenterProtocol {

    
    weak var view: DetailInfoViewProtocol?
    let networkService: NetworkServiceProtocol!
    var didSelectURL: Int!
    var data: [Codable]?

    required init(view: DetailInfoViewProtocol, networkService: NetworkServiceProtocol, didSelectURL: Int) {
        self.view = view
        self.networkService = networkService
        self.didSelectURL = didSelectURL
    }
    
    
    //MARK: - Тупой костыль((
    func getDataArray() {
        switch didSelectURL {
        case 0:
            networkService.getData(url: urlArray[didSelectURL]){ [weak self] (result: Result< [Post]?, Error>) in
                guard let self = self else { return }
                switch result {
                case .success(let data):
                    self.data = data
                    self.view?.succes()
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        case 1:
            networkService.getData(url: urlArray[didSelectURL]){ [weak self] (result: Result< [User]?, Error>) in
                guard let self = self else { return }
                switch result {
                case .success(let data):
                    self.data = data
                    self.view?.succes()
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        case 2:
            networkService.getData(url: urlArray[didSelectURL]){ [weak self] (result: Result< [Comment]?, Error>) in
                guard let self = self else { return }
                switch result {
                case .success(let data):
                    self.data = data
                    self.view?.succes()
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        default: break
        }

    }
    
}
