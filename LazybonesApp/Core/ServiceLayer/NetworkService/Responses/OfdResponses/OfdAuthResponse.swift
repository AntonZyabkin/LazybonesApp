//
//  File.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 16.12.2022.
//

import Foundation

struct OfdAuthResponse: Codable {
    let authToken, expirationDateUTC: String

    enum CodingKeys: String, CodingKey {
        case authToken = "AuthToken"
        case expirationDateUTC = "ExpirationDateUtc"
    }
}
