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
    private let networkService: Networkable
    let method: Action

    init(networkService: Networkable, method: Action) {
        self.networkService = networkService
        self.method = method
    }
}

extension APIService: APIServicable {
    func fetchPosts(complition: @escaping (Result<[Post], Error>) -> Void) {
        networkService.request(method, complition: complition)
    }
    
    func fetchComments(complition: @escaping (Result<[Comment], Error>) -> Void) {
        networkService.request(method, complition: complition)
    }

    func fetchUsers(complition: @escaping (Result<[User], Error>) -> Void) {
        networkService.request(method, complition: complition)
    }
}
