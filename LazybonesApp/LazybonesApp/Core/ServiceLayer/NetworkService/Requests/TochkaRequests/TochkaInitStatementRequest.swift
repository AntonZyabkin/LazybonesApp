//
//  TochkaInitStatementRequest.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 02.12.2022.
//

import Foundation

// MARK: - TochkaInitStatementRequest
struct TochkaInitStatementRequest {
    let body: TochkaInitStatementData
    let JWT: String
    
    init(JWT:String, accountID: String, startDateTime: String, endDateTime: String) {
        self.JWT = JWT
        self.body = TochkaInitStatementData(
            data: DataClassInitStatement(
                statement: Statement(
                    accountID: accountID,
                    startDateTime: startDateTime,
                    endDateTime: endDateTime
                )
            )
        )
    }
    enum CodingKeys: String, CodingKey {
        case JWT, data
    }
}

struct TochkaInitStatementData: Codable {
    let data: DataClassInitStatement
    
    enum CodingKeys: String, CodingKey {
        case data = "Data"
    }
}

// MARK: - DataClass
struct DataClassInitStatement: Codable {
    let statement: Statement
    
    enum CodingKeys: String, CodingKey {
        case statement = "Statement"
    }
}

// MARK: - Statement
struct Statement: Codable {
    let accountID, startDateTime, endDateTime: String
    
    enum CodingKeys: String, CodingKey {
        case accountID = "accountId"
        case startDateTime, endDateTime
    }
}

extension TochkaInitStatementData {
    func asParameters() -> [String: Any] {
        var bodyDict: [String: Any] = [:]
        do {
            bodyDict = try self.asDictionary()
        } catch let error {
            print(error.localizedDescription)
        }
        return bodyDict
    }
}

