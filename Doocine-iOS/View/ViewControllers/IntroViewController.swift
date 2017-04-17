//
//  IntroViewController.swift
//  Doocine-iOS
//
//  Created by Sohn on 14/04/2017.
//  Copyright © 2017 Sohn. All rights reserved.
//

import UIKit
import SnapKit

class IntroViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        scrollView.isScrollEnabled = true
        scrollView.isUserInteractionEnabled = true
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "img_intro")
        imageView.contentMode = .scaleAspectFit
        
        scrollView.addSubview(imageView)
        
        imageView.snp.makeConstraints { (make) in
            make.left.equalTo(scrollView)
            make.top.equalTo(scrollView)
            make.right.equalTo(scrollView)
            make.bottom.equalTo(scrollView)
            make.width.equalTo(UIScreen.main.bounds.width)
        }
    }
}
