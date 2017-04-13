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
    var cuts: [Cut] = [Cut]()
    
    var height: CGFloat = 0
    
    init(style: UITableViewCellStyle, reuseIdentifier: String?, scene: Scene, order: Int) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        self.backgroundColor = UIColor.groupTableViewBackground
        self.makeTestCut()
        self.initCell(with: scene, order: order)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeTestCut() -> Void {
        for _ in 0 ..< 3 {
            let cut = Cut()
            cut.dialog = "I`m tired and I have to sleep now."
            cut.shotSize = "1x"
            cut.cameraWalkMode = "Pan"
            cuts.append(cut)
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
        headerView.layer.cornerRadius = 10
        headerView.clipsToBounds = true
        self.addSubview(headerView)
        
        headerView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(96)
            make.right.equalTo(self).offset(-96)
            make.top.equalTo(self).offset(24)
            make.height.equalTo(80)
        }
        
        height += 24
        
        let sceneOrder = UILabel()
        sceneOrder.font = UIFont.boldSystemFont(ofSize: 24)
        sceneOrder.text = "SCENE \(order)"
        
        headerView.addSubview(sceneOrder)
        
        sceneOrder.snp.makeConstraints { (make) in
            make.centerY.equalTo(headerView)
            make.left.equalTo(headerView).offset(24)
        }
        
        let placeHeader = UILabel()
        placeHeader.font = UIFont.systemFont(ofSize: 12)
        placeHeader.text = "PLACE"
        placeHeader.textColor = UIColor.darkGray
        
        headerView.addSubview(placeHeader)
        
        placeHeader.snp.makeConstraints { (make) in
            make.left.equalTo(sceneOrder.snp.right).offset(60)
            make.centerY.equalTo(headerView).offset(-16)
        }
        
        let placeLabel = UILabel()
        placeLabel.text = scene.place
        
        headerView.addSubview(placeLabel)
        
        placeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(placeHeader)
            make.centerY.equalTo(headerView).offset(16)
        }
        
        let timeHeader = UILabel()
        timeHeader.font = UIFont.systemFont(ofSize: 12)
        timeHeader.text = "TIME"
        timeHeader.textColor = UIColor.darkGray
        
        headerView.addSubview(timeHeader)
        
        timeHeader.snp.makeConstraints { (make) in
            make.left.equalTo(placeHeader.snp.right).offset(160)
            make.centerY.equalTo(headerView).offset(-16)
        }
        
        let timeLabel = UILabel()
        timeLabel.text = scene.time
        
        headerView.addSubview(timeLabel)
        
        timeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(timeHeader)
            make.centerY.equalTo(headerView).offset(16)
        }
        
        // MARK: - Header View Height
        height += 80 + 32
        
        // MARK: - Body
        for i in 0 ..< cuts.count {
            let bodyView = UIView()
            bodyView.backgroundColor = .white
            bodyView.clipsToBounds = true
            bodyView.layer.cornerRadius = 16
            
            self.addSubview(bodyView)
            
            bodyView.snp.makeConstraints({ (make) in
                make.top.equalTo(self).offset(height)
                make.height.equalTo(370)
                make.left.equalTo(self).offset(72)
                make.right.equalTo(self).offset(-72)
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
            imageView.image = UIImage(named: "img_banner_doocine")
            imageView.clipsToBounds = true
            imageView.contentMode = .scaleAspectFill
            
            bodyView.addSubview(imageView)
            
            imageView.snp.makeConstraints({ (make) in
                make.top.equalTo(bodyView).offset(48)
                make.left.equalTo(bodyView)
                make.right.equalTo(bodyView)
                make.height.equalTo(240)
            })
            
            let dialogImage = UIImageView()
            dialogImage.image = UIImage(named: "icon_dialog")
            dialogImage.contentMode = .scaleAspectFit
            
            bodyView.addSubview(dialogImage)
            
            dialogImage.snp.makeConstraints({ (make) in
                make.left.equalTo(bodyView).offset(16)
                make.top.equalTo(bodyView).offset(300)
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
            
            height += 370 + 24
        }
        
        
        // MARK: - Last Spacing
        height += 24
    }
    
    public func getHeight() -> CGFloat {
        return height
    }
}