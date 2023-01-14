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
    func configLabels(report: DailyReport)
}

final class DashboardViewController: UIViewController {
    var presenter: DashboardViewPresenterProtocol?
    private lazy var logOutOfdNavBarItem = UIBarButtonItem()
    private lazy var chartView = BarChartView()

    private lazy var incomeSummLabel = labelFactory(textAlignment: .right, fontSize: 32, textColor: .myGreenText)
    private lazy var incomeCashSummLabel = labelFactory(textAlignment: .right, fontSize: 20, textColor: .myGray)
    private lazy var incomeEMonaySummLabel = labelFactory(textAlignment: .right, fontSize: 20, textColor: .myGray)
    private lazy var billNumbersLabel = labelFactory(textAlignment: .right, fontSize: 26, textColor: .myBlueText)
    private lazy var billAmountLabel = labelFactory(textAlignment: .right, fontSize: 26, textColor: .myBlueText)
    private lazy var dateLabel = labelFactory(textAlignment: .right, fontSize: 26, textColor: .myBlueText)
    private lazy var welcomeOperatorLabel = labelFactory(textAlignment: .right, fontSize: 26, textColor: .myBlueText)
    
    private lazy var incomeSummEntryLabel = labelFactory(textAlignment: .left, fontSize: 32, textColor: .myGreenText)
    private lazy var incomeCashSummEntryLabel = labelFactory(textAlignment: .left, fontSize: 20, textColor: .myGray)
    private lazy var incomeEMonaySummEntryLabel = labelFactory(textAlignment: .left, fontSize: 20, textColor: .myGray)
    private lazy var billNumbersEntryLabel = labelFactory(textAlignment: .left, fontSize: 26, textColor: .myBlueText)
    private lazy var billAmountEntryLabel = labelFactory(textAlignment: .left, fontSize: 26, textColor: .myBlueText)
    private lazy var dateEntryLabel = labelFactory(textAlignment: .left, fontSize: 26, textColor: .myBlueText)
    private lazy var welcomeOperatorEntryLabel = labelFactory(textAlignment: .left, fontSize: 26, textColor: .myBlueText)
    
