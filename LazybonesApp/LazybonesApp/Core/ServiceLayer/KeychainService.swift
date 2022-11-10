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
    func save(_ value: String, for key: KeychainWrapper.Key) throws -> Bool
    func fetch(_ value: String, for key: KeychainWrapper.Key) throws -> String?
    func deleteItem(_ value: String, for key: KeychainWrapper.Key) throws -> Bool
    func deleteAll() throws -> Bool
}

final class KeychainService{
    enum KeychainError: Error {
        case itemNotFound
        case duplicateItem
        case invalidItemFormat
        case unexpectedStatus(OSStatus)
    }
}
//TODO: Нужно ли отлавливать ошибки в сервисе?
extension KeychainService: KeychainServicable {
    func save(_ value: String, for key: KeychainWrapper.Key) throws -> Bool {
        return KeychainWrapper.standard.set(value, forKey: key.rawValue)
    }
    
    func fetch(_ value: String, for key: KeychainWrapper.Key) throws -> String? {
        return KeychainWrapper.standard.string(forKey: key.rawValue)
    }
    
    func deleteItem(_ value: String, for key: KeychainWrapper.Key) throws -> Bool {
        return KeychainWrapper.standard.removeObject(forKey: key.rawValue)
    }
    
    func deleteAll() throws -> Bool {
        return KeychainWrapper.standard.removeAllKeys()
    }
    
//    func saveCodable<T: Codable>(_ value: T, for key: KeychainWrapper.Key) throws -> Bool {
//        return KeychainWrapper.standard.set(
//    }
    

}

extension KeychainWrapper.Key {
    static let sbisSessionID = "X-SBISSessionID"
    static let sbisLogon = "Логин"
    static let sbisPassword = "Пароль"

}

/*
//MARK: - impliment required funcs with Security
extension KeychainService: KeychainServicable {
    func save(service: String, account: String, password: String) throws {
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account as AnyObject,
            kSecAttrService as String: service as AnyObject,
            kSecValueData as String: password as AnyObject
        ]
        let status = SecItemAdd(query as CFDictionary, nil)
        if status == errSecDuplicateItem {
            throw KeychainError.duplicateItem
        }
        guard status == errSecSuccess else {
            throw KeychainError.unexpectedStatus(status)
        }
    }
    
    func update(service: String, account: String, newPassword: String) throws {
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account as AnyObject,
            kSecAttrService as String: service as AnyObject
        ]
        let attributes: [String: AnyObject] = [
            kSecValueData as String: newPassword as AnyObject
        ]
        let status = SecItemUpdate(query as CFDictionary,
                                   attributes as CFDictionary)
        if status == errSecItemNotFound {
            throw KeychainError.itemNotFound
        }
        guard status == errSecSuccess else {
            throw KeychainError.unexpectedStatus(status)
        }
    }
    
    func getItem(service: String, account: String) throws -> Data {
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: account as AnyObject,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnData as String: kCFBooleanTrue
        ]
        var itemCopy: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary,
                                         &itemCopy)
        if status == errSecItemNotFound {
            throw KeychainError.itemNotFound
        }
        guard status == errSecSuccess else {
            throw KeychainError.unexpectedStatus(status)
        }
        guard let requestedItem = itemCopy as? Data else {
            throw KeychainError.invalidItemFormat
        }
        return requestedItem
    }
    
    func deleteItem(service: String, account: String) throws -> Void {
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account as AnyObject,
            kSecAttrService as String: service as AnyObject
        ]
        let status = SecItemDelete(query as CFDictionary)
        if status == errSecItemNotFound {
            throw KeychainError.itemNotFound
        }
        guard status == errSecSuccess else {
            throw KeychainError.unexpectedStatus(status)
        }
    }
}
*/
