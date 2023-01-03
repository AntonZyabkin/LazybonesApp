//
//  PaymentModel.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 04.12.2022.
//

import Foundation

struct Contractor {
    let inn: String
    var debt: Double = 0 {
        didSet {
            debt = Double(round(100 * debt) / 100)
        }
    }
    let name: String
}

struct PaymentDetailModel {
    private var incomeData: TochkaPaymentForSignRequest
    init(incomeData: TochkaPaymentForSignRequest) {
        self.incomeData = incomeData
        counterpartyINN = incomeData.body.data.counterpartyINN
        counterpartyName = incomeData.body.data.counterpartyName
        paymentPurpose = incomeData.body.data.paymentPurpose
        paymentAmount = incomeData.body.data.paymentAmount
    }
    
    var counterpartyINN: String
    var counterpartyName: String
    var paymentPurpose: String
    var paymentAmount: String
}
