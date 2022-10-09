//
//  DetailInfoViewController.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 09.10.2022.
//

import UIKit

class DetailInfoViewController: UIViewController {
    
    var presenter: DetailInfoViewPresenterProtocol!
    private var tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        presenter.showGreeting()
        setupDetailInfoViewController()
    }
}

//MARK: - DetailInfoViewProtocol Impl
extension DetailInfoViewController: DetailInfoViewProtocol {
    
    func setGreating(user: User) {
        print(user.name)
    }
}

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
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailinfoTableViewCell.identifier, for: indexPath) as! DetailinfoTableViewCell
        cell.backgroundColor = .red
        return cell
    }
}

//MARK: - UITableView Delegate Impl
extension DetailInfoViewController: UITableViewDelegate {
    
}
