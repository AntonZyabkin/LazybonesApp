//
//  DecoderService.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 17.10.2022.
//

import Foundation


protocol DecoderServicable{
    func decode<T: Decodable>(_ data: Data, complition: @escaping (Result<T, Error>) -> Void)
    func encode<T: Encodable>(_ data: T, complition: @escaping (Result<Data, Error>) -> Void)
}

final class DecoderService{
    private let jsonDecoder = JSONDecoder()
    private let jsonEncoder = JSONEncoder()
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
    
    func encode<T: Encodable>(_ data: T, complition: @escaping (Result<Data, Error>) -> Void) {
        DispatchQueue.global(qos: .utility).async {
            do {
                let result = try self.jsonEncoder.encode(data)
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
