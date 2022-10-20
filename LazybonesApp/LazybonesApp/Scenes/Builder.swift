//
//  Игшдвук.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 09.10.2022.
//

import UIKit
import Moya

protocol Builder {
    
    static func createDetailInfoVC(with method: Action) -> UIViewController
}

class ModuleBuilder: Builder{
    
    static func createDetailInfoVC(with method: Action) -> UIViewController {

        let view = DetailInfoViewController()
        let decoderService = DecoderServise()
        let networkService = NetworkService(decoderService: decoderService)
        let apiService = APIService(netwokkService: networkService, method: method)
        let presenter = DetailInfoPresenter(apiService: apiService)
        view.presenter = presenter
        presenter.view = view
        return view
    }
}
