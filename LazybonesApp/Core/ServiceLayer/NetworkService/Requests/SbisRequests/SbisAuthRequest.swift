//
//  SbisAuthRequest.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 26.10.2022.
//

import Foundation

struct SbisAuthRequest: Codable {
    let body: SbisAuthBody
    
    init(_ login: String, _ password: String) {
        self.body = SbisAuthBody(params: Params(parameter: Parameter(login: login, password: password)))
    }
}
struct SbisAuthBody: Codable {
    let jsonrpc: String = "2.0"
    let method: String = "СБИС.Аутентифицировать"
    let params: Params
    let id: String = "0"
    
    enum CodingKeys: String, CodingKey {
        case jsonrpc
        case method
        case params
        case id
    }
}

// MARK: - Params
struct Params: Codable {
    let parameter: Parameter

    enum CodingKeys: String, CodingKey {
        case parameter = "Параметр"
    }
}

// MARK: - Parameter
struct Parameter: Codable {
    let login, password: String

    enum CodingKeys: String, CodingKey {
        case login = "Логин"
        case password = "Пароль"
    }
}
