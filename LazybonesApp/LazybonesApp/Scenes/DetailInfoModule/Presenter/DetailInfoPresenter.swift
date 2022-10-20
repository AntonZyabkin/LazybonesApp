//
//  DetainInfoPresenter.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 09.10.2022.
//

import Foundation

protocol DetailInfoViewPresenterProtocol {
    func viewDidLoad()
}

final class DetailInfoPresenter {
    weak var view: DetailInfoViewProtocol?
    let apiService: APIServicable
     init(apiService: APIServicable) {
        self.apiService = apiService
    }
}

extension DetailInfoPresenter: DetailInfoViewPresenterProtocol {
    func viewDidLoad() {
        func parseResult<T: Decodable>(result: Result<[T], Error>) {
            switch result {
            case .success(let response):
                self.view?.succes(response)
            case .failure(let error):
                self.view?.failure(error: error)
            }
        }
        switch apiService.method {
        case .Post:
            apiService.fetchPosts() { result in
                parseResult(result: result)
            }
        case .User:
            apiService.fetchUsers() { result in
                parseResult(result: result)
            }
        case .Comment:
            apiService.fetchComments() { result in
                parseResult(result: result)
            }
        }
        
    }
}
