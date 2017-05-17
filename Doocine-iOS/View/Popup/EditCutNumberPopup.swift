//
//  EditCutNumberPopup.swift
//  Doocine-iOS
//
//  Created by Sohn on 17/05/2017.
//  Copyright © 2017 Sohn. All rights reserved.
//

import UIKit
import PopupController
import SnapKit

class EditCutNumberPopup: BaseViewController, PopupContentViewController {
    
    var delegateSelect: ((_ number: Int) -> ())!
    var originCutNumber: Int = 0
    
    let roundedView = UIView()
    let cutNumberLabel = UILabel()
    let upImageView = UIImageView()
    let downImageView = UIImageView()
    var selectLabel = UILabel()
    
    let arrowWidth: CGFloat = 40
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initViews()
    }
    
    private func initViews() -> Void {
        self.view.backgroundColor = UIColor.clear
        self.view.clipsToBounds = true
        self.view.isOpaque = false
        
        self.view.addSubview(roundedView)
        
        self.roundedView.layer.cornerRadius = 12
        self.roundedView.clipsToBounds = true
        self.roundedView.backgroundColor = UIColor.white
        
        roundedView.snp.makeConstraints { (make) in
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
            make.top.equalTo(self.view)
            make.bottom.equalTo(self.view)
        }
        
        cutNumberLabel.text = "\(originCutNumber)"
        cutNumberLabel.font = UIFont.boldSystemFont(ofSize: 36)
        
        self.roundedView.addSubview(cutNumberLabel)
        
        cutNumberLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.centerY.equalTo(self.view).offset(-40)
        }
        
        self.upImageView.image = UIImage(named: "icon_arrow_up")
        self.upImageView.contentMode = .scaleAspectFit
        self.upImageView.isUserInteractionEnabled = true
        
        let tappedUp = UITapGestureRecognizer(target: self, action: #selector(self.tappedUp))
        self.upImageView.addGestureRecognizer(tappedUp)
        
        self.downImageView.image = UIImage(named: "icon_arrow_down")
        self.downImageView.contentMode = .scaleAspectFit
        self.downImageView.isUserInteractionEnabled = true
        
        let tappedDown = UITapGestureRecognizer(target: self, action: #selector(self.tappedDown))
        self.downImageView.addGestureRecognizer(tappedDown)
        
        self.roundedView.addSubview(upImageView)
        self.roundedView.addSubview(downImageView)
        
        upImageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(self.cutNumberLabel.snp.top).offset(-14)
            make.width.equalTo(arrowWidth)
            make.height.equalTo(arrowWidth)
        }
        
        downImageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.cutNumberLabel.snp.bottom).offset(14)
            make.width.equalTo(arrowWidth)
            make.height.equalTo(arrowWidth)
        }
        
        selectLabel.text = "선택"
        selectLabel.backgroundColor = UIColor.orange
        selectLabel.textColor = .white
        selectLabel.textAlignment = .center
        selectLabel.font = UIFont.systemFont(ofSize: 20)
        selectLabel.isUserInteractionEnabled = true
        
        let tappedSelect = UITapGestureRecognizer(target: self, action: #selector(self.tappedSelect))
        
        selectLabel.addGestureRecognizer(tappedSelect)
        
        self.roundedView.addSubview(selectLabel)
        
        selectLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.roundedView)
            make.right.equalTo(self.roundedView)
            make.bottom.equalTo(self.roundedView)
            make.height.equalTo(80)
        }
    }
    
    func sizeForPopup(_ popupController: PopupController, size: CGSize, showingKeyboard: Bool) -> CGSize {
        let width:CGFloat = 80
        let height: CGFloat = 240
        return CGSize(width: width, height: height)
    }
    
    public func tappedSelect() -> Void {
        self.delegateSelect(self.originCutNumber)
    }
    
    public func tappedUp() -> Void {
        originCutNumber += 1
        self.updateCutNumberLabel()
    }
    
    public func tappedDown() -> Void {
        if originCutNumber == 1 {
            return
        }
        
        originCutNumber -= 1
        self.updateCutNumberLabel()
    }
    
    private func updateCutNumberLabel() -> Void {
        self.cutNumberLabel.text = "\(self.originCutNumber)"
    }
}
