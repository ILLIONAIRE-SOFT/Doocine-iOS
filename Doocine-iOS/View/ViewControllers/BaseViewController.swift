//
//  BaseViewController.swift
//  Doocine-iOS
//
//  Created by Sohn on 18/03/2017.
//  Copyright © 2017 Sohn. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func initNavigation(barTintColor: UIColor = UIColor.white, barTitle: String = "Doocine") -> Void {
        self.navigationController?.navigationBar.barTintColor = barTintColor
        self.navigationItem.title = barTitle
    }
}
