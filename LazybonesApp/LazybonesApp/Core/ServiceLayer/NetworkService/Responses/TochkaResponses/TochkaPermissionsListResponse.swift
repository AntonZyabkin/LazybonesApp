//
//  TochkaPermissionsListResponse.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 19.11.2022.
//

import Foundation
// MARK: - Welcome
struct TochkaPermissionsListResponse: Codable {
    let data: DataClassResponse
    let links: Links
    let meta: Meta

    enum CodingKeys: String, CodingKey {
        case data = "Data"
        case links = "Links"
        case meta = "Meta"
    }
}

// MARK: - DataClass
struct DataClassResponse: Codable {
    let status, creationDateTime, statusUpdateDateTime: String
    let permissions: [String]
    let consentID, consumerID: String

    enum CodingKeys: String, CodingKey {
        case status, creationDateTime, statusUpdateDateTime, permissions
        case consentID = "consentId"
        case consumerID = "consumerId"
    }
}

// MARK: - Links
struct Links: Codable {
    let linksSelf: String

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
    }
}

// MARK: - Meta
struct Meta: Codable {
    let totalPages: Int
}
