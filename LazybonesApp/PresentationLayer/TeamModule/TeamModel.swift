//
//  TeamModel.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 15.01.2023.
//

import Foundation

struct CurrentMonth {
    var daysArray = [DayData]()
    init(reports: [DailyReport], date: Date) {
        self.configureDaysArrya(reports: reports, date: date)
    }
    
    private mutating func configureDaysArrya(reports: [DailyReport], date: Date) {
        guard let daysInMonth = Calendar.current.dateComponents([.day], from: date.lastDayOfMonth()).day else { return }
        var weekDayNumber = Calendar.current.component(.weekday, from: date.firstDayOfMonth())
        print(date.firstDayOfMonth().description)
        if weekDayNumber == 1 {
            weekDayNumber = 7
        } else {
            weekDayNumber -= 1
        }
        print(weekDayNumber)
        
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd'T'HH.mm.ss"
        
        daysArray = Array(repeating: DayData(), count: weekDayNumber - 1)
        
        for dayNumber in 1...daysInMonth {
            var dayData = DayData()
            dayData.dayNumber = String(dayNumber)
            for report in reports {
                
                guard let reportDate = dateFormater.date(from: report.openDocDateTime) else { continue }
                guard let dayNumberOfReport = Calendar.current.dateComponents([.day], from: reportDate).day else { continue }

                if dayNumber == dayNumberOfReport {
                    dayData.incomeSumm += (report.incomeSumm)
                    dayData.welcomeOperator = report.welcomeOperator
                }
            }
            daysArray.append(dayData)
        }
        if daysArray.count < 35 && daysArray.count > 28 {
            for _ in 1...(35 - daysArray.count) {
                daysArray.append(DayData())
            }
        } else {
            for _ in 1...(42 - daysArray.count) {
                daysArray.append(DayData())
            }
        }
        
    }
}

struct DayData {
    var dayNumber = ""
    var welcomeOperator = ""
    var incomeSumm = 0
}
