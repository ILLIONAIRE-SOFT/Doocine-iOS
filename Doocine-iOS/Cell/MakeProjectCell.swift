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
    
    override init(frame: CGRect) {
        super.init(frame: CGRect())
        
        self.backgroundColor = UIColor.lightGray
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func initCell() -> Void {
        makeProjectLabel.text = "New Project"
        makeProjectLabel.textColor = UIColor.white
        makeProjectLabel.font = UIFont.boldSystemFont(ofSize: 18)
        
        self.addSubview(makeProjectLabel)
        
        makeProjectLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(12)
            make.top.equalTo(self).offset(12)
        }
    }
}
