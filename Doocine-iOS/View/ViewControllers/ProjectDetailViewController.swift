//
//  ProjectDetailViewController.swift
//  Doocine-iOS
//
//  Created by Sohn on 06/04/2017.
//  Copyright © 2017 Sohn. All rights reserved.
//

import UIKit

class ProjectDetailViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    var project: MovieStoryboard!
    var scenes: [Scene] = [Scene]()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.makeTestScenes()
        self.initNavigation()
        self.initViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.expandHeaderViewWithoutDelay()
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
        
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = UIColor.groupTableViewBackground
        self.tableView.separatorStyle = .none
    }
    
    private func makeTestScenes() -> Void {
        for _ in 0 ..< 2 {
            let scene = Scene()
            scene.place = "Chungmuro Pildong"
            scene.time = "Late evening"
            scene.title = "Beautiful Scene"
            
            scenes.append(scene)
        }
    }
}


// MARK: - Table View Delegate, DataSource
extension ProjectDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scenes.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cell = ProjectSceneCell(style: .default, reuseIdentifier: "ProjectSceneCell", scene: scenes[indexPath.row], order: indexPath.row + 1)
        return cell.getHeight()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ProjectSceneCell(style: .default, reuseIdentifier: "ProjectSceneCell", scene: scenes[indexPath.row], order: indexPath.row + 1)
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        reduceHeaderView()
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
    
    fileprivate func expandHeaderView() -> Void {
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
