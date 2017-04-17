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
    
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var browseAllButton: UIButton!
    @IBOutlet weak var projectCountLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    var projects: [MovieStoryboard] = [MovieStoryboard]()
    
    fileprivate let sectionInsets = UIEdgeInsets(top: 10.0, left: 24.0, bottom: 10.0, right: 24.0)
    fileprivate var itemsPerRow: CGFloat = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initNavigation()
        self.initViews()
        self.initButtons()
        self.fetchStoryboards()
    }
    
    private func initNavigation() {
        super.initNavigation(barTintColor: UIColor.white, barTitle: "Doocine")
    }
    
    private func initViews() {
        let tapBanner = UITapGestureRecognizer(target: self, action: #selector(tappedIntro))
        
        self.bannerImageView.addGestureRecognizer(tapBanner)
        self.bannerImageView.isUserInteractionEnabled = true
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(MakeProjectCell.self, forCellWithReuseIdentifier: "MakeProjectCell")
        self.collectionView.register(ProjectCell.self, forCellWithReuseIdentifier: "ProjectCell")
    }
    
    private func initButtons() -> Void {
        self.browseAllButton.addTarget(self, action: #selector(tappedBrowseAll), for: .touchUpInside)
    }
    
    public func fetchStoryboards() -> Void {
        self.projects.removeAll()
        
        let realm = try! Realm()
//        print(realm.objects(MovieStoryboard.self))
        
        let movieStoryboards = realm.objects(MovieStoryboard.self)
        
        for storyboard in movieStoryboards {
            self.projects.append(storyboard)
        }
        
        self.collectionView.reloadData()
        self.projectCountLabel.text = String(self.projects.count)
    }
}


// MARK: - CollectionView Delegate, DataSource
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.projects.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MakeProjectCell", for: indexPath) as! MakeProjectCell
            cell.initCell()
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProjectCell", for: indexPath) as! ProjectCell
            cell.project = self.projects[indexPath.item - 1]
            cell.initCell(project: self.projects[indexPath.item - 1], order: indexPath.item)
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 0 {
            self.tappedMakeNewProject()
        } else {
            let controller = storyboard?.instantiateViewController(withIdentifier: "ProjectDetailViewController") as! ProjectDetailViewController
            controller.project = projects[indexPath.item - 1]
            
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}


// MARK: - Collection View Flow Layout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var insets = UIEdgeInsets()
        
        insets = self.sectionInsets
        
        let paddingSpace = insets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        let height: CGFloat = 200
        
        return CGSize(width: widthPerItem, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return self.sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return self.sectionInsets.left
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
            let realm = try! Realm()
            
            try! realm.write {
                realm.add(movieStoryboard)
            }
            
            popup.dismiss()
            
            self.fetchStoryboards()
        }
        
        popup.didShowHandler { (_) in
            
        }
        
        popup.didCloseHandler { (_) in
            
        }
        
        popup = popup.show(controller)
    }
    
    public func tappedBrowseAll() -> Void {
        let controller = storyboard?.instantiateViewController(withIdentifier: "ProjectListViewController")
        
        self.navigationController?.pushViewController(controller!, animated: true)
    }
    
    func tappedIntro() -> Void {
        let controller = storyboard?.instantiateViewController(withIdentifier: "IntroViewController")
        
        self.navigationController?.pushViewController(controller!, animated: true)
    }
}
