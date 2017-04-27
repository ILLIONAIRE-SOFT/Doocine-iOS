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
    }
}
