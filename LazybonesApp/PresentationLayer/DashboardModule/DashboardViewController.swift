//
//  DashboardViewController.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 25.10.2022.
//

import UIKit
import Charts

protocol DashboardViewControllerProtocol: UIViewController {
    func changeBarButtonItem(title: String)
    func createBarChart(barChartDataSetArray: [BarChartDataSet])
}

final class DashboardViewController: UIViewController {
    var presenter: DashboardViewPresenterProtocol?
    private lazy var logOutOfdNavBarItem = UIBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configeNavBar()
        presenter?.startLoadData()
    }
    
    private func configeNavBar() {
        logOutOfdNavBarItem = UIBarButtonItem(title: "Выйти из OFD.RU", style: .plain, target: self, action: #selector(logOutItemDidPress))
        navigationItem.rightBarButtonItem = logOutOfdNavBarItem
    }
    
    @objc
    func logOutItemDidPress() {
        presenter?.logOutItemDidPress()
    }
    
    func createBarChart(barChartDataSetArray: [BarChartDataSet]) {
        let chartView = BarChartView(frame: CGRect(x: 0, y: 100, width: view.frame.size.width, height: view.frame.size.width))
        let xAxis = chartView.xAxis

        xAxis.drawAxisLineEnabled = true
        xAxis.drawGridLinesEnabled = false
        xAxis.granularityEnabled = false
        xAxis.labelTextColor = .black
        xAxis.labelFont = .mainBoldHelvetica(size: 20)
        xAxis.valueFormatter = IndexAxisValueFormatter(values: ["211", "Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вс"])
        xAxis.axisLineColor = .clear
        xAxis.labelPosition = .bottom
        
        chartView.rightAxis.enabled = false
        chartView.leftAxis.axisMinimum = 0

        chartView.fitBars = true
        chartView.backgroundColor = .white
        chartView.scaleXEnabled = false
        chartView.scaleYEnabled = false
        
        barChartDataSetArray[0].setColor(.chartLightRed)
        barChartDataSetArray[1].setColor(.chartRed)
        barChartDataSetArray[2].setColor(.chartbrightRed)

        let chartData = BarChartData(dataSets: barChartDataSetArray)
        
        //(baSpace + barWidth) * dataSet count + groupSpace = 1.0
        let groupSpace = 0.3
        let barSpace = 0.05
        let barWidth = (1 - groupSpace)/3 - barSpace
        let startVal = 0.5
        
        chartData.barWidth = barWidth
        chartData.groupBars(fromX: Double(startVal), groupSpace: groupSpace, barSpace: barSpace)
        chartData.notifyDataChanged()
        chartView.data = chartData
        
        view.addSubview(chartView)
    }
}

extension DashboardViewController: DashboardViewControllerProtocol {
    func changeBarButtonItem(title: String) {
        logOutOfdNavBarItem.title = title
    }
}
