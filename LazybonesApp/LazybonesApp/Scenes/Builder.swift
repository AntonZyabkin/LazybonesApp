//
//  Игшдвук.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 09.10.2022.
//

import UIKit

protocol Builder {
    
    static func createDetailInfoVC(typeOfData: String) -> UIViewController
}

class ModuleBuilder: Builder{
    
    static func createDetailInfoVC(typeOfData: String) -> UIViewController {
        let user = User(
            id: 1,
            name: typeOfData,
            username: "test2",
            email: "ee@faff",
            address: Address(
                street: "1",
                suite: "1",
                city: "2",
                zipcode: "3",
                geo: Geo(
                    lat: "geo1",
                    lng: "geo4")),
            phone: "1141233",
            website: "131sdsd.df",
            company: Company(
                name: "test33",
                catchPhrase: "sasg33",
                bs: "sdv")
        )
        
        let view = DetailInfoViewController()
        let presenter = DetailInfoPresenter(view: view, user: user)
        view.presenter = presenter
        return view
    }
}
