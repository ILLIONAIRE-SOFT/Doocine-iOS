//
//  TutorialViewController.swift
//  Doocine-iOS
//
//  Created by Sohn on 18/03/2017.
//  Copyright © 2017 Sohn. All rights reserved.
//

import UIKit
import SnapKit

class TutorialViewController: BaseViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var createProjectButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initNavigation()
        initViews()
        initButtons()
    }
    
    private func initNavigation() {
        super.initNavigation(barTintColor: UIColor.white, barTitle: "Tutorial")
    }
    
    private func initViews() {
        createProjectButton.backgroundColor = UIColor.tangerine
        createProjectButton.layer.cornerRadius = 6
        createProjectButton.setTitleColor(UIColor.white, for: .normal)
        
        makeLandingPage()
    }
    
    private func initButtons() -> Void {
        createProjectButton.addTarget(self, action: #selector(presentHomeViewController), for: .touchUpInside)
    }
}


// MARK: - Make Landing Page
extension TutorialViewController {
    fileprivate func makeLandingPage() -> Void {
        let viewWidth = UIScreen.main.bounds.width
        let contentWidth = UIScreen.main.bounds.width * 3
        let contentHeight = UIScreen.main.bounds.height - bottomView.bounds.height - UIApplication.shared.statusBarFrame.size.height
        scrollView.contentSize = CGSize(width: contentWidth, height: contentHeight)
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        
        makePageControl()
        makeFirstLandingPage(offset: viewWidth * 0, width: viewWidth, height: contentHeight)
        makeSecondLandingPage(offset: viewWidth * 1, width: viewWidth, height: contentHeight)
        makeThirdLandingPage(offset: viewWidth * 2, width: viewWidth, height: contentHeight)
    }
    
    private func makePageControl() -> Void {
        pageControl.numberOfPages = 3
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = UIColor.orange
        pageControl.pageIndicatorTintColor = UIColor.lightGray.withAlphaComponent(0.8)
    }
    
    private func makeFirstLandingPage(offset: CGFloat, width: CGFloat, height: CGFloat) -> Void {
        let firstView = UIView(frame: CGRect(x: offset, y: 0, width: width, height: height))
        firstView.backgroundColor = UIColor.white
        
        let firstImageView = UIImageView()
        firstImageView.image = UIImage(named: "img_tutorial_1")
        firstImageView.contentMode = .scaleAspectFit
        
        firstView.addSubview(firstImageView)
        
        firstImageView.snp.makeConstraints { (make) in
            make.top.equalTo(firstView).offset(128)
            make.centerX.equalTo(firstView)
            make.width.equalTo(360)
            make.height.equalTo(360)
        }
        
        let firstTextHeader = UILabel()
        firstTextHeader.text = "공공씨네OOCINE는"
        firstTextHeader.font = UIFont.boldSystemFont(ofSize: 24)
        firstTextHeader.textColor = UIColor.darkGray
        firstTextHeader.textAlignment = .center
        
        firstView.addSubview(firstTextHeader)
        
        firstTextHeader.snp.makeConstraints { (make) in
            make.centerX.equalTo(firstView)
            make.left.equalTo(firstView).offset(24)
            make.right.equalTo(firstView).offset(-24)
            make.top.equalTo(firstImageView.snp.bottom).offset(64)
        }
        
        let firstTextView = UITextView()
        firstTextView.text = "종이와 펜으로 이뤄지는 낡은 교육을 혁신하고,\n영상을 통해 새로운 시대에 맞는\n새로운 교육콘텐츠를 다양한 영역에 제공합니다."
        firstTextView.isUserInteractionEnabled = false
        firstTextView.textAlignment = .center
        firstTextView.textColor = UIColor.gray
        firstTextView.font = UIFont.systemFont(ofSize: 20)
        
        firstView.addSubview(firstTextView)
        
        firstTextView.snp.makeConstraints { (make) in
            make.centerX.equalTo(firstView)
            make.left.equalTo(firstView).offset(24)
            make.right.equalTo(firstView).offset(-24)
            make.bottom.equalTo(firstView).offset(-24)
            make.top.equalTo(firstTextHeader.snp.bottom).offset(8)
        }
        
        scrollView.addSubview(firstView)
    }
    
