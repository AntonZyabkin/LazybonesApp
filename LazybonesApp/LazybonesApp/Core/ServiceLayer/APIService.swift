//
//  APIService.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 17.10.2022.
//

import Foundation

protocol APIServicable {
    func fetchPosts(complition: @escaping (Result<[Post], Error>) -> Void)
    func fetchComments(complition: @escaping (Result<[Comment], Error>) -> Void)
    func fetchUsers(complition: @escaping (Result<[User], Error>) -> Void)
    var method: Action { get }
}

final class APIService{
    private let netwokkService: Networkable
    let method: Action

    init(netwokkService: Networkable, method: Action) {
        self.netwokkService = netwokkService
        self.method = method
    }
}

extension APIService: APIServicable {
    func fetchPosts(complition: @escaping (Result<[Post], Error>) -> Void) {
        netwokkService.requestMoya(method, complition: complition)
    }
    
    func fetchComments(complition: @escaping (Result<[Comment], Error>) -> Void) {
        netwokkService.requestMoya(method, complition: complition)
    }

    func fetchUsers(complition: @escaping (Result<[User], Error>) -> Void) {
        netwokkService.requestMoya(method, complition: complition)
    }
}
