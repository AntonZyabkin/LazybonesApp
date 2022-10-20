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
    var data: [Decodable] = []

    //MARK: - viewDidLoad
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
        data = responce
    }
    func failure(error: Error) {
        let alert = UIAlertController(
            title: error.localizedDescription.description,
            message: nil, preferredStyle: .alert
        )
        let canselButton = UIAlertAction(title: "Cancel", style: .cancel) { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }
        alert.addAction(canselButton)
        self.present(alert, animated: true)    }
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
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailinfoTableViewCell.identifier, for: indexPath) as! DetailinfoTableViewCell
        cell.labelName.frame = cell.bounds
        return UITableViewCell()
    }
}
 
