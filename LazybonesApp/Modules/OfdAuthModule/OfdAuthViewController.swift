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
        
    }
}

extension OfdAuthViewController: OfdAuthViewControllerProtocol {}
