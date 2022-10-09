//
//  NetworkService.swift
//  LazybonesApp
//
//  Created by Игорь Дикань on 08.10.2022.
//

import Foundation

protocol Networkable {
    func request()
}

protocol NetworkServiceProtocol {
    func getData(url: String, complittion: @escaping (Result<[User]?, Error>) -> Void)
}

final class NetworkService {}

extension NetworkService: Networkable {
    func request() {
        print("make request")
    }
}

extension NetworkService: NetworkServiceProtocol {
    
    func getData(url: String, complittion: @escaping (Result<[User]?, Error>) -> Void) {
        guard let url = URL(string: url) else {
            return }
        
        URLSession.shared.dataTask(with: url) { data, responce, error in
            if let error = error {
                complittion(.failure(error))
                return
            }
            
            do {
                let obj = try JSONDecoder().decode([User].self, from: data!)
                complittion(.success(obj))
            } catch {
                complittion(.failure(error))
            }
        }
    }
    
}

