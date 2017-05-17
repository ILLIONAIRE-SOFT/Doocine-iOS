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

    @IBOutlet weak var deleteProjectButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    var project: MovieStoryboard!
    var scenes: [Scene] = [Scene]()
    
    @IBOutlet weak var reduceOrExpandButton: UIImageView!
    var isExpand: Bool = true
    
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
        
        self.initNavigation()
        self.initViews()
        self.initButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.expandHeaderViewWithoutDelay()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.showLoading(view: self.view)
        self.fetchScenes()
    }
    
    private func initNavigation() -> Void {
        super.initNavigation(barTintColor: .white, barTitle: "PROJECT")
        
        let shareBarButton = UIBarButtonItem(image: UIImage(named: "icon_export"), style: .plain, target: self, action: #selector(tappedShare))
        
        self.navigationItem.rightBarButtonItem = shareBarButton
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
        self.reduceOrExpandButton.isUserInteractionEnabled = true
        let tapReduceOrExpand = UITapGestureRecognizer(target: self, action: #selector(tappedReduceOrExpand))
        self.reduceOrExpandButton.addGestureRecognizer(tapReduceOrExpand)
        self.deleteProjectButton.tintColor = UIColor.orange
        self.deleteProjectButton.setImage(UIImage(named: "icon_delete")?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.deleteProjectButton.addTarget(self, action: #selector(tappedDelete), for: .touchUpInside)
    }
    
    private func fetchScenes() -> Void {
        let realm = try! Realm()
        let scenes = realm.objects(Scene.self).filter("storyboardId == \(self.project.id)")
        
        self.scenes.removeAll()
        
        for scene in scenes {
            self.scenes.append(scene)
        }
        
        self.hideLoading()
        
        self.collectionView.reloadData()
        self.tableView.reloadData()
    }
    
    public func deleteProject() -> Void {
        let realm = try! Realm()
        
        let scenes = realm.objects(Scene.self).filter("storyboardId == \(self.project.id)")
        
        for scene in scenes {
            let cuts = realm.objects(Cut.self).filter("sceneId == \(scene.id)")
            
            for cut in cuts {
                PhotoManager.deleteImage(imageId: cut.id)
                
                try! realm.write {
                    realm.delete(cut)
                }
            }
            
            try! realm.write {
                realm.delete(scene)
            }
        }
        
        let project = realm.objects(MovieStoryboard.self).filter("id == \(self.project.id)")
        
        try! realm.write {
            realm.delete(project)
        }
        
        self.navigationController?.popViewController(animated: true)
    }
}


// MARK: - Table View Delegate, DataSource
extension ProjectDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if scenes.count == 0 {
            return 0
        } else {
            return scenes.count + 1
        }
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
            var isEmpty: Bool = false
            if scenes.count == 0 {
                isEmpty = true
            }
            
            let cell = ProjectStartCell(style: .default, reuseIdentifier: "ProjectStartCell", isEmpty: isEmpty)
            return cell
            
        default:
            let cell = ProjectSceneCell(style: .default, reuseIdentifier: "ProjectSceneCell", scene: scenes[indexPath.row-1], order: indexPath.row)
            cell.rootController = self
            
            return cell
        }
    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if scrollView == collectionView {
//            return
//        }
//        
//        reduceHeaderView()
//    }
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
        
        // 화살표 아래로 향하도록 변경
    }
    
    public func expandHeaderView() -> Void {
        self.headerViewHeightConstraint.constant = 400
        self.reducedHeaderViewHeightConstraint.constant = 0
        
        self.headerView.updateConstraints()
        
        UIView.animate(withDuration: 0.4) {
            self.view.layoutIfNeeded()
        }
        
        // 화살표 위로 향하도록 변경
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


// MARK: - Tap Action
extension ProjectDetailViewController {
    public func tappedShare() -> Void {
        let shareImage = self.tableView.screenshot
        
        let shareItems: Array = [shareImage]
        let activityVC = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
        
        activityVC.popoverPresentationController?.sourceView = self.view
        
        self.present(activityVC, animated: true, completion: nil)
    }
    
    public func tappedReduceOrExpand() -> Void {
        if isExpand {
            isExpand = false
            self.reduceHeaderView()
        } else {
            isExpand = true
            self.expandHeaderView()
        }
    }
    
    public func tappedDelete() -> Void {
        let alert = UIAlertController(title: "", message: "프로젝트를 삭제하시겠습니까?", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "삭제", style: UIAlertActionStyle.destructive, handler: { (action) in
            self.deleteProject()
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
