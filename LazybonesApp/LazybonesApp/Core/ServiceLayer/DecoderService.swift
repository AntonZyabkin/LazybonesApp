//
//  DecoderService.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 17.10.2022.
//

import Foundation


protocol DecoderServicable{
    func decode<T: Decodable>(_ data: Data, complition: @escaping (Result<T, Error>) -> Void)
}

final class DecoderService{
    private let jsonDecoder = JSONDecoder()
}

extension DecoderService: DecoderServicable {
    func decode<T: Decodable>(_ data: Data, complition: @escaping (Result<T, Error>) -> Void) {
        DispatchQueue.global(qos: .utility).async {
            do {
                let result = try self.jsonDecoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    complition(.success(result))
                }
            } catch  {
                DispatchQueue.main.async {
                    complition(.failure(error))
                }
            }
        }
    }
}
