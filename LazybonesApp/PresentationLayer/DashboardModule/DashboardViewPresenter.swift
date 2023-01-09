//
//  DashboardViewPresenter.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 16.12.2022.
//

import Foundation

protocol DashboardViewPresenterProtocol {
    func startLoadData()
    func logOutItemDidPress()
}

protocol DashboardLoaderProtocol {
    func startLoadData()
}

final class DashboardViewPresenter: DashboardLoaderProtocol {
    private let moduleBuilder: Builder
    private let ofdAPIService: OfdAPIServicable
    private let keychainService: KeychainServicable
    
    var view: DashboardViewControllerProtocol?
    
    init(ofdAPIService: OfdAPIServicable, keychainService: KeychainServicable, moduleBuilder: Builder) {
        self.ofdAPIService = ofdAPIService
        self.keychainService = keychainService
        self.moduleBuilder = moduleBuilder
    }
    
    private func showOFDAuthViewController() {
        DispatchQueue.main.async {
            let OFDAuthViewController = self.moduleBuilder.buildOFDAuthViewController()
            OFDAuthViewController.loader = self
            self.view?.navigationController?.pushViewController(OFDAuthViewController, animated: true)
        }
    }
}

extension DashboardViewPresenter: DashboardViewPresenterProtocol {
    
    func startLoadData() {
        guard let ofdAuthToket = keychainService.fetch(for: .ofdAuthToken) else {
            let authViewController = moduleBuilder.buildOFDAuthViewController()
            view?.navigationController?.pushViewController(authViewController, animated: true)
            print("go to auth OFD")
            return
        }
        
        let request = createOFDRequestForChart(ofdAuthToket: ofdAuthToket)
//        let request = OfdGetReportsRequest(inn: "5024198006", authToken: ofdAuthToket, dateFrom: "2022-12-26T00:00:01", dateTo: "2023-01-09T14:21:27")

        ofdAPIService.gerReportsRequest(request: request) { response in
            switch response {
            case .success(let result):
                if let massage = result.message {
                    print("success OFD request, bud massage = \(massage)")
                    self.showOFDAuthViewController()
                    return
                }
                guard let data = result.data else {
                    print("there is no Data in response")
                    return
                }
                let barChartDataSetArray = DataForWeekChart(dailyReportArray: data).barChartDataSetArray
                print("success OFD request")
                DispatchQueue.main.async {
                    self.view?.createBarChart(barChartDataSetArray: barChartDataSetArray)
                }
            case .failure(let error):
                print("error OFD request")
                self.showOFDAuthViewController()
                print(error)
            }
        }
    }
    
    func logOutItemDidPress() {
        keychainService.deleteItem(for: .ofdAuthToken)
        showOFDAuthViewController()
        view?.changeBarButtonItem(title: "Войти в OFD.RU")
    }
    private func createOFDRequestForChart(ofdAuthToket: String) -> OfdGetReportsRequest {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormater.locale = Locale(identifier: "ru_RU")
        let todayDate = Date()
        
        var weekDayNumber = Calendar.current.component(.weekday, from: todayDate)
        if weekDayNumber == 1 {
            weekDayNumber = 7
        } else {
            weekDayNumber -= 1
        }
        let periodSize = 13 + weekDayNumber
        
        let datetoString = dateFormater.string(from: todayDate)
        let dateFromDate = Calendar.current.date(byAdding: .day, value: -periodSize, to: todayDate) ?? Date()
        dateFormater.dateFormat = "yyyy-MM-dd"
        let dateFromString = dateFormater.string(from: dateFromDate) + "T00:00:01"
        print(OfdGetReportsRequest(inn: "5024198006", authToken: ofdAuthToket, dateFrom: dateFromString, dateTo: datetoString))
        return OfdGetReportsRequest(inn: "5024198006", authToken: ofdAuthToket, dateFrom: dateFromString, dateTo: datetoString)
    }

}


enum Weeks {
    case eldestWeek
    case previousWeek
    case currentWeek
}
