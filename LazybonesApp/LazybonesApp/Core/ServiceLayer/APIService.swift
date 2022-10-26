//
//  APIService.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 17.10.2022.
//

import Foundation
import Moya

protocol APIServicable {
    func fetchPosts(complition: @escaping (Result<[Post], Error>) -> Void)
    func fetchComments(complition: @escaping (Result<[Comment], Error>) -> Void)
    func fetchUsers(complition: @escaping (Result<[User], Error>) -> Void)
    func fetchComingList(complition: @escaping (Result<SbisComingListResponse, Error>) -> Void)
    var target: TargetType { get }
}

final class APIService{
    private let networkService: Networkable
    let target: TargetType

    init(networkService: Networkable, target: TargetType) {
        self.networkService = networkService
        self.target = target
    }
}

extension APIService: APIServicable {
    func fetchPosts(complition: @escaping (Result<[Post], Error>) -> Void) {
        networkService.request(target, complition: complition)
    }
    
    func fetchComments(complition: @escaping (Result<[Comment], Error>) -> Void) {
        networkService.request(target, complition: complition)
    }

    func fetchUsers(complition: @escaping (Result<[User], Error>) -> Void) {
        networkService.request(target, complition: complition)
    }
    func fetchComingList(complition: @escaping (Result<SbisComingListResponse, Error>) -> Void) {
        networkService.request(target, complition: complition)
    }
}
