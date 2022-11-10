//
//  Sc.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 26.10.2022.
//
//
//TODO: delete useless parameters

// MARK: - SbisComingListResponse
struct SbisComingListResponse: Codable {
    let jsonrpc: String
    let result: ResultResponse
    let id: String
}

// MARK: - Result
struct ResultResponse: Codable {
    let документ: [ДокументОтвет]
    let навигация: НавигацияОтвет

    enum CodingKeys: String, CodingKey {
        case документ = "Документ"
        case навигация = "Навигация"
    }
}

// MARK: - Документ
struct ДокументОтвет: Codable {
    let вложение: [Вложение]
    let дата, датаВремяСоздания, идентификатор, идентификаторСеанса: String
    let контрагент: КонтрагентОтвет
    let название, направление: String
    let нашаОрганизация: НашаОрганизацияОтвет
    let номер, подтип, примечание: String
    let расширение: РасширениеОтвет
    let регламент: РегламентОтвет
    let редакция: [РедакцияElement]
    let состояние: СостояниеОтвет
    let срок: String
    let ссылкаДляКонтрагент: String
    let ссылкаДляНашаОрганизация: String
    let ссылкаНаPDF, ссылкаНаАрхив: String
    let сумма, тип, удален: String

    enum CodingKeys: String, CodingKey {
        case вложение = "Вложение"
        case дата = "Дата"
        case датаВремяСоздания = "ДатаВремяСоздания"
        case идентификатор = "Идентификатор"
        case идентификаторСеанса = "ИдентификаторСеанса"
        case контрагент = "Контрагент"
        case название = "Название"
        case направление = "Направление"
        case нашаОрганизация = "НашаОрганизация"
        case номер = "Номер"
        case подтип = "Подтип"
        case примечание = "Примечание"
        case расширение = "Расширение"
        case регламент = "Регламент"
        case редакция = "Редакция"
        case состояние = "Состояние"
        case срок = "Срок"
        case ссылкаДляКонтрагент = "СсылкаДляКонтрагент"
        case ссылкаДляНашаОрганизация = "СсылкаДляНашаОрганизация"
        case ссылкаНаPDF = "СсылкаНаPDF"
        case ссылкаНаАрхив = "СсылкаНаАрхив"
        case сумма = "Сумма"
        case тип = "Тип"
        case удален = "Удален"
    }
}

// MARK: - Вложение
struct Вложение: Codable {
    let версияФормата, дата, зашифрован, идентификатор: String
    let количествоОшибок, название, направление, номер: String
    let подверсияФормата, подтип: String
    let редакция: ВложениеРедакция
    let служебный: String
    let ссылкаВКабинет: String
    let ссылкаНаHTML, ссылкаНаPDF: String
    let сумма, суммаБезНДС, тип, типШифрования: String
    let удален, упакован: String
    let файл: Файл

    enum CodingKeys: String, CodingKey {
        case версияФормата = "ВерсияФормата"
        case дата = "Дата"
        case зашифрован = "Зашифрован"
        case идентификатор = "Идентификатор"
        case количествоОшибок = "КоличествоОшибок"
        case название = "Название"
        case направление = "Направление"
        case номер = "Номер"
        case подверсияФормата = "ПодверсияФормата"
        case подтип = "Подтип"
        case редакция = "Редакция"
        case служебный = "Служебный"
        case ссылкаВКабинет = "СсылкаВКабинет"
        case ссылкаНаHTML = "СсылкаНаHTML"
        case ссылкаНаPDF = "СсылкаНаPDF"
        case сумма = "Сумма"
        case суммаБезНДС = "СуммаБезНДС"
        case тип = "Тип"
        case типШифрования = "ТипШифрования"
        case удален = "Удален"
        case упакован = "Упакован"
        case файл = "Файл"
    }
}

// MARK: - ВложениеРедакция
struct ВложениеРедакция: Codable {
    let датаВремя, номер: String

    enum CodingKeys: String, CodingKey {
        case датаВремя = "ДатаВремя"
        case номер = "Номер"
    }
}

// MARK: - Файл
struct Файл: Codable {
    let имя: String
    let ссылка: String
    let хеш: String

    enum CodingKeys: String, CodingKey {
        case имя = "Имя"
        case ссылка = "Ссылка"
        case хеш = "Хеш"
    }
}

// MARK: - Контрагент
struct КонтрагентОтвет: Codable {
    let email, идентификаторИС, идентификаторСПП, описание: String
    let свЮЛ: СвЮЛОтвет
    let телефон: String

    enum CodingKeys: String, CodingKey {
        case email = "Email"
        case идентификаторИС = "ИдентификаторИС"
        case идентификаторСПП = "ИдентификаторСПП"
        case описание = "Описание"
        case свЮЛ = "СвЮЛ"
        case телефон = "Телефон"
    }
}

// MARK: - СвЮЛ
struct СвЮЛОтвет: Codable {
    let адресЮридический, инн, кпп, кодСтраны: String
    let название: String

    enum CodingKeys: String, CodingKey {
        case адресЮридический = "АдресЮридический"
        case инн = "ИНН"
        case кпп = "КПП"
        case кодСтраны = "КодСтраны"
        case название = "Название"
    }
}

// MARK: - НашаОрганизация
struct НашаОрганизацияОтвет: Codable {
    let идентификаторИС, идентификаторСПП, подписаниеОграничено: String
    let свЮЛ: СвЮЛОтвет

    enum CodingKeys: String, CodingKey {
        case идентификаторИС = "ИдентификаторИС"
        case идентификаторСПП = "ИдентификаторСПП"
        case подписаниеОграничено = "ПодписаниеОграничено"
        case свЮЛ = "СвЮЛ"
    }
}

// MARK: - Расширение
struct РасширениеОтвет: Codable {
    let закрытОтИзменений, отметкаПлюсом: String

    enum CodingKeys: String, CodingKey {
        case закрытОтИзменений = "ЗакрытОтИзменений"
        case отметкаПлюсом = "ОтметкаПлюсом"
    }
}

// MARK: - Регламент
struct РегламентОтвет: Codable {
    let идентификатор, название: String

    enum CodingKeys: String, CodingKey {
        case идентификатор = "Идентификатор"
        case название = "Название"
    }
}

// MARK: - РедакцияElement
struct РедакцияElement: Codable {
    let актуален, датаВремя, идентификатор, примечаниеИС: String

    enum CodingKeys: String, CodingKey {
        case актуален = "Актуален"
        case датаВремя = "ДатаВремя"
        case идентификатор = "Идентификатор"
        case примечаниеИС = "ПримечаниеИС"
    }
}

// MARK: - Состояние
struct СостояниеОтвет: Codable {
    let код, название, неполнаяОбработка, описание: String
    let примечание, сложное: String

    enum CodingKeys: String, CodingKey {
        case код = "Код"
        case название = "Название"
        case неполнаяОбработка = "НеполнаяОбработка"
        case описание = "Описание"
        case примечание = "Примечание"
        case сложное = "Сложное"
    }
}

// MARK: - Навигация
struct НавигацияОтвет: Codable {
    let естьЕще, размерСтраницы, страница: String

    enum CodingKeys: String, CodingKey {
        case естьЕще = "ЕстьЕще"
        case размерСтраницы = "РазмерСтраницы"
        case страница = "Страница"
    }
}
