//
//  ProjectDetailViewController.swift
//  Doocine-iOS
//
//  Created by Sohn on 06/04/2017.
//  Copyright © 2017 Sohn. All rights reserved.
//

import UIKit

class ProjectDetailViewController: BaseViewController {

    var project: MovieStoryboard!
    
    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var projectTitle: UILabel!
    @IBOutlet weak var director: UILabel!
    @IBOutlet weak var cameraMan: UILabel!
    @IBOutlet weak var actor: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initNavigation()
        self.initViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
    }
}
