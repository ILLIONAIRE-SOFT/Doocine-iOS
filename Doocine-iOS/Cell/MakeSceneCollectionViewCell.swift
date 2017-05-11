//
//  MakeSceneCollectionViewCell.swift
//  Doocine-iOS
//
//  Created by Sohn on 13/04/2017.
//  Copyright © 2017 Sohn. All rights reserved.
//

import UIKit
import SnapKit

class MakeSceneCollectionViewCell: UICollectionViewCell {
    var makeSceneLabel: UILabel = UILabel()
    
    var makeProjectCircle: UIView = UIView()
    var makeProjectAddViewContainer: UIView = UIView()
    
    var leftTopGrayView: UIView = UIView()
    var rightTopGrayView: UIView = UIView()
    var rightBottomGrayView: UIView = UIView()
    var leftBottomGrayView: UIView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: CGRect())
        
        self.backgroundColor = UIColor.white
        self.layer.borderWidth = 0.5
        self.layer.cornerRadius = 8
        self.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.7).cgColor
        self.clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func initCell() -> Void {
        makeSceneLabel.text = "New Scene"
        makeSceneLabel.textColor = UIColor.orange
        makeSceneLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
        self.addSubview(makeSceneLabel)
        
        makeSceneLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(12)
            make.top.equalTo(self).offset(12)
        }
        
        self.addSubview(makeProjectCircle)
        
        makeProjectCircle.backgroundColor = UIColor.lightGray.withAlphaComponent(0.7)
        makeProjectCircle.layer.cornerRadius = 50
        makeProjectCircle.clipsToBounds = true
        
        makeProjectCircle.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(16)
            make.bottom.equalTo(self).offset(16)
            make.width.equalTo(100)
            make.height.equalTo(100)
            
        }
        
        makeProjectCircle.addSubview(makeProjectAddViewContainer)
        makeProjectAddViewContainer.backgroundColor = UIColor.white
        
        makeProjectAddViewContainer.snp.makeConstraints { (make) in
            make.center.equalTo(makeProjectCircle)
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
        
        leftTopGrayView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.7)
        
        makeProjectAddViewContainer.addSubview(leftTopGrayView)
        
        leftTopGrayView.snp.makeConstraints { (make) in
            make.left.equalTo(makeProjectAddViewContainer)
            make.top.equalTo(makeProjectAddViewContainer)
            make.width.equalTo(25)
            make.height.equalTo(25)
        }
        
        rightTopGrayView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.7)
        
        makeProjectAddViewContainer.addSubview(rightTopGrayView)
        
        rightTopGrayView.snp.makeConstraints { (make) in
            make.right.equalTo(makeProjectAddViewContainer)
            make.top.equalTo(makeProjectAddViewContainer)
            make.width.equalTo(25)
            make.height.equalTo(25)
        }
        
        leftBottomGrayView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.7)
        
        makeProjectAddViewContainer.addSubview(leftBottomGrayView)
        
        leftBottomGrayView.snp.makeConstraints { (make) in
            make.left.equalTo(makeProjectAddViewContainer)
            make.bottom.equalTo(makeProjectAddViewContainer)
            make.width.equalTo(25)
            make.height.equalTo(25)
        }
        
        rightBottomGrayView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.7)
        
        makeProjectAddViewContainer.addSubview(rightBottomGrayView)
        
        rightBottomGrayView.snp.makeConstraints { (make) in
            make.right.equalTo(makeProjectAddViewContainer)
            make.bottom.equalTo(makeProjectAddViewContainer)
            make.width.equalTo(25)
            make.height.equalTo(25)
        }
    }
}
