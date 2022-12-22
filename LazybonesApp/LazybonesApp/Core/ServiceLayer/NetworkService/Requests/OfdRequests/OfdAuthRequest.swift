//
//  OfdAuthRequest.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 16.12.2022.
//

import Foundation

struct OfdAuthRequest: Codable {
    let login, password: String

    enum CodingKeys: String, CodingKey {
        case login = "Login"
        case password = "Password"
    }
}
