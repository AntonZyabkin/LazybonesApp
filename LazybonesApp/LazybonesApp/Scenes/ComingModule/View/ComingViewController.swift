//
//  ComingViewController.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 25.10.2022.
//

import UIKit

protocol ComingInfoViewProtocol: AnyObject {
    func succes(_ response: SbisShortComingListResponse)
    func failure(error: Error)
}

class ComingViewController: UIViewController {

    var presenter: ComingViewPresenterProtocol?
    let reuseItentifire = "contractor"
    var docsArray: [Document] = []
    let tableView = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        presenter?.downloadComingData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}

//MARK: - ComingInfoViewProtocol confirm
extension ComingViewController: ComingInfoViewProtocol {
    func succes(_ response: SbisShortComingListResponse) {
        docsArray = response.result.document
        setupTableView(response)
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
}

extension ComingViewController {
    func setupTableView(_ comingList: SbisShortComingListResponse) {
 
        tableView.register(CominTableViewCell.self, forCellReuseIdentifier: reuseItentifire)
        view.addSubview(tableView)
        tableView.frame = view.frame
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 100
        
    }
}

//MARK: - TableViewDataSource
extension ComingViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        docsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseItentifire, for: indexPath) as? CominTableViewCell
        cell?.setupCellContent(comingList: docsArray[indexPath.row])
        return cell ?? UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //TODO: перенести метод в Билдер
        let vc = ComingDetailsViewController()
        vc.urlTest = docsArray[indexPath.row].linkToPDF
        navigationController?.pushViewController(vc, animated: true)
    }
}
    
