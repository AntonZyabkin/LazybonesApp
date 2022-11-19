//
//  TochkaAPIService.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 19.11.2022.
//

import Foundation

protocol TochkaAPIServicable {
    func getAccessToken(_ request: TochkaAccessTokenRequest, complition: @escaping (Result<TochkaAccessTokenResponse, Error>) -> Void)
}

final class TochkaAPIService{
    private let networkService: Networkable

    init(networkService: Networkable) {
        self.networkService = networkService
    }
}

extension TochkaAPIService: TochkaAPIServicable {
    func getAccessToken(_ request: TochkaAccessTokenRequest, complition: @escaping (Result<TochkaAccessTokenResponse, Error>) -> Void) {
        networkService.request(TochkaEndpoints.getTochkaAccessToken(request: request), complition: complition)
    }
}
