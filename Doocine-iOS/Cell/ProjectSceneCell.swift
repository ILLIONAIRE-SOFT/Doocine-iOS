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
    var handleTapCut: ((_ cut: Cut) -> ())!
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
        let cuts = realm.objects(Cut.self).filter("sceneId == \(self.scene.id)").sorted(byKeyPath: "cutNumber")
        
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
            make.width.equalTo(1)
            if cuts.count != 0 {
                make.height.equalTo(self)
            } else {
                make.height.equalTo(54)
            }
            
            make.top.equalTo(self)
            make.left.equalTo(self).offset(88)
//            make.centerY.equalTo(self)
        }
        
        // MARK: - Header
        let headerView = UIView()
        headerView.backgroundColor = UIColor.white
        headerView.layer.cornerRadius = 4
        headerView.clipsToBounds = true
        headerView.isUserInteractionEnabled = true
        
        self.addSubview(headerView)
        
        headerView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(48)
            make.right.equalTo(self).offset(-160)
            make.top.equalTo(self).offset(24)
            make.height.equalTo(84)
        }
        
        height += 24
        
        let sceneOrder = UILabel()
        sceneOrder.font = UIFont.boldSystemFont(ofSize: 16)
        sceneOrder.text = "SCENE #\(order)"
        
        headerView.addSubview(sceneOrder)
        
        sceneOrder.snp.makeConstraints { (make) in
            make.centerY.equalTo(headerView)
            make.left.equalTo(headerView).offset(16)
        }
        
        let sceneSeparator = UILabel()
        sceneSeparator.backgroundColor = UIColor.darkGray
        
        self.addSubview(sceneSeparator)
        
        sceneSeparator.snp.makeConstraints { (make) in
            make.width.equalTo(0.5)
            make.left.equalTo(sceneOrder.snp.right).offset(16)
            make.top.equalTo(headerView)
            make.bottom.equalTo(headerView)
        }
        //        let sceneHeader = UILabel()
        //        sceneHeader.text = "SCENE"
        //
        //        headerView.addSubview(sceneHeader)
        //
        //        sceneHeader.snp.makeConstraints { (make) in
        //            make.left.equalTo(sceneOrder.snp.right).offset(24)
        //            make.top.equalTo(headerView).offset(24)
        //        }
        
        let placeHeader = UILabel()
        placeHeader.font = UIFont.systemFont(ofSize: 12)
        placeHeader.text = "PLACE"
        placeHeader.textColor = UIColor.darkGray
        
        headerView.addSubview(placeHeader)
        
        placeHeader.snp.makeConstraints { (make) in
            make.left.equalTo(sceneSeparator.snp.right).offset(16)
            make.top.equalTo(headerView).offset(24)
        }
        
        let placeLabel = UILabel()
        placeLabel.text = scene.place
        
        headerView.addSubview(placeLabel)
        
        placeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(placeHeader.snp.right).offset(16)
            make.centerY.equalTo(placeHeader)
        }
        
        let timeHeader = UILabel()
        timeHeader.font = UIFont.systemFont(ofSize: 12)
        timeHeader.text = "TIME"
        timeHeader.textColor = UIColor.darkGray
        
        headerView.addSubview(timeHeader)
        
        timeHeader.snp.makeConstraints { (make) in
            make.left.equalTo(sceneSeparator.snp.right).offset(16)
            make.centerY.equalTo(headerView).offset(16)
        }
        
        let timeLabel = UILabel()
        timeLabel.text = scene.time
        
        headerView.addSubview(timeLabel)
        
        timeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(placeLabel.snp.left)
            make.centerY.equalTo(timeHeader)
        }
        
        let editSceneButton = UIButton()
        
        editSceneButton.tintColor = .orange
        editSceneButton.setImage(UIImage(named: "icon_edit")?.withRenderingMode(.alwaysTemplate), for: .normal)
        editSceneButton.addTarget(self, action: #selector(tappedScene), for: .touchUpInside)
        
        headerView.addSubview(editSceneButton)
        
        editSceneButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(headerView)
            make.right.equalTo(headerView).offset(-16)
            make.height.equalTo(24)
            make.width.equalTo(24)
        }
        
        let addButton = UIButton()
        addButton.tintColor = UIColor.orange
        addButton.setImage(UIImage(named: "icon_add_box")?.withRenderingMode(.alwaysTemplate), for: .normal)
        addButton.addTarget(self, action: #selector(goToMakeCut), for: .touchUpInside)
        addButton.layer.cornerRadius = 8
        
        headerView.addSubview(addButton)
        
        addButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(headerView)
            make.right.equalTo(editSceneButton.snp.left).offset(-24)
            make.height.equalTo(24)
            make.width.equalTo(24)
        }
        
        // MARK: - Header View Height
        height += 84 + 32
        
        // MARK: - Body
        for i in 0 ..< cuts.count {
            let cutPoint = UIView()
            cutPoint.backgroundColor = .white
            cutPoint.layer.borderWidth = 2
            cutPoint.layer.cornerRadius = 8
            cutPoint.clipsToBounds = true
            cutPoint.layer.borderColor = UIColor.darkGray.cgColor
            
            self.addSubview(cutPoint)
            
            cutPoint.snp.makeConstraints({ (make) in
                make.left.equalTo(80)
                make.top.equalTo(self).offset(height + 16)
                make.width.equalTo(16)
                make.height.equalTo(16)
            })
            
            let bodyView = UIView()
            
            bodyView.backgroundColor = .white
            bodyView.clipsToBounds = true
            bodyView.layer.cornerRadius = 16
            bodyView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.7).cgColor
            bodyView.layer.borderWidth = 0.5
            
            self.addSubview(bodyView)
            
            bodyView.snp.makeConstraints({ (make) in
                make.top.equalTo(self).offset(height)
                make.height.equalTo(460)
                make.left.equalTo(self).offset(124)
                make.right.equalTo(self).offset(-36)
            })
            
            // MARK: - Cut Number
            let cutNumber = UILabel()
            cutNumber.text = "CUT \(cuts[i].cutNumber)"
            cutNumber.font = UIFont.boldSystemFont(ofSize: 12)
            cutNumber.textColor = UIColor.white
            cutNumber.backgroundColor = UIColor.red
            cutNumber.textAlignment = .center
            cutNumber.clipsToBounds = true
            cutNumber.layer.cornerRadius = 8
            
            bodyView.addSubview(cutNumber)
            
            cutNumber.snp.makeConstraints({ (make) in
                make.left.equalTo(bodyView).offset(16)
                make.top.equalTo(bodyView).offset(9)
                make.width.equalTo(60)
                make.height.equalTo(30)
            })
            
            // MARK: - Cut Edit Button
            let cutEditButton = UIButton()
            cutEditButton.tintColor = UIColor.orange
            cutEditButton.setImage(UIImage(named: "icon_edit")?.withRenderingMode(.alwaysTemplate), for: .normal)
            
            let tapCut = MyTapGestureRecognizer(target: self, action: #selector(tappedCut))
            tapCut.cutId = i
            cutEditButton.addGestureRecognizer(tapCut)
            
            bodyView.addSubview(cutEditButton)
            
            cutEditButton.snp.makeConstraints({ (make) in
                make.right.equalTo(bodyView).offset(-16)
                make.centerY.equalTo(cutNumber)
                make.width.equalTo(36)
                make.height.equalTo(36)
            })
            
            // MARK: - Cut Image
            let imageView = UIImageView()
            
            let cutImage = PhotoManager.loadImage(imageId: cuts[i].id)
            
            if cutImage != nil {
                imageView.image = cutImage
            } else {
                imageView.image = UIImage(named: "img_empty")
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
            
            /*
             Shot size
             */
            
            let shotSizeHeader = UILabel()
            shotSizeHeader.text = "SHOT SIZE"
            shotSizeHeader.textColor = UIColor.darkGray
            shotSizeHeader.font = UIFont.systemFont(ofSize: 15)
            
            bodyView.addSubview(shotSizeHeader)
            
            shotSizeHeader.snp.makeConstraints({ (make) in
                make.left.equalTo(bodyView).offset(16)
                make.top.equalTo(bodyView).offset(360)
//                make.top.equalTo(dialogMessage.snp.bottom).offset(8)
            })
            
            let shotSizeValue = UILabel()
            shotSizeValue.text = cuts[i].shotSize
            
            bodyView.addSubview(shotSizeValue)
            
            shotSizeValue.snp.makeConstraints({ (make) in
                make.left.equalTo(shotSizeHeader.snp.right).offset(16)
                make.centerY.equalTo(shotSizeHeader)
            })
            
            /*
             Camera Walk
             */
            
            let cameraWalkHeader = UILabel()
            cameraWalkHeader.text = "CAMERA WALK"
            cameraWalkHeader.textColor = UIColor.darkGray
            cameraWalkHeader.font = UIFont.systemFont(ofSize: 15)
            
            bodyView.addSubview(cameraWalkHeader)
            
            cameraWalkHeader.snp.makeConstraints({ (make) in
                make.left.equalTo(bodyView.snp.centerX).offset(32)
                make.centerY.equalTo(shotSizeHeader)
            })
            
            let cameraWalkValue = UILabel()
            cameraWalkValue.text = cuts[i].cameraWalkMode
            
            bodyView.addSubview(cameraWalkValue)
            
            cameraWalkValue.snp.makeConstraints({ (make) in
                make.left.equalTo(cameraWalkHeader.snp.right).offset(16)
                make.centerY.equalTo(shotSizeHeader)
            })
            
            /*
             Dialog
             */
            let dialogImage = UIImageView()
            dialogImage.image = UIImage(named: "icon_dialog")
            dialogImage.contentMode = .scaleAspectFit
            
            bodyView.addSubview(dialogImage)
            
            dialogImage.snp.makeConstraints({ (make) in
                make.left.equalTo(bodyView).offset(16)
                make.top.equalTo(shotSizeHeader.snp.bottom).offset(12)
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
            
            height += 460 + 24
            
            // MARK: - SubCut
            if cuts[i].needSecondSubCut() {
                let subCut = UIView()
                subCut.backgroundColor = UIColor.black
                subCut.clipsToBounds = true
                subCut.layer.cornerRadius = 16
                subCut.layer.borderWidth = 0.5
                subCut.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.7).cgColor
                subCut.isUserInteractionEnabled = true
                
                //                let tapSubCut = MyTapGestureRecognizer(target: self, action: #selector(tappedCut))
                //                tapSubCut.cutId = i
                //
                //                subCut.addGestureRecognizer(tapSubCut)
                
                self.addSubview(subCut)
                
                subCut.snp.makeConstraints({ (make) in
                    make.top.equalTo(self).offset(height)
                    make.height.equalTo(360)
                    make.left.equalTo(self).offset(124)
                    make.right.equalTo(self).offset(-26)
                })
                
                // MARK: - Image View
                //                let imageView = UIImageView()
                //
                //                let cutImage = PhotoManager.loadImage(imageId: cuts[i].id)
                //
                //                if cutImage != nil {
                //                    imageView.image = cutImage
                //                } else {
                //                    imageView.image = UIImage(named: "img_banner_doocine")
                //                }
                //
                //                imageView.clipsToBounds = true
                //                imageView.contentMode = .scaleAspectFill
                //
                //                bodyView.addSubview(imageView)
                //
                //                imageView.snp.makeConstraints({ (make) in
                //                    make.top.equalTo(bodyView).offset(48)
                //                    make.left.equalTo(bodyView)
                //                    make.right.equalTo(bodyView)
                //                    make.height.equalTo(300)
                //                })
                let subCutImageView = UIImageView()
                
                let subCutImage = PhotoManager.loadImage(imageId: cuts[i].id, isSecondImage: true)
                
                if subCutImage != nil {
                    subCutImageView.image = subCutImage
                } else {
                    subCutImageView.image = UIImage(named: "img_banner_doocine")
                }
                
                subCutImageView.clipsToBounds = true
                subCutImageView.contentMode = .scaleAspectFill
                
                subCut.addSubview(subCutImageView)
                
                subCutImageView.snp.makeConstraints({ (make) in
                    make.top.equalTo(subCut).offset(24)
                    make.left.equalTo(subCut)
                    make.right.equalTo(subCut)
                    make.bottom.equalTo(subCut).offset(-24)
                })
                
                height += 360 + 24
            }
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
    
    public func tappedCut(sender: MyTapGestureRecognizer) -> Void {
        let mainSB = UIStoryboard(name: "Main", bundle: nil)
        let controller = mainSB.instantiateViewController(withIdentifier: "MakeCutViewController") as! MakeCutViewController
        let targetCut = self.cuts[sender.cutId]
        
        controller.sceneId = self.scene.id
        controller.originCut = targetCut
        controller.isUpdate = true
        self.rootController.navigationController?.pushViewController(controller, animated: true)
    }
    
    public func tappedScene(sender: UITapGestureRecognizer) -> Void {
        let mainSB = UIStoryboard(name: "Main", bundle: nil)
        let controller = mainSB.instantiateViewController(withIdentifier: "MakeSceneViewController") as! MakeSceneViewController
        
        controller.originalScene = self.scene
        controller.isUpdate = true
        controller.storyboardId = self.scene.storyboardId
        self.rootController.navigationController?.pushViewController(controller, animated: true)
    }
}

class MyTapGestureRecognizer: UITapGestureRecognizer {
    var cutId: Int = 0
}
