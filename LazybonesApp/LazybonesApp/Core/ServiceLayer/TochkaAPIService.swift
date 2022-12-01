//
//  TochkaAPIService.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 19.11.2022.
//

import Foundation

protocol TochkaAPIServicable {
    func getAccessToken(_ request: TochkaAccessTokenRequest, complition: @escaping (Result<TochkaAccessTokenResponse, Error>) -> Void)
    func createPermissionsList(_ request: TochkaPermissionsListRequest, complition: @escaping (Result<TochkaPermissionsListResponse, Error>) -> Void)
    func getBalanceInfo(_ request: TochkaBalanceRequest, complition: @escaping (Result<TochkaBalanceInfoResponse, Error>) -> Void)
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
    
    func createPermissionsList(_ request: TochkaPermissionsListRequest, complition: @escaping (Result<TochkaPermissionsListResponse, Error>) -> Void) {
        networkService.request(TochkaEndpoints.createPermissionsList(request: request), complition: complition)
    }
    
    func getBalanceInfo(_ request: TochkaBalanceRequest, complition: @escaping (Result<TochkaBalanceInfoResponse, Error>) -> Void) {
        networkService.request(TochkaEndpoints.getBalanceInfo(request: request), complition: complition)
    }
}
