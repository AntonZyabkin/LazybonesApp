//
//  KeychainService.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 01.11.2022.
//

import Foundation
import Security
import SwiftKeychainWrapper

protocol KeychainServicable {
    func save(_ value: String, for key: KeychainWrapper.Keys) -> Bool
    func fetch(for key: KeychainWrapper.Keys) -> String?
    func deleteItem(for key: KeychainWrapper.Keys) -> Bool
    func deleteAll() -> Bool
    func saveCodable<T: Codable>(_ value: T, for key: String) -> Bool
    func fetchTochkaPaymentForSignRequest(key: String, complition: @escaping (Result<TochkaPaymentForSignRequest, Error>) -> Void)
}

final class KeychainService{
    
    let decoder: DecoderServicable
    
    init(decoder: DecoderServicable) {
        self.decoder = decoder
    }
    enum KeychainError: Error {
        case itemNotFound
        case duplicateItem
        case invalidItemFormat
        case unexpectedStatus(OSStatus)
    }
}
//TODO: Нужно ли отлавливать ошибки в сервисе (если действие невозможно)?
extension KeychainService: KeychainServicable {
    func save(_ value: String, for key: KeychainWrapper.Keys) -> Bool {
        return KeychainWrapper.standard.set(value, forKey: key.rawValue)
    }
    
    func fetch(for key: KeychainWrapper.Keys) -> String? {
        return KeychainWrapper.standard.string(forKey: key.rawValue)
    }
    
    func deleteItem(for key: KeychainWrapper.Keys) -> Bool {
        return KeychainWrapper.standard.removeObject(forKey: key.rawValue)
    }
    
    func deleteAll() -> Bool {
        return KeychainWrapper.standard.removeAllKeys()
    }

    func saveCodable<T: Codable>(_ value: T, for key: String) -> Bool {
        var status: Bool = false
        decoder.encode(value) { result in
            switch result {
            case .success(let resunt):
                status = KeychainWrapper.standard.set(resunt, forKey: key)
            case .failure(let error):
                print(error)
                status = false
            }
        }
        return status
    }
    
    private func fetchCodable<T>(for key: String, complition: @escaping (Result<T, Error>) -> Void) where T: Decodable {
        if let data = KeychainWrapper.standard.data(forKey: key) {
            decoder.decode(data, complition: complition)
        } else {
            print("no data by that INN")
        }
    }
    
    func fetchTochkaPaymentForSignRequest(key: String, complition: @escaping (Result<TochkaPaymentForSignRequest, Error>) -> Void) {
        fetchCodable(for: key, complition: complition)
    }
    
}

extension KeychainWrapper {
    enum Keys: String {
        case sbisSessionID = "X-SBISSessionID"
        case sbisLogon = "Логин"
        case sbisPassword = "Пароль"
        case tochkaAccessToken = "accessToken"
        case tochkaJWT = "JWT"
        case lastPaymentDate = "lastPaymentDate"
        case tochkaAccountID = "accountID"
    }
}
