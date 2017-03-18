//
//  TutorialViewController.swift
//  Doocine-iOS
//
//  Created by Sohn on 18/03/2017.
//  Copyright © 2017 Sohn. All rights reserved.
//

import UIKit

class TutorialViewController: BaseViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var createProjectButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initNavigation()
        initViews()
    }
    
    private func initNavigation() {
        super.initNavigation(barTintColor: UIColor.white, barTitle: "Tutorial")
    }
    
    private func initViews() {
        createProjectButton.backgroundColor = UIColor.tangerine
        createProjectButton.layer.cornerRadius = 6
        createProjectButton.setTitleColor(UIColor.white, for: .normal)
        
        skipButton.setTitleColor(UIColor.greishBrown, for: .normal)
        
        makeLandingPage()
    }
}


// MARK: - Make Landing Page
extension TutorialViewController {
    fileprivate func makeLandingPage() -> Void {
        let viewWidth = UIScreen.main.bounds.width
        let contentWidth = UIScreen.main.bounds.width * 3
        let contentHeight = UIScreen.main.bounds.height - bottomView.bounds.height
        scrollView.contentSize = CGSize(width: contentWidth, height: contentHeight)
        scrollView.isPagingEnabled = true
        
        makeFirstLandingPage(offset: viewWidth * 0, width: viewWidth, height: contentHeight)
        makeSecondLandingPage(offset: viewWidth * 1, width: viewWidth, height: contentHeight)
        makeThirdLandingPage(offset: viewWidth * 2, width: viewWidth, height: contentHeight)
    }
    
    private func makeFirstLandingPage(offset: CGFloat, width: CGFloat, height: CGFloat) -> Void {
        let firstPage = UIView(frame: CGRect(x: offset, y: 0, width: width, height: height))
        firstPage.backgroundColor = UIColor.lightGray
        
        scrollView.addSubview(firstPage)
    }
    
    private func makeSecondLandingPage(offset: CGFloat, width: CGFloat, height: CGFloat) -> Void {
        let secondPage = UIView(frame: CGRect(x: offset, y: 0, width: width, height: height))
        secondPage.backgroundColor = UIColor.white
        
        scrollView.addSubview(secondPage)
    }
    
    private func makeThirdLandingPage(offset: CGFloat, width: CGFloat, height: CGFloat) -> Void {
        let thirdPage = UIView(frame: CGRect(x: offset, y: 0, width: width, height: height))
        thirdPage.backgroundColor = UIColor.lightGray
        
        scrollView.addSubview(thirdPage)
    }
}
