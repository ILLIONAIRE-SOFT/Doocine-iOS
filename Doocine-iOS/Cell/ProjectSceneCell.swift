//
//  ProjectSceneCell.swift
//  Doocine-iOS
//
//  Created by Sohn on 06/04/2017.
//  Copyright © 2017 Sohn. All rights reserved.
//

import UIKit
import SnapKit
import RealmSwift

class ProjectSceneCell: UITableViewCell {
    var rootController: ProjectDetailViewController!
    var scene: Scene!
    var cuts: [Cut] = [Cut]()
    
    var height: CGFloat = 0
    
    init(style: UITableViewCellStyle, reuseIdentifier: String?, scene: Scene, order: Int) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        self.backgroundColor = UIColor.groupTableViewBackground
        self.scene = scene
        self.fetchCuts()
        self.initCell(with: scene, order: order)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func fetchCuts() -> Void {
        let realm = try! Realm()
        let cuts = realm.objects(Cut.self).filter("sceneId == \(self.scene.id)")
        
        self.cuts.removeAll()
        
        for cut in cuts {
            self.cuts.append(cut)
        }
    }
    
    private func initCell(with scene: Scene, order: Int) -> Void {
        // MARK: - CenterLine
        let centerLine = UILabel()
        centerLine.backgroundColor = UIColor.darkGray
        
        self.addSubview(centerLine)
        centerLine.snp.makeConstraints { (make) in
            make.width.equalTo(0.5)
            make.height.equalTo(self)
            make.centerX.equalTo(self)
            make.centerY.equalTo(self)
        }
        
        // MARK: - Header
        let headerView = UIView()
        headerView.backgroundColor = UIColor.white
//        headerView.layer.cornerRadius = 10
        headerView.clipsToBounds = true
        self.addSubview(headerView)
        
        headerView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(48)
            make.right.equalTo(self).offset(-244)
            make.top.equalTo(self).offset(24)
            make.height.equalTo(100)
        }
        
        height += 24
        
        let sceneOrder = UILabel()
        sceneOrder.font = UIFont.boldSystemFont(ofSize: 48)
        sceneOrder.text = "\(order)"
        
        headerView.addSubview(sceneOrder)
        
        sceneOrder.snp.makeConstraints { (make) in
            make.centerY.equalTo(headerView)
            make.left.equalTo(headerView).offset(24)
        }
        
        let sceneHeader = UILabel()
        sceneHeader.text = "SCENE"
        
        headerView.addSubview(sceneHeader)
        
        sceneHeader.snp.makeConstraints { (make) in
            make.left.equalTo(sceneOrder.snp.right).offset(24)
            make.top.equalTo(headerView).offset(24)
        }
        
        let placeHeader = UILabel()
        placeHeader.font = UIFont.systemFont(ofSize: 12)
        placeHeader.text = "PLACE"
        placeHeader.textColor = UIColor.darkGray
        
        headerView.addSubview(placeHeader)
        
        placeHeader.snp.makeConstraints { (make) in
            make.left.equalTo(sceneOrder.snp.right).offset(24)
            make.centerY.equalTo(headerView).offset(16)
        }
        
        let placeLabel = UILabel()
        placeLabel.text = scene.place
        
        headerView.addSubview(placeLabel)
        
        placeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(placeHeader.snp.right).offset(16)
            make.centerY.equalTo(headerView).offset(16)
        }
        
        let timeHeader = UILabel()
        timeHeader.font = UIFont.systemFont(ofSize: 12)
        timeHeader.text = "TIME"
        timeHeader.textColor = UIColor.darkGray
        
        headerView.addSubview(timeHeader)
        
        timeHeader.snp.makeConstraints { (make) in
            make.left.equalTo(placeLabel.snp.right).offset(16)
            make.centerY.equalTo(headerView).offset(16)
        }
        
        let timeLabel = UILabel()
        timeLabel.text = scene.time
        
        headerView.addSubview(timeLabel)
        
        timeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(timeHeader.snp.right).offset(16)
            make.centerY.equalTo(headerView).offset(16)
        }
        
        let addButton = UIButton()
        addButton.setTitle("추가", for: .normal)
        addButton.backgroundColor = UIColor.orange
        addButton.addTarget(self, action: #selector(goToMakeCut), for: .touchUpInside)
        addButton.layer.cornerRadius = 8
        
        headerView.addSubview(addButton)
        
        addButton.snp.makeConstraints { (make) in
            make.top.equalTo(headerView).offset(24)
            make.right.equalTo(headerView).offset(-24)
            make.height.equalTo(30)
            make.width.equalTo(62)
        }
        
        // MARK: - Header View Height
        height += 100 + 32
        
        // MARK: - Body
        for i in 0 ..< cuts.count {
            let bodyView = UIView()
            bodyView.backgroundColor = .white
            bodyView.clipsToBounds = true
            bodyView.layer.cornerRadius = 16
            
            self.addSubview(bodyView)
            
            bodyView.snp.makeConstraints({ (make) in
                make.top.equalTo(self).offset(height)
                make.height.equalTo(460)
                make.left.equalTo(self).offset(124)
                make.right.equalTo(self).offset(-36)
            })
            
            // MARK: - Cut Number
            let cutNumber = UILabel()
            cutNumber.text = "CUT \(i+1)"
            cutNumber.font = UIFont.systemFont(ofSize: 12)
            cutNumber.textColor = UIColor.darkGray
            cutNumber.textAlignment = .center
            cutNumber.layer.borderWidth = 1.0
            cutNumber.layer.borderColor = UIColor.darkGray.cgColor
            cutNumber.layer.cornerRadius = 8
            
            bodyView.addSubview(cutNumber)
            
            cutNumber.snp.makeConstraints({ (make) in
                make.left.equalTo(bodyView).offset(16)
                make.top.equalTo(bodyView).offset(9)
                make.width.equalTo(60)
                make.height.equalTo(30)
            })
            
            // MARK: - Cut Image
            let imageView = UIImageView()
            
            let cutImage = PhotoManager.loadImage(imageId: cuts[i].id)
            
            if cutImage != nil {
                imageView.image = cutImage
            } else {
                imageView.image = UIImage(named: "img_banner_doocine")
            }
            
            imageView.clipsToBounds = true
            imageView.contentMode = .scaleAspectFill
            
            bodyView.addSubview(imageView)
            
            imageView.snp.makeConstraints({ (make) in
                make.top.equalTo(bodyView).offset(48)
                make.left.equalTo(bodyView)
                make.right.equalTo(bodyView)
                make.height.equalTo(300)
            })
            
            let dialogImage = UIImageView()
            dialogImage.image = UIImage(named: "icon_dialog")
            dialogImage.contentMode = .scaleAspectFit
            
            bodyView.addSubview(dialogImage)
            
            dialogImage.snp.makeConstraints({ (make) in
                make.left.equalTo(bodyView).offset(16)
                make.top.equalTo(bodyView).offset(360)
                make.width.equalTo(24)
                make.height.equalTo(24)
            })
            
            let dialogHeader = UILabel()
            dialogHeader.text = "DIALOG"
            dialogHeader.textColor = UIColor.darkGray
            dialogHeader.font = UIFont.systemFont(ofSize: 15)
            
            bodyView.addSubview(dialogHeader)
            
            dialogHeader.snp.makeConstraints({ (make) in
                make.left.equalTo(dialogImage.snp.right).offset(12)
                make.centerY.equalTo(dialogImage)
            })
            
            let dialogMessage = UILabel()
            dialogMessage.text = cuts[i].dialog
            dialogMessage.textColor = UIColor.black
            dialogMessage.font = UIFont.systemFont(ofSize: 16)
            
            bodyView.addSubview(dialogMessage)
            
            dialogMessage.snp.makeConstraints({ (make) in
                make.left.equalTo(bodyView).offset(16)
                make.top.equalTo(dialogImage.snp.bottom).offset(8)
            })
            
            let shotSizeHeader = UILabel()
            shotSizeHeader.text = "SHOT SIZE"
            shotSizeHeader.textColor = UIColor.darkGray
            shotSizeHeader.font = UIFont.systemFont(ofSize: 15)
            
            bodyView.addSubview(shotSizeHeader)
            
            shotSizeHeader.snp.makeConstraints({ (make) in
                make.left.equalTo(bodyView).offset(16)
                make.top.equalTo(dialogMessage.snp.bottom).offset(8)
            })
            
            let shotSizeValue = UILabel()
            shotSizeValue.text = cuts[i].shotSize
            
            bodyView.addSubview(shotSizeValue)
            
            shotSizeValue.snp.makeConstraints({ (make) in
                make.left.equalTo(shotSizeHeader.snp.right).offset(16)
                make.centerY.equalTo(shotSizeHeader)
            })
            
            let cameraWalkHeader = UILabel()
            cameraWalkHeader.text = "CAMERA WALK"
            cameraWalkHeader.textColor = UIColor.darkGray
            cameraWalkHeader.font = UIFont.systemFont(ofSize: 15)
            
            bodyView.addSubview(cameraWalkHeader)
            
            cameraWalkHeader.snp.makeConstraints({ (make) in
                make.left.equalTo(shotSizeValue.snp.right).offset(32)
                make.centerY.equalTo(shotSizeHeader)
            })
            
            let cameraWalkValue = UILabel()
            cameraWalkValue.text = cuts[i].cameraWalkMode
            
            bodyView.addSubview(cameraWalkValue)
            
            cameraWalkValue.snp.makeConstraints({ (make) in
                make.left.equalTo(cameraWalkHeader.snp.right).offset(16)
                make.centerY.equalTo(shotSizeHeader)
            })
            
            height += 460 + 24
        }
        
        
        // MARK: - Last Spacing
        height += 24
    }
    
    public func getHeight() -> CGFloat {
        return height
    }
    
    public func goToMakeCut() -> Void {
        let mainSB = UIStoryboard(name: "Main", bundle: nil)
        let controller = mainSB.instantiateViewController(withIdentifier: "MakeCutViewController") as! MakeCutViewController
        controller.sceneId = self.scene.id
        self.rootController.navigationController?.pushViewController(controller, animated: true)
    }
}
