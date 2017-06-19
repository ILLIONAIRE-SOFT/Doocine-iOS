//
//  ProjectListViewController.swift
//  Doocine-iOS
//
//  Created by Sohn on 06/04/2017.
//  Copyright © 2017 Sohn. All rights reserved.
//

import UIKit
import RealmSwift

class ProjectListViewController: BaseViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var projects: [MovieStoryboard] = [MovieStoryboard]()
    
    fileprivate let sectionInsets = UIEdgeInsets(top: 40.0, left: 48.0, bottom: 30.0, right: 48.0)
    fileprivate var itemsPerRow: CGFloat = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initNavigation()
        self.initViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        super.showLoading(view: self.view)
        self.refresh()
    }
    
    private func initNavigation() -> Void {
        super.initNavigation(barTintColor: .white, barTitle: "EXPLORE")
    }
    
    private func initViews() -> Void {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.groupTableViewBackground
        self.collectionView.register(ProjectListCell.self, forCellWithReuseIdentifier: "ProjectListCell")
    }
    
    fileprivate func refresh() -> Void {
        let realm = try! Realm()
        let movieStoryboards = realm.objects(MovieStoryboard.self)
        
        self.projects.removeAll()
        
        for storyboard in movieStoryboards {
            self.projects.append(storyboard)
        }
        
        super.hideLoading()
        
        self.collectionView.reloadData()
    }
}


// MARK: - Collection View Delegate, DataSource
extension ProjectListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.projects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProjectListCell", for: indexPath) as! ProjectListCell
        cell.initCell(with: projects[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "ProjectDetailViewController") as! ProjectDetailViewController
        controller.project = projects[indexPath.item]
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
}


extension ProjectListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
