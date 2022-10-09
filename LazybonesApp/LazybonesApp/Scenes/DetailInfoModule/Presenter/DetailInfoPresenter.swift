//
//  DetainInfoPresenter.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 09.10.2022.
//

import Foundation


protocol DetailInfoViewProtocol {
    
    func setGreating(user: User)
}

protocol DetailInfoViewPresenterProtocol {
    
    init(view: DetailInfoViewProtocol, user: User)
    func showGreeting()
}

class DetailInfoPresenter: DetailInfoViewPresenterProtocol {
    
    let view: DetailInfoViewProtocol
    let user: User
    
    required init(view: DetailInfoViewProtocol, user: User) {
        self.view = view
        self.user = user
    }
    
    func showGreeting() {
        view.setGreating(user: user)
    }
}
