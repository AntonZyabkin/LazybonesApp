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

    enum CodingKeys: String, CodingKey {
        case data = "Data"
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
