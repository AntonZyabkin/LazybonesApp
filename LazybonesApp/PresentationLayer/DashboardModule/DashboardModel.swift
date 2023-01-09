//
//  DashboardModel.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 08.01.2023.
//

import Foundation
import Charts

struct DataForWeekChart {
    var barChartDataSetArray: [BarChartDataSet] = []
    
    init(dailyReportArray: [DailyReport]) {
        self.barChartDataSetArray = updateSetsArray(dailyReportsArray: dailyReportArray)
    }
    
    private func updateSetsArray(dailyReportsArray: [DailyReport]) -> [BarChartDataSet] {
         
        var eldestWeekEntries: [BarChartDataEntry] = []
        var previousWeekEntries: [BarChartDataEntry] = []
        var currentWeekEntries: [BarChartDataEntry] = []
        
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd'T'HH.mm.ss"
        let cal = Calendar(identifier: .iso8601)
        guard let firstDayInPeriodString = dailyReportsArray.first?.openDocDateTime else { return []}
        let firstDayInPeriodDate = dateFormater.date(from: firstDayInPeriodString) ?? Date()
        let eldestWeekNumber = cal.component(.weekOfYear, from: firstDayInPeriodDate)
        let date2 = cal.date(byAdding: .day, value: 7, to: firstDayInPeriodDate) ?? Date()
        let previousWeekNumber = cal.component(.weekOfYear, from: date2)
        let date3 = cal.date(byAdding: .day, value: 14, to: firstDayInPeriodDate) ?? Date()
        let currentWeekNumber = cal.component(.weekOfYear, from: date3)
        let weekNumbersArray = [eldestWeekNumber, previousWeekNumber, currentWeekNumber]
        
        for report in dailyReportsArray {
            let reporsDate = dateFormater.date(from: report.openDocDateTime) ?? Date()
            let reportWeekNumber = Calendar.current.component(.weekOfYear, from: reporsDate)


            var weekDayNumber = Calendar.current.component(.weekday, from: reporsDate)
            if weekDayNumber == 1 {
                weekDayNumber = 7
            } else {
                weekDayNumber -= 1
            }
            let incomeSummDouble = Double(report.incomeSumm/100000)
            let barChartDataEntry = BarChartDataEntry(x: Double(weekDayNumber), y: incomeSummDouble)
            switch reportWeekNumber {
            case weekNumbersArray[0]:
                eldestWeekEntries.append(barChartDataEntry)
            case weekNumbersArray[1]:
                previousWeekEntries.append(barChartDataEntry)
            case weekNumbersArray[2]:
                currentWeekEntries.append(barChartDataEntry)
            default:
                print("out of weekNumbersArray range")
            }
        }

        return [BarChartDataSet(entries: eldestWeekEntries, label: "Позапрошлая"),
                BarChartDataSet(entries: previousWeekEntries, label: "Прошлая"),
                BarChartDataSet(entries: currentWeekEntries, label: "Текущая неделя")]
    }
}
