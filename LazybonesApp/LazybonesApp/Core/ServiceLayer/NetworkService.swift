//
//  NetworkService.swift
//  LazybonesApp
//
//  Created by Игорь Дикань on 08.10.2022.
//

import Foundation
import Moya


protocol Networkable {
//    func request<T: Decodable>(urlstring: String, complition: @escaping (Result<T, Error>) -> Void)
    func requestMoya<T: Decodable>(_ method: DetailInfoDataService, complition: @escaping (Result<T, Error>) -> Void)
}

final class NetworkService {
    private let decoderService: DecoderServicable
    init(decoderService: DecoderServicable) {
        self.decoderService = decoderService
    }
}

enum NetworkError: Error {
    case urlError
    case responseError
    case dataError
    case unknownError
}

extension NetworkService: Networkable {
    
    //MARK: - MoyaProvider method
    func requestMoya<T: Decodable>(_ method: DetailInfoDataService, complition: @escaping (Result<T, Error>) -> Void) {
        func complitionHandler(_ result: Result<T, Error>) {
            DispatchQueue.main.async {
                complition(result)
            }
        }
        DispatchQueue.global(qos: .utility).async {
            MoyaProvider<DetailInfoDataService>().request(method) { [weak self] result in
                switch result {
                case .failure(let error):
                    complition(.failure(error))
                case .success(let response):
                    guard let urlResponse = response.response else {
                        let error = NetworkError.responseError
                        complitionHandler(.failure(error))
                        return
                    }
                    switch urlResponse.statusCode {
                    case 200...210:
                        self?.decoderService.decode(response.data, complition: complition)
                    case 401:
                        //do something
                        break
                    default:
                        let error = NetworkError.unknownError
                        complitionHandler(.failure(error))
                        return
                    }
                }
            }
        }
    }
    
    //MARK: - URLSession method
    /*
    func request<T: Decodable>(urlstring: String, complition: @escaping (Result<T, Error>) -> Void) {
        func complitionHandler(_ result: Result<T, Error>) {
            DispatchQueue.main.async {
                complition(result)
            }
        }
        DispatchQueue.global(qos: .utility).async {
            guard let url = URL(string: urlstring) else {
                let error = NetworkError.urlError
                complitionHandler(.failure(error))
                return
            }
            let request = URLRequest(url: url)
            URLSession.shared.dataTask(with: request) { [weak self] data, urlResponse, error in
                if let error = error {
                    complition(.failure(error))
                }
                guard let urlResponse = urlResponse as? HTTPURLResponse else {
                    let error = NetworkError.responseError
                    complitionHandler(.failure(error))
                    return
                }
                switch urlResponse.statusCode {
                case 200...210:
                    guard let data = data else {
                        let error = NetworkError.dataError
                        complitionHandler(.failure(error))
                        return
                    }
                    self?.decoderService.decode(data, complition: complition)
                case 401:
                    //do something
                    break
                default:
                    let error = NetworkError.unknownError
                    complitionHandler(.failure(error))
                    return
                }
            }.resume()
        }
    }
    */
}
