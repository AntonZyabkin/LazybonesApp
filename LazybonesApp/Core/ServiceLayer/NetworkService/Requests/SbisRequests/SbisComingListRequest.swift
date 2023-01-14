//
//  SbisComingListRequest.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 26.10.2022.
//

import Foundation

// MARK: - SbisComingListRequest
struct SbisComingListRequest: Codable {
    var body: SbisComingListBodyRequest
    var sbisToken: String
    init(_ token: String, pageSize: String, numberOfPage: String){
        self.sbisToken = token
        self.body = SbisComingListBodyRequest(params: ComingListParams(filter: Filter(navigation: Navigation(pageSize: pageSize, numberOfPage: numberOfPage))))
    }
}

// MARK: - SbisComingListBody
struct SbisComingListBodyRequest: Codable {
    let jsonrpc: String = "2.0"
    let method: String = "СБИС.СписокДокументов"
    let params: ComingListParams
    
    enum CodingKeys: String, CodingKey {
        case jsonrpc
        case method
        case params
    }
}

// MARK: - Params
struct ComingListParams: Codable {
    let filter: Filter

    enum CodingKeys: String, CodingKey {
        case filter = "Фильтр"
    }
}

// MARK: - Filter
struct Filter: Codable {
    
    let navigation: Navigation
    let type: String = "ДокОтгрВх"

    enum CodingKeys: String, CodingKey {
        case type = "Тип"
        case navigation = "Навигация"
    }
}

// MARK: - Навигация
struct Navigation: Codable {
    let pageSize, numberOfPage: String

    enum CodingKeys: String, CodingKey {
        case pageSize = "РазмерСтраницы"
        case numberOfPage = "Страница"
    }
}
