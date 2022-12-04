//
//  File.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 02.12.2022.
//

import Foundation

// MARK: - TochkaGetStatementResponse
struct TochkaGetStatementResponse: Codable {
    let data: DataClassTochkaGetStatement?
    let code, id, message: String?
    let errors: [TochkaError]?

    enum CodingKeys: String, CodingKey {
        case data = "Data"
        case code, id, message, errors
    }
}

// MARK: - DataClass
struct DataClassTochkaGetStatement: Codable {
    let statement: [StatementTochkaGetStatement]

    enum CodingKeys: String, CodingKey {
        case statement = "Statement"
    }
}

// MARK: - Statement
struct StatementTochkaGetStatement: Codable {
    let accountID, statementID, status, startDateTime: String
    let endDateTime: String
    let startDateBalance, endDateBalance: Double?
    let creationDateTime: String
    let transaction: [Transaction]?

    enum CodingKeys: String, CodingKey {
        case accountID = "accountId"
        case statementID = "statementId"
        case status, startDateTime, endDateTime, startDateBalance, endDateBalance, creationDateTime
        case transaction = "Transaction"
    }
}

// MARK: - Transaction
struct Transaction: Codable {
    let transactionID: String
    let creditDebitIndicator: CreditDebitIndicator
    let status: String
    let documentNumber: String
    let transactionTypeCode: String
    let documentProcessDate, transactionDescription: String
    let amount: AmountTochkaGetStatement
    let creditorParty: TorParty?
    let creditorAccount: TorAccount?
    let creditorAgent: TorAgent?
    let debtorParty: TorParty?
    let debtorAccount: TorAccount?
    let debtorAgent: TorAgent?

    enum CodingKeys: String, CodingKey {
        case transactionID = "transactionId"
        case creditDebitIndicator, status, documentNumber, transactionTypeCode, documentProcessDate
        case transactionDescription = "description"
        case amount = "Amount"
        case creditorParty = "CreditorParty"
        case creditorAccount = "CreditorAccount"
        case creditorAgent = "CreditorAgent"
        case debtorParty = "DebtorParty"
        case debtorAccount = "DebtorAccount"
        case debtorAgent = "DebtorAgent"
    }
}

// MARK: - Amount
struct AmountTochkaGetStatement: Codable {
    let amount, amountNat: Double
    let currency: Currency
}

enum Currency: String, Codable {
    case rub = "RUB"
}

enum CreditDebitIndicator: String, Codable {
    case credit = "Credit"
    case debit = "Debit"
}

// MARK: - TorAccount
struct TorAccount: Codable {
    let schemeName: CreditorAccountSchemeName
    let identification: String
}

enum CreditorAccountSchemeName: String, Codable {
    case ruCbrPan = "RU.CBR.PAN"
}

// MARK: - TorAgent
struct TorAgent: Codable {
    let schemeName, identification, accountIdentification, name: String
}

// MARK: - TorParty
struct TorParty: Codable {
    let inn, name: String
    let kpp: String?
}
