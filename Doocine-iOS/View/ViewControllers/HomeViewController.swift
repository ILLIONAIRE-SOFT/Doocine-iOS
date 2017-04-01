//
//  HomeViewController.swift
//  Doocine-iOS
//
//  Created by Sohn on 18/03/2017.
//  Copyright © 2017 Sohn. All rights reserved.
//

import UIKit
import SnapKit
import PopupController
import RealmSwift

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
        homeProjectScrollView.handleTapMakeNewProject = {
            self.tappedMakeNewProject()
        }
        
        self.view.addSubview(homeProjectScrollView)
        homeProjectScrollView.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(0)
            make.right.equalTo(self.view).offset(0)
            make.top.equalTo(homeHeaderView.snp.bottom)
            make.height.equalTo(380)
        }
        
        let doocineBanner = UIImageView()
        doocineBanner.contentMode = .scaleAspectFill
        doocineBanner.image = UIImage(named: "img_banner_doocine")
        
        self.view.addSubview(doocineBanner)
        doocineBanner.snp.makeConstraints { (make) in
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
            make.top.equalTo(homeProjectScrollView.snp.bottom)
            make.height.equalTo(200)
        }
    }
    
    public func refresh() -> Void {
        // Realm에서 Storyboard 부르고
        // HomeProjectScrollView storyboard 교체해 주고 reload
        
        
    }
}


// MARK: - Tap Action
extension HomeViewController {
    fileprivate func tappedMakeNewProject() -> Void {
        var popup = PopupController.create(self).customize(
                                                [.animation(.slideUp),
                                                .scrollable(false),
                                                .backgroundStyle(.blackFilter(alpha:0.7)),
                                                .layout(.center),
                                                .movesAlongWithKeyboard(true)
                                                
                                                ])
        let popupSB = UIStoryboard(name: "Popup", bundle: nil)
        let controller = popupSB.instantiateViewController(withIdentifier: "CreateProjectPopup") as! CreateProjectPopup
        
        controller.delegateTappedClose = {
            popup.dismiss()
        }
        
        controller.delegateCreate = { movieStoryboard in
            print("무비스토리보드 생성시작")
            print(movieStoryboard.title)
            print(movieStoryboard.director)
            
            let realm = try! Realm()
            
            try! realm.write {
                realm.add(movieStoryboard)
            }
            
            popup.dismiss()
        }
        
        popup.didShowHandler { (_) in
            
        }
        
        popup.didCloseHandler { (_) in
            
        }
        
        popup = popup.show(controller)
    }
}
