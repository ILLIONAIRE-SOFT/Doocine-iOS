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
    }
}
