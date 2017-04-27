//
//  ShotSizeViewController.swift
//  Doocine-iOS
//
//  Created by Sohn on 13/04/2017.
//  Copyright © 2017 Sohn. All rights reserved.
//

import UIKit
import PopupController
import SnapKit

class ShotSizeViewController: UIViewController, PopupContentViewController {
    
    var delegateSelect: ((_ selectedSize: String) -> ())!
    var itemWidth: CGFloat = 150
    var leftRightMargin: CGFloat = 16
    var itemSpacing: CGFloat = 8
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViews()
    }
    
    private func initViews() -> Void {
        let titleLabel = UILabel()
        titleLabel.text = "SHOT SIZE"
        
        self.view.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(leftRightMargin)
            make.top.equalTo(self.view).offset(24)
        }
        
        let firstView = UIView()
        firstView.isUserInteractionEnabled = true
        
        let tapFirst = UITapGestureRecognizer(target: self, action: #selector(tappedFirstSize))
        firstView.addGestureRecognizer(tapFirst)
        
        self.view.addSubview(firstView)
        
        firstView.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(leftRightMargin)
            make.top.equalTo(titleLabel.snp.bottom).offset(leftRightMargin)
            make.width.equalTo(itemWidth)
            make.height.equalTo(itemWidth + 20)
        }
        
        let firstImage = UIImageView()
        firstImage.image = UIImage(named: "icon_shotsize_fs")
        firstImage.contentMode = .scaleAspectFill
        firstImage.clipsToBounds = true
        firstImage.layer.borderWidth = 0.5
        firstImage.layer.cornerRadius = 8
        firstView.addSubview(firstImage)
        
        firstImage.snp.makeConstraints { (make) in
            make.left.equalTo(firstView)
            make.top.equalTo(firstView)
            make.right.equalTo(firstView)
            make.height.equalTo(120)
        }
        
        let firstText = UILabel()
        firstText.text = "Full Shot"
        firstText.textColor = UIColor.darkGray
        
        firstView.addSubview(firstText)
        firstText.snp.makeConstraints { (make) in
            make.centerX.equalTo(firstView)
            make.bottom.equalTo(firstView).offset(-8)
        }
        
        let secondView = UIView()
        secondView.isUserInteractionEnabled = true
        
        let tapSecond = UITapGestureRecognizer(target: self, action: #selector(tappedSecondSize))
        secondView.addGestureRecognizer(tapSecond)
        
        self.view.addSubview(secondView)
        
        let secondImage = UIImageView()
        secondImage.image = UIImage(named: "icon_shotsize_ks")
        secondImage.contentMode = .scaleAspectFill
        secondImage.clipsToBounds = true
        secondImage.layer.cornerRadius = 8
        secondImage.layer.borderWidth = 0.5
        
        secondView.addSubview(secondImage)
        
        secondImage.snp.makeConstraints { (make) in
            make.left.equalTo(secondView)
            make.top.equalTo(secondView)
            make.right.equalTo(secondView)
            make.height.equalTo(120)
        }
        
        let secondText = UILabel()
        secondText.text = "Knee Shot"
        secondText.textColor = UIColor.darkGray
        
        secondView.addSubview(secondText)
        secondText.snp.makeConstraints { (make) in
            make.centerX.equalTo(secondView)
            make.bottom.equalTo(secondView).offset(-8)
        }
        
        secondView.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(leftRightMargin + itemWidth + itemSpacing)
            make.top.equalTo(firstView)
            make.width.equalTo(itemWidth)
            make.height.equalTo(itemWidth + 20)
        }
        
        let thirdView = UIView()
        thirdView.isUserInteractionEnabled = true
        
        let tapThird = UITapGestureRecognizer(target: self, action: #selector(tappedThirdSize))
        thirdView.addGestureRecognizer(tapThird)
        
        self.view.addSubview(thirdView)
        
        let thirdImage = UIImageView()
        thirdImage.image = UIImage(named: "icon_shotsize_ws")
        thirdImage.contentMode = .scaleAspectFill
        thirdImage.clipsToBounds = true
        thirdImage.layer.cornerRadius = 8
        thirdImage.layer.borderWidth = 0.5
        
        thirdView.addSubview(thirdImage)
        
        thirdImage.snp.makeConstraints { (make) in
            make.left.equalTo(thirdView)
            make.top.equalTo(thirdView)
            make.right.equalTo(thirdView)
            make.height.equalTo(120)
        }
        
        let thirdText = UILabel()
        thirdText.text = "Waist Shot"
        thirdText.textColor = UIColor.darkGray
        
        thirdView.addSubview(thirdText)
        thirdText.snp.makeConstraints { (make) in
            make.centerX.equalTo(thirdView)
            make.bottom.equalTo(thirdView).offset(-8)
        }
        
        thirdView.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(leftRightMargin + (itemWidth * 2) + (itemSpacing * 2))
            make.top.equalTo(firstView)
            make.width.equalTo(itemWidth)
            make.height.equalTo(itemWidth + 20)
        }
        
        let fourthView = UIView()
        fourthView.isUserInteractionEnabled = true
        let tapFourth = UITapGestureRecognizer(target: self, action: #selector(tappedFourthSize))
        fourthView.addGestureRecognizer(tapFourth)
        
        self.view.addSubview(fourthView)
        
        let fourthImage = UIImageView()
        fourthImage.image = UIImage(named: "icon_shotsize_bs")
        fourthImage.contentMode = .scaleAspectFill
        fourthImage.clipsToBounds = true
        fourthImage.layer.cornerRadius = 8
        fourthImage.layer.borderWidth = 0.5
        
        fourthView.addSubview(fourthImage)
        
        fourthImage.snp.makeConstraints { (make) in
            make.left.equalTo(fourthView)
            make.top.equalTo(fourthView)
            make.right.equalTo(fourthView)
            make.height.equalTo(120)
        }
        
        let fourthText = UILabel()
        fourthText.text = "Bust Shot"
        fourthText.textColor = UIColor.darkGray
        
        fourthView.addSubview(fourthText)
        fourthText.snp.makeConstraints { (make) in
            make.centerX.equalTo(fourthView)
            make.bottom.equalTo(fourthView).offset(-8)
        }
        
        fourthView.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(leftRightMargin)
            make.bottom.equalTo(self.view).offset(-leftRightMargin)
            make.width.equalTo(itemWidth)
            make.height.equalTo(itemWidth + 20)
        }
        
        let fifthView = UIView()
        fifthView.isUserInteractionEnabled = true
        let tapFifth = UITapGestureRecognizer(target: self, action: #selector(tappedFifthSize))
        fifthView.addGestureRecognizer(tapFifth)
        
        self.view.addSubview(fifthView)
        
        let fifthImage = UIImageView()
        fifthImage.image = UIImage(named: "icon_shotsize_cu")
        fifthImage.contentMode = .scaleAspectFill
        fifthImage.clipsToBounds = true
        fifthImage.layer.cornerRadius = 8
        fifthImage.layer.borderWidth = 0.5
        
        fifthView.addSubview(fifthImage)
        
        fifthImage.snp.makeConstraints { (make) in
            make.left.equalTo(fifthView)
            make.top.equalTo(fifthView)
            make.right.equalTo(fifthView)
            make.height.equalTo(120)
        }
        
        let fifthText = UILabel()
        fifthText.text = "Close Up"
        fifthText.textColor = UIColor.darkGray
        
        fifthView.addSubview(fifthText)
        fifthText.snp.makeConstraints { (make) in
            make.centerX.equalTo(fifthView)
            make.bottom.equalTo(fifthView).offset(-8)
        }
        
        fifthView.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(leftRightMargin + (itemWidth * 1) + (itemSpacing * 1))
            make.bottom.equalTo(self.view).offset(-leftRightMargin)
            make.width.equalTo(itemWidth)
            make.height.equalTo(itemWidth + 20)
        }
        
        let sixthView = UIView()
        sixthView.isUserInteractionEnabled = true
        let tapSixth = UITapGestureRecognizer(target: self, action: #selector(tappedSixthSize))
        sixthView.addGestureRecognizer(tapSixth)
        
        self.view.addSubview(sixthView)
        
        let sixthImage = UIImageView()
        sixthImage.image = UIImage(named: "icon_shotsize_ecu")
        sixthImage.contentMode = .scaleAspectFill
        sixthImage.clipsToBounds = true
        sixthImage.layer.cornerRadius = 8
        sixthImage.layer.borderWidth = 0.5
        
        sixthView.addSubview(sixthImage)
        
        sixthImage.snp.makeConstraints { (make) in
            make.left.equalTo(sixthView)
            make.top.equalTo(sixthView)
            make.right.equalTo(sixthView)
            make.height.equalTo(120)
        }
        
        let sixthText = UILabel()
        sixthText.text = "Extreme Close Up"
        sixthText.textColor = UIColor.darkGray
        
        sixthView.addSubview(sixthText)
        sixthText.snp.makeConstraints { (make) in
            make.centerX.equalTo(sixthView)
            make.bottom.equalTo(sixthView).offset(-8)
        }
        
        sixthView.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(leftRightMargin + (itemWidth * 2) + (itemSpacing * 2))
            make.bottom.equalTo(self.view).offset(-leftRightMargin)
            make.width.equalTo(itemWidth)
            make.height.equalTo(itemWidth + 20)
        }
    }
    
    func sizeForPopup(_ popupController: PopupController, size: CGSize, showingKeyboard: Bool) -> CGSize {
        return CGSize(width: 450 + (leftRightMargin * 2) + (itemSpacing * 2), height: 300 + 24 + 24 + 30 + 30 + 40)
    }
}


// MARK: - Tap Action
extension ShotSizeViewController {
    public func tappedFirstSize() -> Void {
        self.delegateSelect("F.S")
    }
    
    public func tappedSecondSize() -> Void {
        self.delegateSelect("K.S")
    }
    
    public func tappedThirdSize() -> Void {
        self.delegateSelect("W.S")
    }
    
    public func tappedFourthSize() -> Void {
        self.delegateSelect("B.S")
    }
    
    public func tappedFifthSize() -> Void {
        self.delegateSelect("C.U")
    }
    
    public func tappedSixthSize() -> Void {
        self.delegateSelect("E.C.U")
    }
}
