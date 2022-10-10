//
//  MainPresenter.swift
//  LazybonesApp
//
//  Created by Игорь Дикань on 08.10.2022.
//

// MARK: - MainPresentatisonLogic

protocol MainPresentatisonLogic: AnyObject {
    func viewDidLoad()
    func didTapButton()
}

// MARK: - MainPresenter

final class MainPresenter {
    
    weak var viewController: MainDisplayLogic?
    
    private let networkService: Networkable
    
    init(networkService: Networkable) {
        self.networkService = networkService
    }
}

// MARK: - MainPresenter

extension MainPresenter: MainPresentatisonLogic {
    func viewDidLoad() {
        networkService.request()
        viewController?.updateView()
    }
    
    func didTapButton() {
    }
}
