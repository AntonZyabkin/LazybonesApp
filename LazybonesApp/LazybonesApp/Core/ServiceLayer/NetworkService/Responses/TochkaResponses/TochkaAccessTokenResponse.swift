//
//  TochkaAccessTokenResponse.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 19.11.2022.
//

import Foundation

struct TochkaAccessTokenResponse: Codable {
    let tokenType, state, accessToken: String?
    let expiresIn: Int?
    let error: String?
    let errorDescription: String?

    enum CodingKeys: String, CodingKey {
        case tokenType = "token_type"
        case state
        case accessToken = "access_token"
        case expiresIn = "expires_in"
        case error
        case errorDescription = "error_description"
    }
}

