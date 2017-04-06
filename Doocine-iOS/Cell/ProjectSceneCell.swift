//
//  ProjectSceneCell.swift
//  Doocine-iOS
//
//  Created by Sohn on 06/04/2017.
//  Copyright © 2017 Sohn. All rights reserved.
//

import UIKit
import SnapKit

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
        for _ in 0 ..< 6 {
            let cut = Cut()
            cut.dialog = "2시간안에 다 찍어야해요."
            cut.shotSize = 0
            cut.cameraWalkMode = 0
            cuts.append(cut)
        }
    }
    
    private func initCell(with scene: Scene, order: Int) -> Void {
        // MARK: - Header
        let headerView = UIView()
        headerView.backgroundColor = UIColor.white
        self.addSubview(headerView)
        
        headerView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(36)
            make.right.equalTo(self).offset(-36)
            make.top.equalTo(self).offset(24)
            make.height.equalTo(80)
        }
        
        let sceneOrder = UILabel()
        sceneOrder.font = UIFont.systemFont(ofSize: 16)
        sceneOrder.text = "SCENE \(order)"
        
        headerView.addSubview(sceneOrder)
        
        sceneOrder.snp.makeConstraints { (make) in
            make.centerY.equalTo(headerView)
            make.left.equalTo(headerView).offset(16)
        }
        
        let placeHeader = UILabel()
        placeHeader.text = "PLACE"
        
        headerView.addSubview(placeHeader)
        
        placeHeader.snp.makeConstraints { (make) in
            make.left.equalTo(sceneOrder.snp.right).offset(48)
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
        timeHeader.text = "TIME"
        
        headerView.addSubview(timeHeader)
        
        timeHeader.snp.makeConstraints { (make) in
            make.left.equalTo(placeHeader.snp.right).offset(80)
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
        height += 80 + 16
        
        
        // MARK: - Body
        
        // MARK: - Last Spacing
        height += 24
    }
    
    public func getHeight() -> CGFloat {
        return height
    }
}
