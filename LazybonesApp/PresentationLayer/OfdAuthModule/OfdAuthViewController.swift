//
//  OfdAuthViewController.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 16.12.2022.
//

import UIKit

final class OfdAuthViewController: SbisAuthViewController {
    var loader: DashboardLoaderProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginTextfield.placeholder = "Введите логин OFD.RU"
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        loader?.startLoadData()
    }
}
