//
//  ofdAPIService.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 16.12.2022.
//

import Foundation

protocol OfdAPIServicable {
    func sendAuthRequest(request: OfdAuthRequest, complition: @escaping (Result<OfdAuthResponse, Error>) -> Void)
    func gerReportsRequest(request: OfdGetReportsRequest, complition: @escaping (Result<Welcome, Error>) -> Void)
}

final class OfdAPIService{
    private let networkService: Networkable

    init(networkService: Networkable) {
        self.networkService = networkService
    }
}

extension OfdAPIService: OfdAPIServicable {
    func sendAuthRequest(request: OfdAuthRequest, complition: @escaping (Result<OfdAuthResponse, Error>) -> Void) {
        networkService.request(OfdEndpoints.ofdAuth(request: request), complition: complition)
    }
    
    func gerReportsRequest(request: OfdGetReportsRequest, complition: @escaping (Result<Welcome, Error>) -> Void) {
        networkService.request(OfdEndpoints.fetch(request: request), complition: complition)
    }
}
