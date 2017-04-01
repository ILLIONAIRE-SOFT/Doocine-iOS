//
//  MovieStoryboard.swift
//  Doocine-iOS
//
//  Created by Sohn on 18/03/2017.
//  Copyright © 2017 Sohn. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class MovieStoryboard: Object {
    
    dynamic var title: String!
    
    dynamic var group: String!
    
    dynamic var director: String!
    
    dynamic var cameraMan: String!

    dynamic var actor: String!
    
    dynamic var scenes = RLMArray(objectClassName: "Scene")
    
//    var handlePropertyChange: (() -> ())?
    
    required init() {
        super.init()
        title = ""
        group = ""
        director = ""
        cameraMan = ""
        actor = ""
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        fatalError("init(realm:schema:) has not been implemented")
    }
    
    required init(value: Any, schema: RLMSchema) {
        fatalError("init(value:schema:) has not been implemented")
    }
}
