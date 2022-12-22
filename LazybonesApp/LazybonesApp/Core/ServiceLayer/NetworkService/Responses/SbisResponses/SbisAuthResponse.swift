//
//  SbisAuthResponse.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 26.10.2022.
//

import Foundation

// MARK: - SbisAuthResponse Success
struct SbisAuthResponse: Codable {
    let jsonrpc: String
    let result: String?
    let id: String
    let error: AuthError?
}

// MARK: - Error
struct AuthError: Codable {
    let code: Int?
    let message, details, type: String?
    let data: DataClass?
}

// MARK: - DataClass
struct DataClass: Codable {
    let classid: String?
    let errorCode: Int?
    let addinfo: String?

    enum CodingKeys: String, CodingKey {
        case classid
        case errorCode = "error_code"
        case addinfo
    }
}


