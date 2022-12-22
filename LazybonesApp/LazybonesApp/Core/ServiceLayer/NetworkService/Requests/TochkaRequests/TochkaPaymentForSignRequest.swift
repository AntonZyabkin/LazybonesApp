//
//  TochkaPaymentForSignRequest.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 05.12.2022.
//

import Foundation

// MARK: - TochkaPaymentForSignRequest
struct TochkaPaymentForSignRequest: Codable  {
    
    var jwt: String
    var body: TochkaPaymentForSignBodyRequest
}

struct TochkaPaymentForSignBodyRequest: Codable {
    var data: DataClasPaymentForSign
    
    enum CodingKeys: String, CodingKey {
        case data = "Data"
    }
}

// MARK: - DataClass
struct DataClasPaymentForSign: Codable {
    var accountCode, bankCode, counterpartyBankBic, counterpartyAccountNumber: String
    var counterpartyINN, counterpartyName, paymentAmount, paymentDate: String
    var paymentNumber, paymentPurpose: String
}
