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
            print("Title DidSet")
            if handlePropertyChange != nil {
                self.handlePropertyChange?()
            }
        }
    }
    var group: String!
    var director: String!
    var camera: String!
    var actor: String!
    
    var handlePropertyChange: (() -> ())?
    
    init() {
        title = "Test Project"
        group = "Doocine"
        director = "DaiGeun Sohn"
        camera = "Christoper Nolan"
        actor = "Tang Wei"
    }
}
