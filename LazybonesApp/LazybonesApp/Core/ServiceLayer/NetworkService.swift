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
    func getData(url: String, complittion: @escaping (Result<[Any]?, Error>) -> Void)
}

final class NetworkService {}

extension NetworkService: Networkable {
    func request() {

    }
}

extension NetworkService: NetworkServiceProtocol {
    
    func getData(url: String, complittion: @escaping (Result<[Any]?, Error>) -> Void) {
        guard let url = URL(string: url) else {
            return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                complittion(.failure(error))
                return
            }
            
            do {
                if let obj = self.convertData(data: data!) {
                    complittion(.success(obj))
                }
            }
        }.resume()
    }
    
}
//MARK: - костыль
extension NetworkService {
    
    func convertData(data: Data) -> [Any]? {

        if let obj = try? JSONDecoder().decode([User].self, from: data) {
            return obj
        } else if let obj = try? JSONDecoder().decode([Comment].self, from: data) {
            return obj
        } else {
            let obj = try? JSONDecoder().decode([Post].self, from: data)
            return obj
        }
    }
}
