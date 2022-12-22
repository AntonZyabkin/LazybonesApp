//
//  TochkaPaymentForSignResponse.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 05.12.2022.
//

import Foundation

struct TochkaPaymentForSignResponse: Codable {
    
    let data: DataClassPaymentForSignResponse?
    let code, id, message: String?
    let errors: [TochkaError]?
    
    enum CodingKeys: String, CodingKey {
        case data = "Data"
        case code, id, message, errors
    }
}

// MARK: - DataClass
struct DataClassPaymentForSignResponse: Codable {
    let requestID: String

    enum CodingKeys: String, CodingKey {
        case requestID = "requestId"
    }
}
