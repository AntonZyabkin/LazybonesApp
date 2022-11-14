//
//  ComingViewController.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 25.10.2022.
//

import UIKit

protocol ComingViewProtocol: UIViewController {
    func updateTableView(viewModel: [Document])
    func showErrorAlert(_ error: Error)
}

final class ComingViewController: UIViewController {

    var presenter: ComingViewPresenterProtocol?
    let reuseIdentifier = "contractor"
    private var viewModel: [Document] = []
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        view.backgroundColor = .white
        presenter?.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func setupTableView() {
        tableView.register(CominTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        view.addSubview(tableView)
        tableView.frame = view.frame
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 100
    }
}

//MARK: - ComingInfoViewProtocol confirm
extension ComingViewController: ComingViewProtocol {
    func updateTableView(viewModel: [Document]) {
        self.viewModel = viewModel
        tableView.reloadData()
    }
    func showErrorAlert(_ error: Error) {
        let errorAlert = UIAlertController(title: error.localizedDescription, message: nil, preferredStyle: .alert)
        let alertButton = UIAlertAction(title: "Ok", style: .cancel)
        errorAlert.addAction(alertButton)
        present(errorAlert, animated: true)
    }
}

//MARK: - UITableViewDataSource
extension ComingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? CominTableViewCell
        cell?.setupCellContent(comingList: viewModel[indexPath.row])
        return cell ?? UITableViewCell()
    }
}
//MARK: - UITableViewDelegate
extension ComingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didTabComingDocument(at: indexPath.row)
    }
}
