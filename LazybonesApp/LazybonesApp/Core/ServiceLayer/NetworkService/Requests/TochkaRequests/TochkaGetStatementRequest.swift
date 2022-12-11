//
//  TochkaGetStatementRequest.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 03.12.2022.
//

import Foundation

struct TochkaGetStatementRequest: Codable {
    
    let statementId, accountId, jwt: String
    
    init(statementId: String, accountId: String, jwt: String) {
        self.statementId = statementId
        self.accountId = accountId
        self.jwt = jwt
    }
    enum CodingKeys: String, CodingKey {
        case statementId, accountId, jwt
    }
}