    private lazy var chartTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Динамика дневной выручки"
        label.font = .mainHelvetica(size: 24)
        label.textAlignment = .left
        label.textColor = .darkGray
        return label
    }()
    private lazy var statisticTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Показатели текущей смены"
        label.font = .mainHelvetica(size: 24)
        label.textAlignment = .left
        label.textColor = .darkGray
        return label
    }()
    private lazy var leftStatisticStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            incomeSummLabel,
            incomeCashSummLabel,
            incomeEMonaySummLabel,
            billNumbersLabel,
            billAmountLabel,
            dateLabel,
            welcomeOperatorLabel,
            UILabel()
        ])
        
        stackView.alignment = .trailing
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.setCustomSpacing(20, after: welcomeOperatorLabel)

        return stackView
    }()
    private lazy var rightStatisticStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            incomeSummEntryLabel,
            incomeCashSummEntryLabel,
            incomeEMonaySummEntryLabel,
            billNumbersEntryLabel,
            billAmountEntryLabel,
            dateEntryLabel,
            welcomeOperatorEntryLabel,
            UILabel()
        ])
        
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.setCustomSpacing(20, after: welcomeOperatorEntryLabel)
        return stackView
    }()
    
    private lazy var bottomStatisticStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            leftStatisticStackView,
            rightStatisticStackView
        ])
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.layer.cornerRadius = 15
        stackView.backgroundColor = .white
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .myBackgroundGray
        configeNavBar()
        presenter?.startLoadData()
    }
    
    private func configeNavBar() {
        
        logOutOfdNavBarItem = UIBarButtonItem(
            image: UIImage(systemName: "rectangle.portrait.and.arrow.right"),
            style: .plain,
            target: self,
            action: #selector(logOutItemDidPress))
        navigationItem.rightBarButtonItem = logOutOfdNavBarItem
    }
    
    @objc
    func logOutItemDidPress() {
        presenter?.logOutItemDidPress()
    }
    
    func createBarChart(barChartDataSetArray: [BarChartDataSet]) {
        let xAxis = chartView.xAxis
        
        xAxis.drawAxisLineEnabled = true
        xAxis.drawGridLinesEnabled = false
        xAxis.granularityEnabled = false
        xAxis.labelTextColor = .black
        xAxis.labelFont = .mainBoldHelvetica(size: 20)
        xAxis.valueFormatter = IndexAxisValueFormatter(values: ["_", "Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вс"])
        xAxis.axisLineColor = .clear
        xAxis.labelPosition = .bottom
        
        
        barChartDataSetArray[0].setColor(.myPurpleLight)
        barChartDataSetArray[1].setColor(.myPurple)
        barChartDataSetArray[2].setColor(.myPurpleBold)

        let chartData = BarChartData(dataSets: barChartDataSetArray)
        
        //(baSpace + barWidth) * dataSet count + groupSpace = 1.0
        let groupSpace = 0.3
        let barSpace = 0.05
        let barWidth = (1 - groupSpace)/3 - barSpace
        let startVal = 0.5
        
        chartData.barWidth = barWidth
        chartData.groupBars(fromX: Double(startVal), groupSpace: groupSpace, barSpace: barSpace)
        chartData.notifyDataChanged()
        
        chartView.rightAxis.enabled = false
        chartView.leftAxis.axisMinimum = 0
        chartView.fitBars = true
        chartView.backgroundColor = .white
        chartView.scaleXEnabled = false
        chartView.scaleYEnabled = false
        chartView.layer.cornerRadius = 15
        chartView.layer.masksToBounds = true
        chartView.data = chartData
        
        view.addSubview(chartView)
    }
    
    private func labelFactory(textAlignment: NSTextAlignment, fontSize: CGFloat, textColor: UIColor) -> UILabel {
        let label = UILabel()
        label.textAlignment = .right
        label.numberOfLines = 1
        label.font = .mainLightHelvetica(size: fontSize)
        label.text = "default text"
        label.textColor = textColor
        return label
    }
    
    func configLabels(report: DailyReport) {
        view.addSubview(bottomStatisticStackView)
        view.addSubview(chartTitleLabel)
        view.addSubview(statisticTitleLabel)
        
        incomeSummLabel.text = "Выручка:"
        incomeCashSummLabel.text = "наличные:"
        incomeEMonaySummLabel.text = "безналичные:"
        billNumbersLabel.text = "Чеки:"
        billAmountLabel.text = "Средний чек:"
        dateLabel.text = "Дата смены:"
        welcomeOperatorLabel.text = "Специалист:"
        
        incomeSummLabel.font = .mainBoldHelvetica(size: 32)
        incomeSummEntryLabel.font = .mainBoldHelvetica(size: 32)
        incomeSummEntryLabel.text = String(Double(report.incomeSumm)/100) + " \u{20BD}"
        incomeCashSummEntryLabel.text = String(Double(report.incomeCashSumm)/100) + " \u{20BD}"
        incomeEMonaySummEntryLabel.text = String(Double((report.incomeSumm - report.incomeCashSumm))/100) + " \u{20BD}"
        billNumbersEntryLabel.text = String(report.incomeCount)
        billAmountEntryLabel.text = String(Double(report.incomeSumm/report.incomeCount)/100) + " \u{20BD}"
        dateEntryLabel.text = String(report.openDocDateTime.prefix(10))
        welcomeOperatorEntryLabel.text = report.welcomeOperator
        
        NSLayoutConstraint.activate([
            chartView.heightAnchor.constraint(equalToConstant: 320),
            chartView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            chartView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            chartView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            bottomStatisticStackView.heightAnchor.constraint(equalToConstant: 280),
            bottomStatisticStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            bottomStatisticStackView.topAnchor.constraint(equalTo: chartView.bottomAnchor, constant: 70),
            bottomStatisticStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            chartTitleLabel.heightAnchor.constraint(equalToConstant: 70),
            chartTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            chartTitleLabel.topAnchor.constraint(equalTo: chartView.topAnchor, constant: -55),
            chartTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            statisticTitleLabel.heightAnchor.constraint(equalToConstant: 70),
            statisticTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            statisticTitleLabel.topAnchor.constraint(equalTo: bottomStatisticStackView.topAnchor, constant: -55),
            statisticTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)

        ])
        chartView.translatesAutoresizingMaskIntoConstraints = false
        bottomStatisticStackView.translatesAutoresizingMaskIntoConstraints = false
        chartTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        statisticTitleLabel.translatesAutoresizingMaskIntoConstraints = false
    }
}

extension DashboardViewController: DashboardViewControllerProtocol {
    func changeBarButtonItem(title: String) {
        logOutOfdNavBarItem.title = title
    }
}
