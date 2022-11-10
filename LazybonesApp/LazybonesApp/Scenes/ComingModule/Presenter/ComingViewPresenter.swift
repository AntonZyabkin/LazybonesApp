//
//  ComingViewPresenter.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 25.10.2022.
//

import Foundation

protocol ComingViewPresenterProtocol{
    func downloadComingData()
}

final class ComingViewPresenter {
    weak var view: ComingInfoViewProtocol?
    
    let sbisAPIService: SbisApiServicable
    
    init(sbisAPIService: SbisApiServicable) {
        self.sbisAPIService = sbisAPIService
    }
}

extension ComingViewPresenter: ComingViewPresenterProtocol {
    func downloadComingData() {
        let request = SbisComingListRequest(body: SbisComingListBodyRequest())
        sbisAPIService.fetchComingList(request: request) { result in
            guard let view = self.view else { return }
            switch result {
            case .success(let response):
                view.succes(response)
            case .failure(let error):
                view.failure(error: error)
            }
        }
    }
}
