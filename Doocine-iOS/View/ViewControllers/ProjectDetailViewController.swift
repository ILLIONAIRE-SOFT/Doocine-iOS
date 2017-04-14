//
//  ProjectDetailViewController.swift
//  Doocine-iOS
//
//  Created by Sohn on 06/04/2017.
//  Copyright © 2017 Sohn. All rights reserved.
//

import UIKit
import RealmSwift

class ProjectDetailViewController: BaseViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    var project: MovieStoryboard!
    var scenes: [Scene] = [Scene]()
    
    @IBOutlet weak var expandButton: UIButton!
    
    @IBOutlet weak var reducedHeaderView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var projectTitle: UILabel!
    @IBOutlet weak var director: UILabel!
    @IBOutlet weak var cameraMan: UILabel!
    @IBOutlet weak var actor: UILabel!
    @IBOutlet weak var headerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var reducedHeaderViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var reducedHeaderGroupName: UILabel!
    @IBOutlet weak var reducedHeaderProjectTitle: UILabel!
    
    fileprivate let sectionInsets = UIEdgeInsets(top: 10.0, left: 24.0, bottom: 10.0, right: 24.0)
    fileprivate var itemsPerRow: CGFloat = 4
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        self.fetchScenes()
//        self.makeTestScenes()
        self.initNavigation()
        self.initViews()
        self.initButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.expandHeaderViewWithoutDelay()
        self.fetchScenes()
    }
    
    private func initNavigation() -> Void {
        super.initNavigation(barTintColor: .white, barTitle: "PROJECT")
    }
    
    private func initViews() -> Void {
        self.groupName.text = project.group
        self.projectTitle.text = project.title
        self.director.text = project.director
        self.cameraMan.text = project.cameraMan
        self.actor.text = project.actor
        
        self.reducedHeaderProjectTitle.text = project.title
        self.reducedHeaderGroupName.text = project.group
        self.reducedHeaderView.clipsToBounds = true
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = UIColor.groupTableViewBackground
        self.tableView.separatorStyle = .none
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(ProjectDetailCollectionCell.self, forCellWithReuseIdentifier: "ProjectDetailCollectionCell")
        self.collectionView.register(MakeSceneCollectionViewCell.self, forCellWithReuseIdentifier: "MakeSceneCollectionViewCell")
    }
    
    private func initButton() -> Void {
        self.expandButton.addTarget(self, action: #selector(expandHeaderView), for: .touchUpInside)
    }
    
    private func fetchScenes() -> Void {
        let realm = try! Realm()
        let scenes = realm.objects(Scene.self).filter("storyboardId == \(self.project.id)")
        
        self.scenes.removeAll()
        
        for scene in scenes {
            self.scenes.append(scene)
        }
        
        self.collectionView.reloadData()
        self.tableView.reloadData()
    }
    
    private func makeTestScenes() -> Void {
        for _ in 0 ..< 11 {
            let scene = Scene()
            scene.place = "Chungmuro Pildong"
            scene.time = "Late evening"
            
            scenes.append(scene)
        }
        
        self.collectionView.reloadData()
    }
}


// MARK: - Table View Delegate, DataSource
extension ProjectDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scenes.count + 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return ProjectStartCell.getHeight()
            
        default:
            let cell = ProjectSceneCell(style: .default, reuseIdentifier: "ProjectSceneCell", scene: scenes[indexPath.row-1], order: indexPath.row)
            return cell.getHeight()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = ProjectStartCell(style: .default, reuseIdentifier: "ProjectStartCell")
            return cell
            
        default:
            let cell = ProjectSceneCell(style: .default, reuseIdentifier: "ProjectSceneCell", scene: scenes[indexPath.row-1], order: indexPath.row)
            cell.scene = scenes[indexPath.row-1]
            cell.rootController = self
            
            return cell
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == collectionView {
            return
        }
        
        reduceHeaderView()
    }
}


// MARK: - Collection View Delegate, DataSource
extension ProjectDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.scenes.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MakeSceneCollectionViewCell", for: indexPath) as! MakeSceneCollectionViewCell
            cell.initCell()
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProjectDetailCollectionCell", for: indexPath) as! ProjectDetailCollectionCell
            cell.scene = scenes[indexPath.item - 1]
            cell.initCell(scene: scenes[indexPath.item - 1], order: indexPath.item)
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 0 {
            let controller = storyboard?.instantiateViewController(withIdentifier: "MakeSceneViewController") as! MakeSceneViewController
            controller.storyboardId = self.project.id
            
            self.navigationController?.pushViewController(controller, animated: true)
        } else {
            self.tableView.scrollToRow(at: IndexPath(row: indexPath.item, section: 0), at: UITableViewScrollPosition.top, animated: true)
        }
    }
}


// MARK: - Collection View Flow Layout
extension ProjectDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var insets = UIEdgeInsets()
        
        insets = sectionInsets
        
        let paddingSpace = insets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        let height: CGFloat = 120
        
        return CGSize(width: widthPerItem, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}

// MARK: - Animation
extension ProjectDetailViewController {
    fileprivate func reduceHeaderView() -> Void {
        self.headerViewHeightConstraint.constant = 0
        self.reducedHeaderViewHeightConstraint.constant = 100
        
        self.headerView.updateConstraints()
        
        UIView.animate(withDuration: 0.4) {
            self.view.layoutIfNeeded()
        }
    }
    
    public func expandHeaderView() -> Void {
        self.headerViewHeightConstraint.constant = 400
        self.reducedHeaderViewHeightConstraint.constant = 0
        
        self.headerView.updateConstraints()
        
        UIView.animate(withDuration: 0.4) {
            self.view.layoutIfNeeded()
        }
    }
    
    fileprivate func expandHeaderViewWithoutDelay() -> Void {
        self.headerViewHeightConstraint.constant = 400
        self.reducedHeaderViewHeightConstraint.constant = 0
        
        self.headerView.updateConstraints()
        
        UIView.animate(withDuration: 0) {
            self.view.layoutIfNeeded()
        }
    }
}
