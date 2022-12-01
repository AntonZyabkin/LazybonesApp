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
}

final class KeychainService{
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
    //TODO: как сделать метод для кодабл
//    func saveCodable<T: Codable>(_ value: T, for key: KeychainWrapper.Key) throws -> Bool {
//        return KeychainWrapper.standard.set(
//    }
}

extension KeychainWrapper {
    enum Keys: String {
        case sbisSessionID = "X-SBISSessionID"
        case sbisLogon = "Логин"
        case sbisPassword = "Пароль"
        case tochkaAccessToken = "accessToken"
        case tochkaJWT = "JWT"
    }
}
