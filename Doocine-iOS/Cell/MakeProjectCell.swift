//
//  MakeProjectCell.swift
//  Doocine-iOS
//
//  Created by Sohn on 17/04/2017.
//  Copyright © 2017 Sohn. All rights reserved.
//

import UIKit
import SnapKit

class MakeProjectCell: UICollectionViewCell {
    var makeProjectLabel: UILabel = UILabel()
    var makeProjectSubLabel: UILabel = UILabel()
    
    var makeProjectCircle: UIView = UIView()
    var makeProjectAddViewContainer: UIView = UIView()
    
    var leftTopGrayView: UIView = UIView()
    var rightTopGrayView: UIView = UIView()
    var rightBottomGrayView: UIView = UIView()
    var leftBottomGrayView: UIView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: CGRect())
        
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.7).cgColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func initCell() -> Void {
        makeProjectLabel.text = "Create a new project"
        makeProjectLabel.textColor = UIColor.orange
        makeProjectLabel.font = UIFont.boldSystemFont(ofSize: 17)
        
        self.addSubview(makeProjectLabel)
        
        makeProjectLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(12)
            make.top.equalTo(self).offset(12)
        }
        
        makeProjectSubLabel.text = "You can do greate projects."
        makeProjectSubLabel.textColor = UIColor.gray
        makeProjectSubLabel.font = UIFont.systemFont(ofSize: 12)
        
        self.addSubview(makeProjectSubLabel)
        
        makeProjectSubLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(12)
            make.top.equalTo(makeProjectLabel.snp.bottom).offset(8)
        }
        
        self.addSubview(makeProjectCircle)
        
        makeProjectCircle.backgroundColor = UIColor.lightGray.withAlphaComponent(0.7)
        makeProjectCircle.layer.cornerRadius = 75
        makeProjectCircle.clipsToBounds = true
        
        makeProjectCircle.snp.makeConstraints { (make) in
            make.right.equalTo(self).offset(24)
            make.bottom.equalTo(self).offset(24)
            make.width.equalTo(150)
            make.height.equalTo(150)
            
        }
        
        makeProjectCircle.addSubview(makeProjectAddViewContainer)
        
        makeProjectAddViewContainer.backgroundColor = UIColor.white
        
        makeProjectAddViewContainer.snp.makeConstraints { (make) in
            make.center.equalTo(makeProjectCircle)
            make.width.equalTo(80)
            make.height.equalTo(80)
        }
        
        leftTopGrayView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.7)
        
        makeProjectAddViewContainer.addSubview(leftTopGrayView)
        
        leftTopGrayView.snp.makeConstraints { (make) in
            make.left.equalTo(makeProjectAddViewContainer)
            make.top.equalTo(makeProjectAddViewContainer)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        
        rightTopGrayView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.7)
        
        makeProjectAddViewContainer.addSubview(rightTopGrayView)
        
        rightTopGrayView.snp.makeConstraints { (make) in
            make.right.equalTo(makeProjectAddViewContainer)
            make.top.equalTo(makeProjectAddViewContainer)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        
        leftBottomGrayView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.7)
        
        makeProjectAddViewContainer.addSubview(leftBottomGrayView)
        
        leftBottomGrayView.snp.makeConstraints { (make) in
            make.left.equalTo(makeProjectAddViewContainer)
            make.bottom.equalTo(makeProjectAddViewContainer)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        
        rightBottomGrayView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.7)
        
        makeProjectAddViewContainer.addSubview(rightBottomGrayView)
        
        rightBottomGrayView.snp.makeConstraints { (make) in
            make.right.equalTo(makeProjectAddViewContainer)
            make.bottom.equalTo(makeProjectAddViewContainer)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
    }
}
