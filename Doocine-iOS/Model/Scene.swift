//
//  Scene.swift
//  Doocine-iOS
//
//  Created by Sohn on 18/03/2017.
//  Copyright © 2017 Sohn. All rights reserved.
//

import UIKit
import RealmSwift
import Realm

class Scene: RLMObject {
    dynamic var title: UIImage!
    dynamic var place: UIImage!
    dynamic var time: Date!
    
    dynamic var cuts = RLMArray(objectClassName: "Cut")
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        fatalError("init(realm:schema:) has not been implemented")
    }
}
