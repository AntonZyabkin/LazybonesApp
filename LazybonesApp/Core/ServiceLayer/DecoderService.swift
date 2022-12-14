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
    //TODO: пришлось откзаться от перевода на другой поток работу Кодера, т.к. результат возвращается в неожиданное время
    func decode<T: Decodable>(_ data: Data, complition: @escaping (Result<T, Error>) -> Void) {
        do {
            let result = try self.jsonDecoder.decode(T.self, from: data)
            complition(.success(result))
        } catch  {
            complition(.failure(error))
        }
    }
    
    func encode<T: Encodable>(_ data: T, complition: @escaping (Result<Data, Error>) -> Void) {
        do {
            let result = try self.jsonEncoder.encode(data)
            complition(.success(result))
        } catch  {
            complition(.failure(error))
        }
    }
    
}
