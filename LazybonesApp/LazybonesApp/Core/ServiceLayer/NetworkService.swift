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
    func getData<T>(url: String, complition: @escaping (Result<[T]?, Error>) -> Void) where T: Codable
}

final class NetworkService {}

extension NetworkService: Networkable {
    func request() {

    }
}

extension NetworkService: NetworkServiceProtocol {
    
    func getData<T>(url: String, complition: @escaping (Result<T?, Error>) -> Void) where T: Codable {
        guard let url = URL(string: url) else {
            return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                complition(.failure(error))
                return
            }
            do {
                let obj = try JSONDecoder().decode(T.self, from: data!)
                complition(.success(obj))
            } catch {
                print("error trying to convert data to JSON")
                complition(.failure(error))
            }
        }.resume()
    }
}
