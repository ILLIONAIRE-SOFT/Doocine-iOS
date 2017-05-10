//
//  YoutubeViewController.swift
//  Doocine-iOS
//
//  Created by Sohn on 10/05/2017.
//  Copyright © 2017 Sohn. All rights reserved.
//

import UIKit

class YoutubeViewController: BaseViewController {

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initNavigation()
        
        self.webView.loadRequest(URLRequest(url: URL(string: "https://www.youtube.com/channel/UCCy867k4zCevUFLL8zSOqwA")!))
    }
    
    private func initNavigation() -> Void {
        super.initNavigation(barTintColor: UIColor.white, barTitle: "YOUTUBE")
    }
}
