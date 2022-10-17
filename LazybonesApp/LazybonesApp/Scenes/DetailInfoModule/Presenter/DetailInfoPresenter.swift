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
        apiService.fetchPosts { [weak self] result in
            switch result {
            case .success(let response):
                print(response.count, response.first)
                self?.view?.succes()
            case .failure(let error):
                print(error, error.localizedDescription)
            }
        }
    }
}
