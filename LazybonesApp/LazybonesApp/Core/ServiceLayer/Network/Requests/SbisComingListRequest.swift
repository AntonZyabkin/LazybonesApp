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
}

// MARK: - SbisComingListBody
struct SbisComingListBodyRequest: Codable {
    let jsonrpc: String = "2.0"
    let method: String = "СБИС.СписокДокументов"
    let params: ComingListParams
    let id: String = "0"
    
    enum CodingKeys: String, CodingKey {
        case jsonrpc
        case method
        case params
        case id
    }
    
    init() {
        self.params = ComingListParams(filter: Filter(navigation: Navigation()))
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
    let type: String = "ДокОтгрВх"
    let navigation: Navigation

    enum CodingKeys: String, CodingKey {
        case type = "Тип"
        case navigation = "Навигация"
    }
}

//TODO: задавать параметры навигации из UI
struct Navigation: Codable {
    let pageSize: String = "125"
    let currentPage = "0"
    
    enum CodingKeys: String, CodingKey {
        case pageSize = "РазмерСтраницы"
        case currentPage = "Страница"
    }
}
