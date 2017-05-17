//
//  ProjectListCell.swift
//  Doocine-iOS
//
//  Created by Sohn on 06/04/2017.
//  Copyright © 2017 Sohn. All rights reserved.
//

import UIKit
import SnapKit
import RealmSwift

class ProjectListCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: CGRect())
        
        self.backgroundColor = UIColor.lightGray
        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.7).cgColor
        self.layer.borderWidth = 0.5
        self.clipsToBounds = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func initCell(with project: MovieStoryboard) -> Void {
        // MARK: - Header View
        let projectImage = UIImageView()
        
        let realm = try! Realm()
        let scene = realm.objects(Scene.self).filter("storyboardId == \(project.id)").first
        
        if scene != nil {
            let sceneId = scene?.id
            let cut = realm.objects(Cut.self).filter("sceneId == \(sceneId ?? 0)").first
            
            if cut != nil {
                let cutImage = PhotoManager.loadImage(imageId: (cut?.id)!)
                
                if cutImage != nil {
                    projectImage.image = cutImage
                } else {
                    projectImage.image = UIImage(named: "img_banner_doocine")
                }
            } else {
                projectImage.image = UIImage(named: "img_banner_doocine")
            }
        } else {
            projectImage.image = UIImage(named: "img_banner_doocine")
        }
        
        projectImage.contentMode = .scaleAspectFill
        projectImage.clipsToBounds = true
        
        self.addSubview(projectImage)
        
        projectImage.snp.makeConstraints { (make) in
            make.left.equalTo(self)
            make.top.equalTo(self)
            make.right.equalTo(self)
            make.height.equalTo(self.frame.height*0.5)
        }
        
        // MARK: - Body View
        let bodyView = UIView()
        bodyView.backgroundColor = UIColor.white
        
        self.addSubview(bodyView)
        
        bodyView.snp.makeConstraints { (make) in
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.top.equalTo(projectImage.snp.bottom)
            make.bottom.equalTo(self)
//            make.height.equalTo(self.frame.height*0.5*0.6)
        }
        
        let projectGroup = UILabel()
        projectGroup.text = project.group
        projectGroup.font = UIFont.systemFont(ofSize: 16)
        
        bodyView.addSubview(projectGroup)
        
        projectGroup.snp.makeConstraints { (make) in
            make.centerX.equalTo(bodyView)
            make.centerY.equalTo(bodyView).offset(-16)
        }

        let projectTitle = UILabel()
        projectTitle.text = project.title
        projectTitle.font = UIFont.systemFont(ofSize: 24)
        
        bodyView.addSubview(projectTitle)
        
        projectTitle.snp.makeConstraints { (make) in
            make.centerX.equalTo(bodyView)
            make.centerY.equalTo(bodyView).offset(16)
        }
        
//        let separator = UILabel()
//        separator.backgroundColor = UIColor.gray
//        
//        bodyView.addSubview(separator)
//        
//        separator.snp.makeConstraints { (make) in
//            make.height.equalTo(0.5)
//            make.left.equalTo(bodyView)
//            make.right.equalTo(bodyView)
//            make.bottom.equalTo(bodyView)
//        }
        
        // MARK: - Tail View
//        let tailView = UIView()
//        tailView.backgroundColor = UIColor.white
//        
//        self.addSubview(tailView)
//        
//        tailView.snp.makeConstraints { (make) in
//            make.left.equalTo(self)
//            make.right.equalTo(self)
//            make.top.equalTo(bodyView.snp.bottom)
//            make.height.equalTo(self.frame.height*0.5*0.4)
//        }
        
//        let sceneCountLabel = UILabel()
//        sceneCountLabel.text = "SCENE 13"
//        sceneCountLabel.backgroundColor = UIColor.greishBrown
//        sceneCountLabel.layer.cornerRadius = 8
//        sceneCountLabel.textColor = UIColor.white
//        sceneCountLabel.clipsToBounds = true
//        sceneCountLabel.textAlignment = .center
//        sceneCountLabel.font = UIFont.systemFont(ofSize: 14)
//        
//        tailView.addSubview(sceneCountLabel)
//        
//        sceneCountLabel.snp.makeConstraints { (make) in
//            make.centerY.equalTo(tailView)
//            make.left.equalTo(tailView).offset(16)
//            make.height.equalTo(30)
//            make.width.equalTo(80)
//        }
    }
}