    private func makeSecondLandingPage(offset: CGFloat, width: CGFloat, height: CGFloat) -> Void {
        let firstView = UIView(frame: CGRect(x: offset, y: 0, width: width, height: height))
        firstView.backgroundColor = UIColor.white
        
        let firstImageView = UIImageView()
        firstImageView.image = UIImage(named: "img_tutorial_2")
        firstImageView.contentMode = .scaleAspectFit
        
        firstView.addSubview(firstImageView)
        
        firstImageView.snp.makeConstraints { (make) in
            make.top.equalTo(firstView).offset(128)
            make.centerX.equalTo(firstView)
            make.width.equalTo(360)
            make.height.equalTo(360)
        }
        
        let firstTextHeader = UILabel()
        firstTextHeader.text = "한국인이 하루 중 영상을 보는 시간, 2시간."
        firstTextHeader.font = UIFont.boldSystemFont(ofSize: 24)
        firstTextHeader.textColor = UIColor.darkGray
        firstTextHeader.textAlignment = .center
        
        firstView.addSubview(firstTextHeader)
        
        firstTextHeader.snp.makeConstraints { (make) in
            make.centerX.equalTo(firstView)
            make.left.equalTo(firstView).offset(24)
            make.right.equalTo(firstView).offset(-24)
            make.top.equalTo(firstImageView.snp.bottom).offset(64)
        }
        
        let firstTextView = UITextView()
        firstTextView.text = "공공씨네의 FILMMAKING 툴은\n누구나 쉽게 영상을 읽고 쓸수 있도록 하는\n교육도구로 사용됩니다."
        firstTextView.isUserInteractionEnabled = false
        firstTextView.textAlignment = .center
        firstTextView.textColor = UIColor.gray
        firstTextView.font = UIFont.systemFont(ofSize: 20)
        
        firstView.addSubview(firstTextView)
        
        firstTextView.snp.makeConstraints { (make) in
            make.centerX.equalTo(firstView)
            make.left.equalTo(firstView).offset(24)
            make.right.equalTo(firstView).offset(-24)
            make.bottom.equalTo(firstView).offset(-24)
            make.top.equalTo(firstTextHeader.snp.bottom).offset(8)
        }
        scrollView.addSubview(firstView)
    }
    
    private func makeThirdLandingPage(offset: CGFloat, width: CGFloat, height: CGFloat) -> Void {
        let firstView = UIView(frame: CGRect(x: offset, y: 0, width: width, height: height))
        firstView.backgroundColor = UIColor.white
        
        let firstImageView = UIImageView()
        firstImageView.image = UIImage(named: "img_tutorial_3")
        firstImageView.contentMode = .scaleAspectFit
        
        firstView.addSubview(firstImageView)
        
        firstImageView.snp.makeConstraints { (make) in
            make.top.equalTo(firstView).offset(128)
            make.centerX.equalTo(firstView)
            make.width.equalTo(360)
            make.height.equalTo(360)
        }
        
        let firstTextHeader = UILabel()
        firstTextHeader.text = "이야기 시각화의 첫 단계, 스토리보드"
        firstTextHeader.font = UIFont.boldSystemFont(ofSize: 24)
        firstTextHeader.textColor = UIColor.darkGray
        firstTextHeader.textAlignment = .center
        
        firstView.addSubview(firstTextHeader)
        
        firstTextHeader.snp.makeConstraints { (make) in
            make.centerX.equalTo(firstView)
            make.left.equalTo(firstView).offset(24)
            make.right.equalTo(firstView).offset(-24)
            make.top.equalTo(firstImageView.snp.bottom).offset(64)
        }
        
        let firstTextView = UITextView()
        firstTextView.text = "DooCine-Storyboard는\n직접 찍은 사진을 통해 이야기 시각화의 과정을\n쉽게 도와주는 어플리케이션 입니다."
        firstTextView.isUserInteractionEnabled = false
        firstTextView.textAlignment = .center
        firstTextView.textColor = UIColor.gray
        firstTextView.font = UIFont.systemFont(ofSize: 20)
        
        firstView.addSubview(firstTextView)
        
        firstTextView.snp.makeConstraints { (make) in
            make.centerX.equalTo(firstView)
            make.left.equalTo(firstView).offset(24)
            make.right.equalTo(firstView).offset(-24)
            make.bottom.equalTo(firstView).offset(-24)
            make.top.equalTo(firstTextHeader.snp.bottom).offset(8)
        }
        
        scrollView.addSubview(firstView)
    }
}


// MARK: - ScrollView Delegate
extension TutorialViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentPage = scrollView.contentOffset.x / UIScreen.main.bounds.width
        pageControl.currentPage = Int(currentPage)
    }
}


// MARK: - Segue
extension TutorialViewController {
    func presentHomeViewController() {
        performSegue(withIdentifier: "PresentHomeViewControllerFromTutorial", sender: self)
    }
}
