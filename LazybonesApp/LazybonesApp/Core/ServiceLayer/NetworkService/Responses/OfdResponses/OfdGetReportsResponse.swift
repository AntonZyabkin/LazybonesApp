//
//  File.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 16.12.2022.
//

import Foundation

// MARK: - Welcome
//struct OfdGetReportsResponse: Codable {
//    let status: String?
//    let data: [Datum]?
//    let errors: [String]?
//    let message: String?
//
//    enum CodingKeys: String, CodingKey {
//        case status = "Status"
//        case data = "Data"
//        case errors = "Errors"
//        case message = "Message"
//    }
//}
//
//// MARK: - Datum
//struct Datum: Codable {
//    let id, openCDateUTC, closeCDateUTC, userInn: String?
//    let kktRegNumber, fnNumber: String?
//    let shiftNumber: Int?
//    let datumOperator: String?
//    let shiftDocsCount, incomeSumm, incomeCashSumm: Int?
//
//    enum CodingKeys: String, CodingKey {
//        case id = "Id"
//        case openCDateUTC = "Open_CDateUtc"
//        case closeCDateUTC = "Close_CDateUtc"
//        case userInn = "UserInn"
//        case kktRegNumber = "KktRegNumber"
//        case fnNumber = "FnNumber"
//        case shiftNumber = "ShiftNumber"
//        case datumOperator = "Operator"
//        case shiftDocsCount = "ShiftDocsCount"
//        case incomeSumm = "IncomeSumm"
//        case incomeCashSumm = "IncomeCashSumm"
//    }
//}

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let status: String
    let data: [Datum]
    let elapsed: String

    enum CodingKeys: String, CodingKey {
        case status = "Status"
        case data = "Data"
        case elapsed = "Elapsed"
    }
}

// MARK: - Datum
struct Datum: Codable {
    let id, openCDateUTC, closeCDateUTC, userInn: String
    let kktRegNumber, fnNumber: String
    let shiftNumber: Int
    let datumOperator: String
    let openDocNumber: Int
    let openDocDateTime, openDocRawID: String
    let closeDocNumber: Int
    let closeDocDateTime: String
    let shiftDocsCount: Int
    let closeDocRawID: String
    let incomeSumm, incomeCashSumm, incomeCount, advanceSumm: Int
    let creditSumm, exchangeSumm, refundIncomeSumm, refundIncomeCashSumm: Int
    let refundIncomeCount, expenseSumm, expenseCount, refundExpenseSumm: Int
    let refundExpenseCount, refundAdvanceSumm, refundCreditSumm, refundExchangeSumm: Int
    let taxTotalSumm, tax10Summ, tax18Summ, tax110Summ: Int
    let tax118Summ, taxNaSumm, tax0Summ: Int

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case openCDateUTC = "Open_CDateUtc"
        case closeCDateUTC = "Close_CDateUtc"
        case userInn = "UserInn"
        case kktRegNumber = "KktRegNumber"
        case fnNumber = "FnNumber"
        case shiftNumber = "ShiftNumber"
        case datumOperator = "Operator"
        case openDocNumber = "Open_DocNumber"
        case openDocDateTime = "Open_DocDateTime"
        case openDocRawID = "Open_DocRawId"
        case closeDocNumber = "Close_DocNumber"
        case closeDocDateTime = "Close_DocDateTime"
        case shiftDocsCount = "ShiftDocsCount"
        case closeDocRawID = "Close_DocRawId"
        case incomeSumm = "IncomeSumm"
        case incomeCashSumm = "IncomeCashSumm"
        case incomeCount = "IncomeCount"
        case advanceSumm = "AdvanceSumm"
        case creditSumm = "CreditSumm"
        case exchangeSumm = "ExchangeSumm"
        case refundIncomeSumm = "RefundIncomeSumm"
        case refundIncomeCashSumm = "RefundIncomeCashSumm"
        case refundIncomeCount = "RefundIncomeCount"
        case expenseSumm = "ExpenseSumm"
        case expenseCount = "ExpenseCount"
        case refundExpenseSumm = "RefundExpenseSumm"
        case refundExpenseCount = "RefundExpenseCount"
        case refundAdvanceSumm = "RefundAdvanceSumm"
        case refundCreditSumm = "RefundCreditSumm"
        case refundExchangeSumm = "RefundExchangeSumm"
        case taxTotalSumm = "TaxTotalSumm"
        case tax10Summ = "Tax10Summ"
        case tax18Summ = "Tax18Summ"
        case tax110Summ = "Tax110Summ"
        case tax118Summ = "Tax118Summ"
        case taxNaSumm = "TaxNaSumm"
        case tax0Summ = "Tax0Summ"
    }
}
