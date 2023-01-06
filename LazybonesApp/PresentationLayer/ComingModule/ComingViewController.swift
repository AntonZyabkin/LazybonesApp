//
//  ComingViewController.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 25.10.2022.
//

import UIKit

protocol ComingViewProtocol: UIViewController {
    func updateTableView(_ withDocuments: [Document])
    func showErrorAlert(_ error: Error)
    func configeActivityIndicator()
}

final class ComingViewController: UIViewController {

    var presenter: ComingViewPresenterProtocol?
    private var comingDocumentArray: [Document] = []
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .myGray
        tableView.separatorStyle = .none
        tableView.rowHeight = 160
        return tableView
    }()
    
    private lazy var logOutSbisNavBarItem = UIBarButtonItem()
    private lazy var activityIndicator = UIActivityIndicatorView(style: .medium)
    //TODO: переделай реюз идентификатор как свойство ячейки
    let reuseIdentifier = "contractor"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configeTableView()
        configeNavBar()
        view.backgroundColor = .white
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.safeAreaLayoutGuide.layoutFrame
    }

    private func configeTableView() {
        tableView.register(CominTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        view.addSubview(tableView)
        tableView.frame = view.frame
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func configeNavBar() {
        logOutSbisNavBarItem = UIBarButtonItem(title: "Выйти из Сбис", style: .plain, target: self, action: #selector(logOutItemDidPress))
        navigationItem.rightBarButtonItem = logOutSbisNavBarItem
    }
    
    @objc
    func logOutItemDidPress() {
        presenter?.logOutItemDidPress()
    }
}

//MARK: - ComingInfoViewProtocol confirm
extension ComingViewController: ComingViewProtocol {
    func updateTableView(_ withDocuments: [Document]) {
        if withDocuments.isEmpty {
            logOutSbisNavBarItem.title = "Войти в Сбис"
        } else {
            logOutSbisNavBarItem.title = "Выйти из Сбис"
        }
        self.comingDocumentArray = withDocuments
        tableView.reloadData()
        activityIndicator.isHidden = true
    }
    func showErrorAlert(_ error: Error) {
        print(error)
        let errorAlert = UIAlertController(title: error.localizedDescription, message: nil, preferredStyle: .alert)
        let errorAlertButton = UIAlertAction(title: "Ok", style: .cancel)
        errorAlert.addAction(errorAlertButton)
        present(errorAlert, animated: true)
    }
    func configeActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
    }
}

//MARK: - UITableViewDataSource
extension ComingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        comingDocumentArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? CominTableViewCell else { return UITableViewCell()}
        cell.setupCellContent(comingList: comingDocumentArray[indexPath.row])
        return cell
    }
}
//MARK: - UITableViewDelegate
extension ComingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didTabComingDocument(at: indexPath.row)
    }
}
