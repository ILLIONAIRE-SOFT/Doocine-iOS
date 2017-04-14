//
//  CameraWalkPopup.swift
//  Doocine-iOS
//
//  Created by Sohn on 14/04/2017.
//  Copyright © 2017 Sohn. All rights reserved.
//

import UIKit
import SnapKit
import PopupController

class CameraWalkPopup: UIViewController, PopupContentViewController {

    var delegateSelect: ((_ selectedSize: String) -> ())!
    var itemWidth: CGFloat = 150
    var leftRightMargin: CGFloat = 16
    var itemSpacing: CGFloat = 8
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    private func initViews() -> Void {
        initViews()
    }
    
    func sizeForPopup(_ popupController: PopupController, size: CGSize, showingKeyboard: Bool) -> CGSize {
        return CGSize(width: 600 + (leftRightMargin * 2) + (itemSpacing * 3), height: 250)
    }
}


// MARK: - Tap Action
extension CameraWalkPopup {
    public func tappedFirstSize() -> Void {
        self.delegateSelect("Long Shot")
    }
    
    public func tappedSecondSize() -> Void {
        self.delegateSelect("Medium Long Shot")
    }
    
    public func tappedThirdSize() -> Void {
        self.delegateSelect("Full Shot")
    }
    
    public func tappedFourthSize() -> Void {
        self.delegateSelect("Closure Shot")
    }
    
    public func tappedSize(sender: UIButton) -> Void {
        
    }
}
