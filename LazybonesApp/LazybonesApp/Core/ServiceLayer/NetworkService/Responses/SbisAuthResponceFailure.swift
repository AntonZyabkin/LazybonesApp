//
//  SbisAuthResponceFailure.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 16.11.2022.
//

import Foundation
// MARK: - Welcome
struct Welcome: Codable {
    let jsonrpc: String
    let error: Error2
    let id: Int
    let result: String?
}

// MARK: - Error
struct Error2: Codable {
    let code: Int
    let message, details, type: String
    let data: DataClass2
}

// MARK: - DataClass
struct DataClass2: Codable {
    let classid: String
    let errorCode: Int
    let addinfo: String?

    enum CodingKeys: String, CodingKey {
        case classid
        case errorCode = "error_code"
        case addinfo
    }
}
