//
//  SbisAuthResponse.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 26.10.2022.
//

import Foundation

// MARK: - SbisAuthResponse
struct SbisAuthResponse: Codable {
    let jsonrpc: String
    let result: String?
    let id: Int
    let error: AuthError?
}

// MARK: - Error
struct AuthError: Codable {
    let code: Int
    let message, details: String
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let classid: String
    let addinfo: String?
}
