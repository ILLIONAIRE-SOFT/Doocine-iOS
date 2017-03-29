//
//  MakeNewProjectView.swift
//  Doocine-iOS
//
//  Created by Sohn on 23/03/2017.
//  Copyright © 2017 Sohn. All rights reserved.
//

import UIKit
import SnapKit
import PopupController

class MakeNewProjectView: UIView {
    let spacing: CGFloat = 16
    let leftRightSpacing: CGFloat = 32
    let viewWidth = (UIScreen.main.bounds.width - 2*16 - 2*32) / 3
    var handleTapMakeNewProject: (() -> ())!
    
    init(frame: CGRect, order: Int) {
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
        
        self.clipsToBounds = true
        
        addGestureSelf()
        
        self.initViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initViews() -> Void {
        let makeProjectLabel = UILabel()
        makeProjectLabel.text = "Create a new project"
        makeProjectLabel.textColor = UIColor.tangerine
        makeProjectLabel.font = UIFont.boldSystemFont(ofSize: 15)
        
        self.addSubview(makeProjectLabel)
        
        makeProjectLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(16)
            make.top.equalTo(self).offset(16)
        }
        
        let description = UILabel()
        description.text = "You can do great projects."
        description.textColor = UIColor.gray
        description.font = UIFont.systemFont(ofSize: 12)
        
        self.addSubview(description)
        
        description.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(16)
            make.top.equalTo(makeProjectLabel.snp.bottom).offset(8)
        }
        
    }
    
    private func addGestureSelf() -> Void {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedMakeNewProject))
        self.addGestureRecognizer(tapGesture)
    }
    
}


extension MakeNewProjectView {
    public func tappedMakeNewProject() -> Void {
        if handleTapMakeNewProject != nil {
            self.handleTapMakeNewProject!()
        }
    }
}
