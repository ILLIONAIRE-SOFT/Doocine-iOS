//
//  MakeCutViewController.swift
//  Doocine-iOS
//
//  Created by Sohn on 13/04/2017.
//  Copyright © 2017 Sohn. All rights reserved.
//

import UIKit
import PopupController

class MakeCutViewController: BaseViewController {
    
    var sceneId: Int!
    @IBOutlet weak var shotSizeValueLabel: UILabel!
    @IBOutlet weak var cameraWalkValueLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        initNavigation()
        initViews()
    }
    
    private func initNavigation() -> Void {
        super.initNavigation(barTintColor: .white, barTitle: "Make Cut")
    }
    
    private func initViews() -> Void {
        self.shotSizeValueLabel.isUserInteractionEnabled = true
        self.cameraWalkValueLabel.isUserInteractionEnabled = true
        
        let tapShotSize = UITapGestureRecognizer(target: self, action: #selector(tappedSelectShotSize))
        shotSizeValueLabel.addGestureRecognizer(tapShotSize)
        
        let tapCameraWalk = UITapGestureRecognizer(target: self, action: #selector(tappedSelectCameraWalk))
        cameraWalkValueLabel.addGestureRecognizer(tapCameraWalk)
    }
}


// MARK: - Tap Action
extension MakeCutViewController {
    public func tappedSelectShotSize() -> Void {
        var popup = PopupController.create(self).customize(
            [.animation(.slideUp),
             .scrollable(false),
             .backgroundStyle(.blackFilter(alpha:0.7)),
             .layout(.center),
             .movesAlongWithKeyboard(true)
            ])
        
        let popupSB = UIStoryboard(name: "Popup", bundle: nil)
        let controller = popupSB.instantiateViewController(withIdentifier: "ShotSizeViewController") as! ShotSizeViewController
        
        controller.delegateSelect = { (selectedSize) in
            print(selectedSize)
            self.shotSizeValueLabel.text = selectedSize
            popup.dismiss()
        }
        
        popup.didShowHandler { (_) in
        }
        
        popup.didCloseHandler { (_) in
        }
        
        popup = popup.show(controller)
    }
    
    public func tappedSelectCameraWalk() -> Void {
        var popup = PopupController.create(self).customize(
            [.animation(.slideUp),
             .scrollable(false),
             .backgroundStyle(.blackFilter(alpha:0.7)),
             .layout(.center),
             .movesAlongWithKeyboard(true)
            ])
        
        let popupSB = UIStoryboard(name: "Popup", bundle: nil)
        let controller = popupSB.instantiateViewController(withIdentifier: "CameraWalkPopup") as! CameraWalkPopup
        
        controller.delegateSelect = { (selectedSize) in
            self.cameraWalkValueLabel.text = selectedSize
            popup.dismiss()
        }
        
        popup.didShowHandler { (_) in
        }
        
        popup.didCloseHandler { (_) in
        }
        
        popup = popup.show(controller)
    }
}
