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
    var loadingView = UIView()
//    let activityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 25, height: 25),
//                                                        type: .remoteControl,
//                                                        color: UIColor.white)
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func initNavigation(barTintColor: UIColor = UIColor.white, tintColor: UIColor = .orange, barTitle: String = "Doocine") -> Void {
        self.navigationController?.navigationBar.barTintColor = barTintColor
        self.navigationController?.navigationBar.tintColor = tintColor
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
    
    func showLoading(view: UIView) -> Void {
        self.loadingView.frame = CGRect(x: 0, y:0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height*2)
        self.view.addSubview(self.loadingView)
        self.loadingView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
//        activityIndicatorView.center = CGPoint(x: self.loadingView.center.x, y: self.loadingView.center.y-50)
//        self.activityIndicatorView.startAnimating()
        UIView.animate(withDuration: 0.3, animations: {
            self.loadingView.alpha = 1.0
        })
    }
    
    func hideLoading() -> Void {
        UIView.animate(withDuration: 0.3, animations: {
            self.loadingView.alpha = 0.0
        }, completion: {
            (finished: Bool) -> Void in
//            self.activityIndicatorView.stopAnimating()
            self.loadingView.removeFromSuperview()
        })
    }
}
