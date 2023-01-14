//
//  File.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 16.12.2022.
//

import Foundation

//MARK: - Welcome
struct OfdGetReportsResponse: Codable {
    let status: String?
    let data: [DailyReport]?
    let errors: [String]?
    let message: String?

    enum CodingKeys: String, CodingKey {
        case status = "Status"
        case data = "Data"
        case errors = "Errors"
        case message = "Message"
    }
}

// MARK: - DailyReport
struct DailyReport: Codable {
    let openDocDateTime, welcomeOperator: String
    let incomeSumm, incomeCashSumm, incomeCount: Int

    enum CodingKeys: String, CodingKey {
        case openDocDateTime = "Open_DocDateTime"
        case welcomeOperator = "Operator"
        case incomeCount = "IncomeCount"
        case incomeSumm = "IncomeSumm"
        case incomeCashSumm = "IncomeCashSumm"
    }
}
