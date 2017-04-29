//
//  BaseViewController.swift
//  Doocine-iOS
//
//  Created by Sohn on 18/03/2017.
//  Copyright © 2017 Sohn. All rights reserved.
//

import UIKit
import Dodo

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func initNavigation(barTintColor: UIColor = UIColor.white, barTitle: String = "Doocine") -> Void {
        self.navigationController?.navigationBar.barTintColor = barTintColor
        self.navigationItem.title = barTitle
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    func dodoSuccess(_ message: String) {
        view.dodo.style.bar.animationShow = DodoAnimations.slideVertically.show
        view.dodo.style.bar.animationHide = DodoAnimations.slideVertically.hide
        view.dodo.style.label.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
        view.dodo.style.bar.hideAfterDelaySeconds = 1
        view.dodo.style.bar.hideOnTap = true
        view.dodo.style.rightButton.icon = .close
        view.dodo.style.bar.onTap = {
            self.view.dodo.hide()
        }
        view.dodo.style.rightButton.onTap = {
            self.view.dodo.hide()
        }
        view.dodo.success(message)
    }
    
    func dodoWarning(_ message: String) {
        view.dodo.style.bar.animationShow = DodoAnimations.slideVertically.show
        view.dodo.style.bar.animationHide = DodoAnimations.slideVertically.hide
        view.dodo.style.label.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
        view.dodo.style.bar.hideAfterDelaySeconds = 1
        view.dodo.style.bar.hideOnTap = true
        view.dodo.style.rightButton.icon = .close
        view.dodo.style.bar.onTap = {
            self.view.dodo.hide()
        }
        view.dodo.style.rightButton.onTap = {
            self.view.dodo.hide()
        }
        view.dodo.warning(message)
    }
    
    func dodoError(_ message: String) {
        view.dodo.style.bar.animationShow = DodoAnimations.slideVertically.show
        view.dodo.style.bar.animationHide = DodoAnimations.slideVertically.hide
        view.dodo.style.label.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
        view.dodo.style.bar.hideAfterDelaySeconds = 1
        view.dodo.style.bar.hideOnTap = true
        view.dodo.style.rightButton.icon = .close
        view.dodo.style.bar.onTap = {
            self.view.dodo.hide()
        }
        view.dodo.style.rightButton.onTap = {
            self.view.dodo.hide()
        }
        view.dodo.error(message)
    }

}
