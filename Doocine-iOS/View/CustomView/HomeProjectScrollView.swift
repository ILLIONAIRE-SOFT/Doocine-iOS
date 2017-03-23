//
//  HomeProjectScrollView.swift
//  Doocine-iOS
//
//  Created by Sohn on 23/03/2017.
//  Copyright © 2017 Sohn. All rights reserved.
//

import UIKit
import SnapKit

class HomeProjectScrollView: UIView {
    
    var storyboards: [MovieStoryboard]!
    
    var pageControl: UIPageControl!
    
    let leftMargin: CGFloat = 36
    let rightMargin: CGFloat = 36
    
    var projectCountLabel: UILabel!
    var browseAllButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.makeTestProjects()
        self.initViews()
        self.initProjectsViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initViews() -> Void {
        projectCountLabel = UILabel()
        projectCountLabel.text = "MY PROJECT | \(self.storyboards.count) projects"
        projectCountLabel.textColor = UIColor.darkBlueGrey
        projectCountLabel.font = UIFont.systemFont(ofSize: 16)
        
        self.addSubview(projectCountLabel)
        
        projectCountLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(leftMargin)
            make.top.equalTo(self).offset(leftMargin)
        }
        
        browseAllButton = UIButton()
        browseAllButton.setTitle("ALL", for: .normal)
        browseAllButton.backgroundColor = UIColor.tangerine
        browseAllButton.layer.cornerRadius = 8
        browseAllButton.setTitleColor(UIColor.white, for: .normal)
        
        self.addSubview(browseAllButton)
        
        browseAllButton.snp.makeConstraints { (make) in
            make.trailing.equalTo(self).offset(-rightMargin)
            make.top.equalTo(self).offset(leftMargin)
            make.width.equalTo(60)
            make.height.equalTo(28)
        }
    }
    
    public func initProjectsViews() -> Void {
        let scrollView = UIScrollView()
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width * 3, height: 180)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        
        self.addSubview(scrollView)
        
        scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(projectCountLabel.snp.bottom).offset(24)
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.height.equalTo(180)
        }
        
        let makeNewProjectView = MakeNewProjectView(frame: CGRect(), order: 0)
        scrollView.addSubview(makeNewProjectView)
        
        for i in 1...storyboards.count-1 {
            let projectView = ProjectView(frame: CGRect(), order: i, storyboard: storyboards[i])
            projectView.storyboard = storyboards[i]
            projectView.makeHandlePropertyChnage()
            scrollView.addSubview(projectView)
        }
        
        pageControl = UIPageControl()
        pageControl.numberOfPages = 3
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.currentPageIndicatorTintColor = UIColor.red
        
        self.addSubview(pageControl)
        
        pageControl.snp.makeConstraints { (make) in
            make.top.equalTo(scrollView.snp.bottom).offset(12)
            make.centerX.equalTo(self)
            make.width.equalTo(60)
            make.height.equalTo(40)
        }
        
    }
    
    private func makeTestProjects() -> Void {
        self.storyboards = [MovieStoryboard]()
        
        storyboards.append(MovieStoryboard())
        storyboards.append(MovieStoryboard())
        storyboards.append(MovieStoryboard())
        storyboards.append(MovieStoryboard())
        storyboards.append(MovieStoryboard())
        storyboards.append(MovieStoryboard())
        storyboards.append(MovieStoryboard())
        storyboards.append(MovieStoryboard())
        storyboards.append(MovieStoryboard())   
    }
    
}


// MARK: - ScrollView Delegate
extension HomeProjectScrollView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentPage = scrollView.contentOffset.x / UIScreen.main.bounds.width
        pageControl.currentPage = Int(currentPage)
    }
}
