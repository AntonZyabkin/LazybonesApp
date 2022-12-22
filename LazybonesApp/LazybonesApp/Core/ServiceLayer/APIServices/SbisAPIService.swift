//
//  APIService.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 17.10.2022.
//

import Foundation
import Moya

protocol SbisAuthApiServicable {
    func sendAuthRequest(request: SbisAuthRequest , complition: @escaping (Result<SbisAuthResponse, Error>) -> Void)
}

protocol SbisApiServicable {
    func fetchComingList(request: SbisComingListRequest, complition: @escaping (Result<SbisShortComingListResponse, Error>) -> Void)
}

final class SbisAPIService{
    private let networkService: Networkable

    init(networkService: Networkable) {
        self.networkService = networkService
    }
}

extension SbisAPIService: SbisAuthApiServicable {
    func sendAuthRequest(request: SbisAuthRequest, complition: @escaping (Result<SbisAuthResponse, Error>) -> Void) {
        networkService.request(SbisEndpoints.sbisAuth(request: request), complition: complition)
    }

}

extension SbisAPIService: SbisApiServicable {
    func fetchComingList(request: SbisComingListRequest, complition: @escaping (Result<SbisShortComingListResponse, Error>) -> Void) {
        networkService.request(SbisEndpoints.fetchSbisComingList(request: request), complition: complition)
    }
}
