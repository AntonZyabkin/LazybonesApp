//
//  TochkaAccessTokenRequest.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 19.11.2022.
//

import Foundation


struct TochkaAccessTokenRequest: Codable {
    
    init(_ clientId: String, clientSecret: String) {
        self.clientId = clientId
        self.clientSecret = clientSecret
    }
    
    let clientId: String
    let clientSecret: String
    let grantType: String = "client_credentials"
    let scope: String = "accounts balances customers statements cards sbp payments special"
    let state: String = "qwe"

    enum CodingKeys: String, CodingKey {
        case clientId = "client_id"
        case clientSecret = "client_secret"
        case grantType = "grant_type"
        case scope
        case state
    }
}

extension TochkaAccessTokenRequest {
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
