//
//  SplashViewController.swift
//  Doocine-iOS
//
//  Created by Sohn on 18/03/2017.
//  Copyright © 2017 Sohn. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if isFirstLaunch() {
            presentTutorialViewController()
        } else {
            presentTutorialViewController()
//            presentHomeViewController()
        }
    }
}


// MARK: - Segue
extension SplashViewController {
    fileprivate func presentHomeViewController() -> Void {
        self.performSegue(withIdentifier: "PresentHomeViewController", sender: self)
    }
    
    fileprivate func presentTutorialViewController() -> Void {
        self.performSegue(withIdentifier: "PresentTutorialViewController", sender: self)
    }
}


// MARK: - Check First Launch
extension SplashViewController {
    fileprivate func isFirstLaunch() -> Bool {
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if launchedBefore  {
            return false
        } else {
            UserDefaults.standard.set(true, forKey: "launchedBefore")
            return true
        }
    }
}
