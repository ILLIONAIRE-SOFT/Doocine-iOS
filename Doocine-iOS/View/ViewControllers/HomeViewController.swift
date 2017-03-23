//
//  HomeViewController.swift
//  Doocine-iOS
//
//  Created by Sohn on 18/03/2017.
//  Copyright © 2017 Sohn. All rights reserved.
//

import UIKit
import SnapKit

class HomeViewController: BaseViewController {
    
    var homeHeaderView: HomeHeaderView!
    var homeProjectScrollView: HomeProjectScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initNavigation()
        initViews()
    }
    
    private func initNavigation() {
        super.initNavigation(barTintColor: UIColor.white, barTitle: "Doocine")
    }
    
    private func initViews() {
        homeHeaderView = HomeHeaderView()
        
        self.view.addSubview(homeHeaderView)
        homeHeaderView.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(0)
            make.right.equalTo(self.view).offset(0)
            make.top.equalTo(self.view).offset(0)
            make.height.equalTo(200)
        }
        
        homeProjectScrollView = HomeProjectScrollView()
        
        self.view.addSubview(homeProjectScrollView)
        homeProjectScrollView.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(0)
            make.right.equalTo(self.view).offset(0)
            make.top.equalTo(homeHeaderView.snp.bottom)
            make.height.equalTo(300)
        }
        
    }
}
