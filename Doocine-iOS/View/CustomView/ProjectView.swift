//
//  ProjectView.swift
//  Doocine-iOS
//
//  Created by Sohn on 23/03/2017.
//  Copyright © 2017 Sohn. All rights reserved.
//

import UIKit
import SnapKit

class ProjectView: UIView {

    var storyboard: MovieStoryboard!
    
    let spacing: CGFloat = 16
    let leftRightSpacing: CGFloat = 32
    let viewWidth = (UIScreen.main.bounds.width - 2*16 - 2*32) / 3

    init(frame: CGRect, order: Int, storyboard: MovieStoryboard) {
        super.init(frame: frame)
        
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.warmGrey.cgColor
        self.layer.cornerRadius = 8
        
        let xHelper = order/3
        var x = CGFloat(xHelper) * UIScreen.main.bounds.width
        x += leftRightSpacing
        x += (CGFloat(order%3) * spacing)
        x += (CGFloat(order%3) * viewWidth)
        
        self.frame = CGRect(x: x, y: 0, width: viewWidth, height: 180)
        self.backgroundColor = UIColor.white
        
        initViews(with: storyboard)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initViews(with storyboard: MovieStoryboard) -> Void {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "img_test_project")
        self.addSubview(imageView)
        
        imageView.contentMode = .scaleAspectFill
        imageView.snp.makeConstraints { (make) in
            make.left.equalTo(self)
            make.top.equalTo(self)
            make.right.equalTo(self)
            make.height.equalTo(110)
        }
        
        let groupLabel = UILabel()
        groupLabel.text = storyboard.group!
        groupLabel.font = UIFont.systemFont(ofSize: 12)
        
        self.addSubview(groupLabel)
        
        groupLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(6)
            make.top.equalTo(imageView.snp.bottom).offset(6)
        }
        
        let titleLabel = UILabel()
        titleLabel.text = storyboard.title!
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        
        self.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(6)
            make.top.equalTo(groupLabel.snp.bottom).offset(6)
        }
    }
}
