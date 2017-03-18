//
//  HomeViewController.swift
//  Doocine-iOS
//
//  Created by Sohn on 18/03/2017.
//  Copyright © 2017 Sohn. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        initNavigation()
    }
    
    private func initNavigation() {
        super.initNavigation(barTintColor: UIColor.white)
    }
}
