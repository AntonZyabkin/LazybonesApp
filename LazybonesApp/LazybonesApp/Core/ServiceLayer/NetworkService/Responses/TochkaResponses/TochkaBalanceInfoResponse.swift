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
    let links: Links?
    let meta: Meta?
    let code, id, message: String?
    let errors: [BalanceError]?
    
    enum CodingKeys: String, CodingKey {
        case data = "Data"
        case links = "Links"
        case meta = "Meta"
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

struct BalanceError: Codable {
    let errorCode, message, url: String
}
