//
//  ProjectCell.swift
//  Doocine-iOS
//
//  Created by Sohn on 17/04/2017.
//  Copyright © 2017 Sohn. All rights reserved.
//

import UIKit
import SnapKit
import RealmSwift

class ProjectCell: UICollectionViewCell {
    var project: MovieStoryboard!
    var projectImageView = UIImageView()
    var projectTitleLabel = UILabel()
    var projectGroupLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: CGRect())
        self.layer.borderWidth = 0.5
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
        self.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.7).cgColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func initCell(project: MovieStoryboard, order: Int) -> Void {
        
        let realm = try! Realm()
        let scene = realm.objects(Scene.self).filter("storyboardId == \(project.id)").first
        
        if scene != nil {
            let sceneId = scene?.id
            let cut = realm.objects(Cut.self).filter("sceneId == \(sceneId ?? 0)").first
            if cut != nil {
                let cutImage = PhotoManager.loadImage(imageId: (cut?.id)!)
                
                if cutImage != nil {
                    projectImageView.image = cutImage
                } else {
                    projectImageView.image = UIImage(named: "img_blank_project")
                }
            } else {
                projectImageView.image = UIImage(named: "img_blank_project")
            }
        } else {
            projectImageView.image = UIImage(named: "img_blank_project")
        }
        
        projectImageView.clipsToBounds = true
        projectImageView.contentMode = .scaleAspectFill
        
        self.addSubview(projectImageView)
        
        projectImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.bottom.equalTo(self).offset(-54)
        }
        
        projectGroupLabel.text = project.group
        projectGroupLabel.textColor = UIColor.darkGray
        projectGroupLabel.font = UIFont.systemFont(ofSize: 12)
        
        self.addSubview(projectGroupLabel)
        
        projectGroupLabel.snp.makeConstraints { (make) in
            make.top.equalTo(projectImageView.snp.bottom).offset(8)
            make.left.equalTo(self).offset(8)
            make.right.equalTo(self).offset(-8)
        }
        
        projectTitleLabel.text = project.title
        projectTitleLabel.font = UIFont.systemFont(ofSize: 14)
        
        self.addSubview(projectTitleLabel)
        
        projectTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(projectGroupLabel.snp.bottom).offset(4)
            make.left.equalTo(self).offset(8)
            make.right.equalTo(self).offset(-8)
        }
    }
}
