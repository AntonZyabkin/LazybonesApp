//
//  Sc.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 26.10.2022.
//
//
// MARK: - SbisShortComingListResponse
struct SbisShortComingListResponse: Codable {
    let jsonrpc: String
    let result: ResponseResult
}

// MARK: - Result
struct ResponseResult: Codable {
    let document: [Document]

    enum CodingKeys: String, CodingKey {
        case document = "Документ"
    }
}

// MARK: - Document
struct Document: Codable {
    let attachment: [Attachment]
    let date, dateTimeCreating: String
    let counterparty: Сounterparty
    let name: String
    let linkToPDF: String
    let summ: String

    enum CodingKeys: String, CodingKey {
        case attachment = "Вложение"
        case date = "Дата"
        case dateTimeCreating = "ДатаВремяСоздания"
        case counterparty = "Контрагент"
        case name = "Название"
        case linkToPDF = "СсылкаНаPDF"
        case summ = "Сумма"
    }
}

// MARK: - Attachment
struct Attachment: Codable {
    let name: String
    let linkToPDF: String
    let summAttachment: String

    enum CodingKeys: String, CodingKey {
        case name = "Название"
        case linkToPDF = "СсылкаНаPDF"
        case summAttachment = "Сумма"
    }
}

// MARK: - Сounterparty
struct Сounterparty: Codable {
    let description: String
    let companyDetails: CompanyDetails

    enum CodingKeys: String, CodingKey {
        case description = "Описание"
        case companyDetails = "СвЮЛ"
    }
}

// MARK: - CompanyDetails
struct CompanyDetails: Codable {
    let registeredAddress, INN, KPP, countryCode: String
    let name: String

    enum CodingKeys: String, CodingKey {
        case registeredAddress = "АдресЮридический"
        case INN = "ИНН"
        case KPP = "КПП"
        case countryCode = "КодСтраны"
        case name = "Название"
    }
}
