//
//  OfdAuthViewController.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 16.12.2022.
//

import UIKit

protocol OfdAuthViewControllerProtocol {}

class OfdAuthViewController: SbisAuthViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginTextfield.placeholder = "Введите логин OFD.RU"
    }
}

extension OfdAuthViewController: OfdAuthViewControllerProtocol {}
