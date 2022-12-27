//
//  OfdGetReportsRequest.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 16.12.2022.
//

import Foundation


struct OfdGetReportsRequest {
    let inn: String
    let authToken: String
    let dateFrom: String
    let dateTo: String
}
