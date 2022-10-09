//
//  JSONPlaceHolderTableViewPresenter.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 08.10.2022.
//

import Foundation




class PlaceHolderPresenter {}

protocol MainVeiwProtocol: AnyObject {

    func succes()
    func failure(error: Error)
}

protocol PlaceHolderViewPresenterProtocol {
    
    init(view: MainVeiwProtocol, networkService: NetworkServiceProtocol)
    func getComments()
    var comments: [User]? {get set}
}
