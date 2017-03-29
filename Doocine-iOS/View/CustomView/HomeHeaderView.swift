//
//  HomeHeaderView.swift
//  Doocine-iOS
//
//  Created by Sohn on 23/03/2017.
//  Copyright © 2017 Sohn. All rights reserved.
//

import UIKit
import SnapKit

class HomeHeaderView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        initViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initViews() -> Void {
        let titleLabel = UILabel()
        titleLabel.text = "DOOCINE"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 68)
        titleLabel.textColor = UIColor.warmGrey
        
        self.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self).offset(-24)
        }
        
        let subtitleLabel = UILabel()
        subtitleLabel.text = "STORYBOARD"
        subtitleLabel.font = UIFont.systemFont(ofSize: 48, weight: UIFontWeightThin)
        subtitleLabel.textColor = UIColor.black
        
        self.addSubview(subtitleLabel)
        
        subtitleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self).offset(40)
        }
    }
}
