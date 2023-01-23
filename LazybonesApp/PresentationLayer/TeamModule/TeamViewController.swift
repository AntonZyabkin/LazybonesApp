//
//  TeamViewController.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 25.10.2022.
//

import UIKit

protocol TeamViewControllerProtocol {
    func showAlert(errorDescription: String)
    func reloadData()
    var currentMonthLabel : UILabel { get }
}

final class TeamViewController: UIViewController {
    var presenter: TeamViewPresenterProtocol!
    
    private lazy var previousMonth: UIButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(previousButtonDidPressed), for: .touchUpInside)
        button.setImage(UIImage(systemName: "arrow.backward.circle.fill"), for: .normal)
        return button
    }()
    internal lazy var currentMonthLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .mainBoldHelvetica(size: 26)
        label.text = ""
        return label
    }()
    private lazy var nextMonth: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(nextButtonDidPressed), for: .touchUpInside)
        button.setImage(UIImage(systemName: "arrow.forward.circle.fill"), for: .normal)
        return button
    }()
    private lazy var daysNameStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.alignment = .center
        return stackView
    }()
    private lazy var calendarCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let width = (view.frame.width - 40) / 7
        let height = (view.frame.height - 40) / 12
        layout.itemSize = CGSize(width: width, height: height)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .myBackgroundGray
        return collectionView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .myBackgroundGray
        presenter.startLoadData()
        configViewsConstraints()
        fillStackView()
        calendarCollectionView.delegate = self
        calendarCollectionView.dataSource = self
        calendarCollectionView.register(
            TeamCollectionViewCell.self,
            forCellWithReuseIdentifier: TeamCollectionViewCell.identifier
        )
    }
    
    private func configViewsConstraints() {
        
        view.addSubview(previousMonth)
        view.addSubview(currentMonthLabel)
        view.addSubview(nextMonth)
        view.addSubview(daysNameStackView)
        view.addSubview(calendarCollectionView)
        
        NSLayoutConstraint.activate([
            currentMonthLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            currentMonthLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            currentMonthLabel.heightAnchor.constraint(equalToConstant: 70),
            currentMonthLabel.widthAnchor.constraint(equalToConstant: 180),
            
            previousMonth.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            previousMonth.centerYAnchor.constraint(equalTo: currentMonthLabel.centerYAnchor),
            previousMonth.heightAnchor.constraint(equalTo: currentMonthLabel.heightAnchor),
            previousMonth.trailingAnchor.constraint(equalTo: currentMonthLabel.leadingAnchor),
            
            nextMonth.leadingAnchor.constraint(equalTo: currentMonthLabel.trailingAnchor),
            nextMonth.centerYAnchor.constraint(equalTo: currentMonthLabel.centerYAnchor),
            nextMonth.heightAnchor.constraint(equalTo: currentMonthLabel.heightAnchor),
            nextMonth.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            daysNameStackView.topAnchor.constraint(equalTo: currentMonthLabel.bottomAnchor),
            daysNameStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            daysNameStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            daysNameStackView.heightAnchor.constraint(equalToConstant: 80),
            
            calendarCollectionView.topAnchor.constraint(equalTo: daysNameStackView.bottomAnchor),
            calendarCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            calendarCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            calendarCollectionView.heightAnchor.constraint(equalToConstant: 600),
        ])
        
        currentMonthLabel.translatesAutoresizingMaskIntoConstraints = false
        previousMonth.translatesAutoresizingMaskIntoConstraints = false
        nextMonth.translatesAutoresizingMaskIntoConstraints = false
        daysNameStackView.translatesAutoresizingMaskIntoConstraints = false
        calendarCollectionView.translatesAutoresizingMaskIntoConstraints = false

    }
    
    @objc
    private func previousButtonDidPressed() {
        presenter.minusMonth()
    }
    
    @objc
    private func nextButtonDidPressed() {
        presenter.plusMonth()
    }
    
    private func fillStackView() {
        let daysArray = ["Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вс"]
        for day in daysArray {
            daysNameStackView.addArrangedSubview(dayOfWeekLabelFactory(text: day))
        }
    }
    
    private func dayOfWeekLabelFactory(text: String) -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .mainBoldHelvetica(size: 24)
        label.text = text
        return label
    }
}

extension TeamViewController: TeamViewControllerProtocol {
    func showAlert(errorDescription: String) {
        print(errorDescription)
    }
    func reloadData() {
        calendarCollectionView.reloadData()
    }

}

extension TeamViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfCells()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = calendarCollectionView.dequeueReusableCell(
            withReuseIdentifier: TeamCollectionViewCell.identifier,
            for: indexPath) as? TeamCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configCell(data: presenter.dataForCellBy(indexPath: indexPath))
        return cell
    }
}
