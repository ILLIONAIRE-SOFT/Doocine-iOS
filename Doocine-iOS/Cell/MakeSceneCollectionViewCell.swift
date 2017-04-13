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
        
        self.backgroundColor = UIColor.lightGray
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func initCell() -> Void {
        makeSceneLabel.text = "New Scene"
        makeSceneLabel.textColor = UIColor.white
        makeSceneLabel.font = UIFont.boldSystemFont(ofSize: 18)
        
        self.addSubview(makeSceneLabel)
        
        makeSceneLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(12)
            make.top.equalTo(self).offset(12)
        }
    }
}
