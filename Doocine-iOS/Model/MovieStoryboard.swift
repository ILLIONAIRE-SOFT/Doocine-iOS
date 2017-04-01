//
//  MovieStoryboard.swift
//  Doocine-iOS
//
//  Created by Sohn on 18/03/2017.
//  Copyright © 2017 Sohn. All rights reserved.
//

import Foundation

class MovieStoryboard {
    
    var title: String! {
        didSet {
            if handlePropertyChange != nil {
                self.handlePropertyChange?()
            }
        }
    }
    
    var group: String! {
        didSet {
            if handlePropertyChange != nil {
                self.handlePropertyChange?()
            }
        }
    }
    
    var director: String! {
        didSet {
            if handlePropertyChange != nil {
                self.handlePropertyChange?()
            }
        }
    }
    
    var cameraMan: String! {
        didSet {
            if handlePropertyChange != nil {
                self.handlePropertyChange?()
            }
        }
    }
    
    var actor: String! {
        didSet {
            if handlePropertyChange != nil {
                self.handlePropertyChange?()
            }
        }
    }
    
    var handlePropertyChange: (() -> ())?
    
    init() {
        title = "Test Project"
        group = "Doocine"
        director = "DaiGeun Sohn"
        cameraMan = "Christoper Nolan"
        actor = "Tang Wei"
    }
}
