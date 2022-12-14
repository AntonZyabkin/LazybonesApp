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
    func initStatement(_ request: TochkaInitStatementRequest, complition: @escaping (Result<TochkaInitStatementResponse, Error>) -> Void)
    func getStatement(_ request: TochkaGetStatementRequest, complition: @escaping (Result<TochkaGetStatementResponse, Error>) -> Void)
    func createPaymentForSign(_ request: TochkaPaymentForSignRequest, complition: @escaping (Result<TochkaPaymentForSignResponse, Error>) -> Void)
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
    
    func initStatement(_ request: TochkaInitStatementRequest, complition: @escaping (Result<TochkaInitStatementResponse, Error>) -> Void) {
        networkService.request(TochkaEndpoints.initStatement(request: request), complition: complition)
    }
    
    func getStatement(_ request: TochkaGetStatementRequest, complition: @escaping (Result<TochkaGetStatementResponse, Error>) -> Void) {
        networkService.request(TochkaEndpoints.getStatement(request: request), complition: complition)
    }
    func createPaymentForSign(_ request: TochkaPaymentForSignRequest, complition: @escaping (Result<TochkaPaymentForSignResponse, Error>) -> Void) {
        networkService.request(TochkaEndpoints.createPaymentForSign(request: request), complition: complition)
    }
}
