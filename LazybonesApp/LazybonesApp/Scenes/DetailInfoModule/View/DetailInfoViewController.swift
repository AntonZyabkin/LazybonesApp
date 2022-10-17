//
//  DetailInfoViewController.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 09.10.2022.
//

import UIKit

protocol DetailInfoViewProtocol: AnyObject {
    func succes<T: Decodable>(_ responce: [T])
    func failure(error: Error)
}
class DetailInfoViewController: UIViewController {
    
    var presenter: DetailInfoViewPresenterProtocol!
    var tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        setupDetailInfoViewController()
        presenter.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

//MARK: - DetailInfoViewProtocol Impl
extension DetailInfoViewController: DetailInfoViewProtocol {
    func succes<T>(_ responce: [T]) where T : Decodable {
        print(responce.first)
    }
    
    func failure(error: Error) {
        print(error)
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
    }
}

//MARK: - UITableView DataSourse Impl
extension DetailInfoViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: DetailinfoTableViewCell.identifier, for: indexPath) as! DetailinfoTableViewCell
//
//        if let data = presenter.data as? [Post] {
//            cell.labelName.text = data[indexPath.row].title
//        } else if let data = presenter.data as? [User] {
//            cell.labelName.text = data[indexPath.row].name
//        } else if let data = presenter.data as? [Comment] {
//            cell.labelName.text = data[indexPath.row].name
//        }
//        cell.labelName.frame = cell.bounds
        return UITableViewCell()
    }
}
