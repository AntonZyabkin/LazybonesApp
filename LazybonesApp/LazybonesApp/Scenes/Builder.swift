//
//  Игшдвук.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 09.10.2022.
//

import UIKit

protocol Builder {
    
    static func createDetailInfoVC(didSelectedURL: String) -> UIViewController
}

class ModuleBuilder: Builder{
    
    static func createDetailInfoVC(didSelectedURL: String) -> UIViewController {

        let view = DetailInfoViewController()
        let networkServise = NetworkService()
        let presenter = DetailInfoPresenter(view: view, networkService: networkServise, didSelectedURL: didSelectedURL)
        view.presenter = presenter
        return view
    }
}
