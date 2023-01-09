//
//  ofdAPIService.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 16.12.2022.
//

import Foundation

protocol OfdAPIServicable {
    func sendAuthRequest(request: OfdAuthRequest, complition: @escaping (Result<OfdAuthResponse, Error>) -> Void)
    func gerReportsRequest(request: OfdGetReportsRequest, complition: @escaping (Result<OfdGetReportsResponse, Error>) -> Void)
}

final class OfdAPIService{
    private let networkService: Networkable
    private let networkServiceByURLSession: NetworkServicerPotocol


    init(networkService: Networkable, networkServiceByURLSession: NetworkServicerPotocol) {
        self.networkService = networkService
        self.networkServiceByURLSession = networkServiceByURLSession

    }
}

extension OfdAPIService: OfdAPIServicable {
    func sendAuthRequest(request: OfdAuthRequest, complition: @escaping (Result<OfdAuthResponse, Error>) -> Void) {
        networkService.request(OfdEndpoints.ofdAuth(request: request), complition: complition)
    }
    
    func gerReportsRequest(request: OfdGetReportsRequest, complition: @escaping (Result<OfdGetReportsResponse, Error>) -> Void) {
        networkServiceByURLSession.request(request, complition: complition)
    }
}
