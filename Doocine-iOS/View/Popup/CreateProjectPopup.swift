//
//  CreateProjectPopup.swift
//  Doocine-iOS
//
//  Created by Sohn on 30/03/2017.
//  Copyright © 2017 Sohn. All rights reserved.
//

import UIKit
import PopupController

class CreateProjectPopup: UIViewController, PopupContentViewController {
    
    var delegateCreate: (() -> ())!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func sizeForPopup(_ popupController: PopupController, size: CGSize, showingKeyboard: Bool) -> CGSize {
        let width = UIScreen.main.bounds.width - 240
        let height: CGFloat = 474 + 36
        return CGSize(width: width, height: height)
    }
}
