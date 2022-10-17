//
//  Игшдвук.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 09.10.2022.
//

import UIKit

protocol Builder {
    
    static func createDetailInfoVC(didSelectURL: Int) -> UIViewController
}

class ModuleBuilder: Builder{
    
    static func createDetailInfoVC(didSelectURL: Int) -> UIViewController {

        let view = DetailInfoViewController()
        let decoderService = DecoderServise()
        let networkService = NetworkService(decoderService: decoderService)
        let apiService = APIService(netwokkService: networkService)
        let presenter = DetailInfoPresenter(apiService: apiService)
        view.presenter = presenter
        presenter.view = view
        return view
    }
}
