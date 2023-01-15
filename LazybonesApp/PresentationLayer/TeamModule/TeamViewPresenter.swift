//
//  TeamViewPresenter.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 14.01.2023.
//

import Foundation

protocol TeamViewPresenterProtocol {
    func numberOfCells() -> Int
    func dataForCellBy(indexPath: IndexPath) -> DayData
    func startLoadData()
    func plusMonth()
    func minusMonth()
}

final class TeamViewPresenter {
    var view: TeamViewControllerProtocol!
    
    private var currentDate = Date()
    private let ofdAPIService: OfdAPIServicable
    private let keychainService: KeychainServicable
    private var daysArray: [DayData] = []
    
    init(ofdAPIService: OfdAPIServicable, keychainService: KeychainServicable) {
        self.ofdAPIService = ofdAPIService
        self.keychainService = keychainService
    }
    
    private func updateCalendar(request: OfdGetReportsRequest) {
        ofdAPIService.gerReportsRequest(request: request) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let result):
                if let massage = result.message {
                    self.view.showAlert(errorDescription: "success OFD request, bud massage = \(massage)")
                    return
                }
                guard let data = result.data else {
                    self.view.showAlert(errorDescription: "there is no Data in response")
                    return
                }
                print("success OFD request")
                self.daysArray = CurrentMonth(reports: data, date: self.currentDate).daysArray
                
                DispatchQueue.main.async {
                    self.view.reloadData()
                }
            case .failure(let error):
                self.view.showAlert(errorDescription: error.localizedDescription)
            }
        }
    }

    private func createOFDMonthlyRequest(ofdAuthToket: String, currentDate: Date) -> OfdGetReportsRequest {
        
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd"
        let dateFromString = dateFormater.string(from: currentDate.firstDayOfMonth()) + "T00:00:01"
        let datetoString = dateFormater.string(from: currentDate.lastDayOfMonth()) + "T23:59:59"

        return OfdGetReportsRequest(inn: "5024198006", authToken: ofdAuthToket, dateFrom: dateFromString, dateTo: datetoString)
    }
}

extension TeamViewPresenter: TeamViewPresenterProtocol {

    
    func numberOfCells() -> Int {
        return daysArray.count
    }
    func dataForCellBy(indexPath: IndexPath) -> DayData {
        return daysArray[indexPath.row]
    }
    func plusMonth(){
        let calendar = Calendar.current
        currentDate = calendar.date(byAdding: .month, value: 1, to: currentDate) ?? Date()
        startLoadData()
    }
    func minusMonth() {
        let calendar = Calendar.current
        currentDate = calendar.date(byAdding: .month, value: -1, to: currentDate) ?? Date()
        startLoadData()
    }
    
    func startLoadData() {
        guard let ofdAuthToket = keychainService.fetch(for: .ofdAuthToken) else {
            view.showAlert(errorDescription: "go to auth OFD")
            return
        }
        let request = createOFDMonthlyRequest(ofdAuthToket: ofdAuthToket, currentDate: currentDate)
        updateCalendar(request: request)
    }
}
