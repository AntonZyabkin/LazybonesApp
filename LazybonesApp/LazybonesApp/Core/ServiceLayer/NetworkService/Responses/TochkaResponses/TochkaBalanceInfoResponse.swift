//
//  TochkaBalanceInfoResponse.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 26.11.2022.
//

import Foundation

// MARK: - TochkaBalanceInfoResponse
struct TochkaBalanceInfoResponse: Codable {
    let data: BalanceDataClass?
    let code, id, message: String?
    let errors: [TochkaError]?
    
    enum CodingKeys: String, CodingKey {
        case data = "Data"
        case code, id, message
        case errors = "Errors"
    }
}

// MARK: - DataClass
struct BalanceDataClass: Codable {
    let balance: [Balance]

    enum CodingKeys: String, CodingKey {
        case balance = "Balance"
    }
}

// MARK: - Balance
struct Balance: Codable {
    let accountID, creditDebitIndicator, type, dateTime: String
    let amount: Amount

    enum CodingKeys: String, CodingKey {
        case accountID = "accountId"
        case creditDebitIndicator, type, dateTime
        case amount = "Amount"
    }
}

// MARK: - Amount
struct Amount: Codable {
    let amount: Double
    let currency: String
}

struct TochkaError: Codable {
    let errorCode, message, url: String
}
