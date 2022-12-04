//
//  PaymentModel.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 04.12.2022.
//

import Foundation

struct Contractor {
    let inn: String
    var debt: Double = 0
}

protocol PaymentModelProtocol {
    func createDebtsDictionary(coming: SbisShortComingListResponse)
}

final class PaymentModel {
    var contractorsDictionary: [String: Contractor] = [:]
}

extension PaymentModel: PaymentModelProtocol {
    func createDebtsDictionary(coming: SbisShortComingListResponse){
        
        for document in coming.result.document {
            if (contractorsDictionary[document.counterparty.companyDetails.INN] == nil) {
                var contractor = Contractor(inn: document.counterparty.companyDetails.INN)
                contractor.debt += Double(document.summ) ?? 0
                contractorsDictionary[contractor.inn] = contractor
            } else {
                contractorsDictionary[document.counterparty.companyDetails.INN]?.debt += Double(document.summ) ?? 0
            }
        }
    }
}
