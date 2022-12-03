//
//  TochkaInitStatementResponse.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 02.12.2022.
//

import Foundation

// MARK: - TochkaInitStatementResponse
struct TochkaInitStatementResponse: Codable {
    let data: DataClassInitStatementResponse?
    let code, id, message: String?
    let errors: [TochkaError]?

    enum CodingKeys: String, CodingKey {
        case data = "Data"
        case code, id, message
        case errors = "Errors"
    }
}

// MARK: - DataClass
struct DataClassInitStatementResponse: Codable {
    let statement: StatementInitStatementResponse

    enum CodingKeys: String, CodingKey {
        case statement = "Statement"
    }
}

// MARK: - Statement
struct StatementInitStatementResponse: Codable {
    let accountID, statementID, status, startDateTime: String
    let endDateTime, creationDateTime: String

    enum CodingKeys: String, CodingKey {
        case accountID = "accountId"
        case statementID = "statementId"
        case status, startDateTime, endDateTime, creationDateTime
    }
}
