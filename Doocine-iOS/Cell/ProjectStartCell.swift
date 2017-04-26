//
//  ProjectStartCell.swift
//  Doocine-iOS
//
//  Created by Sohn on 09/04/2017.
//  Copyright © 2017 Sohn. All rights reserved.
//

import UIKit
import SnapKit

class ProjectStartCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        self.backgroundColor = UIColor.groupTableViewBackground
        self.initCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initCell() -> Void {
        let centerLine = UILabel()
        centerLine.backgroundColor = UIColor.darkGray
        
        self.addSubview(centerLine)
        
        let startLabel = UILabel()
        startLabel.text = "START"
        startLabel.font = UIFont.boldSystemFont(ofSize: 13)
        startLabel.clipsToBounds = true
        startLabel.textAlignment = .center
        startLabel.backgroundColor = UIColor.red
        startLabel.textColor = .white
        startLabel.layer.cornerRadius = 20
        
        self.addSubview(startLabel)
        
        startLabel.snp.makeConstraints { (make) in
            make.width.equalTo(80)
            make.height.equalTo(40)
            make.left.equalTo(self).offset(48)
            make.centerY.equalTo(self)
        }
        
        centerLine.snp.makeConstraints { (make) in
            make.width.equalTo(1)
            make.height.equalTo(self)
            make.left.equalTo(self).offset(88)
            make.centerY.equalTo(self)
        }
    }
    
    public static func getHeight() -> CGFloat {
        return 100
    }
}
