//
//  DetailInfoViewController.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 09.10.2022.
//

import UIKit

class DetailInfoViewController: UIViewController {
    
    var presenter: DetailInfoViewPresenterProtocol!
    var tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        setupDetailInfoViewController()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

//MARK: - DetailInfoViewProtocol Impl
extension DetailInfoViewController: DetailInfoViewProtocol {
    
    func failure(error: Error) {
        print(error)
    }
    
    func succes() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

}

    // ЖОПААААААА

//MARK: - Setting TableView
extension DetailInfoViewController {
    
    func setupDetailInfoViewController() {
        setTableView()
        addSubviews()
    }
    
    private func addSubviews() {
        view.addSubview(tableView)
    }
    private func setTableView() {
        tableView.frame = view.bounds
        tableView.register(DetailinfoTableViewCell.self, forCellReuseIdentifier: DetailinfoTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
    }
}

//MARK: - UITableView DataSourse Impl
extension DetailInfoViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let array = presenter.data else { return 0 }
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailinfoTableViewCell.identifier, for: indexPath) as! DetailinfoTableViewCell

        if let data = presenter.data as? [Post] {
            cell.labelName.text = data[indexPath.row].title
        } else if let data = presenter.data as? [User] {
            cell.labelName.text = data[indexPath.row].name
        } else if let data = presenter.data as? [Comment] {
            cell.labelName.text = data[indexPath.row].name
        }
        cell.labelName.frame = cell.bounds
        return cell
    }
}

//MARK: - UITableView Delegate Impl
extension DetailInfoViewController: UITableViewDelegate {
    
}
