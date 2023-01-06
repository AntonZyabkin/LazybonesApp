//
//  OfdGetReportsRequest.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 16.12.2022.
//

import Foundation

protocol Urlable {
    var urlString: String { get }
}
struct OfdGetReportsRequest: Encodable {
    
    private let inn: String
    private let authToken: String
    private let dateFrom: String
    private let dateTo: String
    
    init(inn: String, authToken: String, dateFrom: String, dateTo: String) {
        self.inn = inn
        self.dateTo = dateTo
        self.dateFrom = dateFrom
        self.authToken = authToken
    }
}

extension OfdGetReportsRequest: Urlable {
    var urlString: String {
        get {
            return "https://ofd.ru/api/integration/v1/inn/\(inn)/zreports?dateFrom=\(dateFrom)&dateTo=\(dateTo)&AuthToken=\(authToken)"
        }
    }
}
