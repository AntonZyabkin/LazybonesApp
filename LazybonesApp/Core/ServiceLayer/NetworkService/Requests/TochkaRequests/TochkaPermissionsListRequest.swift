//
//  TochkaPermissionsListRequest.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 19.11.2022.
//

import Foundation


struct TochkaPermissionsListRequest: Codable {
    
    let tochkaAccessToken: String
    let body: TochkaPermissionsListBody
    
    init(_ accessToket: String){
        self.body = TochkaPermissionsListBody(data: DataClass(permissions: [
            "ReadAccountsBasic",
            "ReadAccountsDetail",
            "ReadBalances",
            "ReadTransactionsDetail",
            "ReadTransactionsCredits",
            "ReadTransactionsDebits",
            "ReadStatements",
            "ReadCustomerData",
            "ReadSBPData",
            "EditSBPData",
            "CreatePaymentForSign",
            "CreatePaymentOrder",
            "ReadSpecialAccounts"
          ]))
        self.tochkaAccessToken = accessToket
    }
    
    struct TochkaPermissionsListBody: Codable {
        let data: DataClass

        enum CodingKeys: String, CodingKey {
            case data = "Data"
        }
    }

    struct DataClass: Codable {
        var permissions: Array<String>

        enum CodingKeys: String, CodingKey {
            case permissions = "permissions"
        }
    }
}
