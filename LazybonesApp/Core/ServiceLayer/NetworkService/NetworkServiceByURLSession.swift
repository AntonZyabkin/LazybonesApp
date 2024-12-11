//
//  NetworkServiceByURLSession.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 06.01.2023.
//

import Foundation

protocol NetworkServicerPotocol {
    func request<T>(_ request: Urlable, complition: @escaping (Result<T, Error>) -> Void) where T: Decodable
    
}

final class NetworkServiceByURLSession {
    private let decoderService: DecoderServicable
    init(decoderService: DecoderServicable) {
        self.decoderService = decoderService
    }
}

extension NetworkServiceByURLSession: NetworkServicerPotocol {
    func request<T>(_ request: Urlable, complition: @escaping (Result<T, Error>) -> Void) where T: Decodable {
        func complitionHandler(_ result: Result<T, Error>) {
            DispatchQueue.main.async {
                complition(result)
            }
        }
        DispatchQueue.global(qos: .userInitiated).async {  [weak self] in
            guard let self = self else {
                return
            }
            guard let url = URL(string: request.urlString) else { return }
            let urlRequest = URLRequest(url: url)
            URLSession.shared.dataTask(with: urlRequest, completionHandler: { data, response, error in
                if let error = error {
                    complition(.failure(error))
                }
                if let data = data {
					var prettyPrintedJSONString: NSString? { /// NSString gives us a nice sanitized debugDescription
						guard let object = try? JSONSerialization.jsonObject(with: data, options: []),
							  let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
							  let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }

						return prettyPrintedString
					}
                    self.decoderService.decode(data, complition: complition)
                }
            }).resume()
        }
    }
}
