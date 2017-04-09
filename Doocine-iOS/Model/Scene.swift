//
//  Scene.swift
//  Doocine-iOS
//
//  Created by Sohn on 18/03/2017.
//  Copyright © 2017 Sohn. All rights reserved.
//

import UIKit
import RealmSwift

class Scene: Object {
    dynamic var id: Int = 0
    dynamic var storyboardId: Int = 0
    dynamic var title: String!
    dynamic var place: String!
    dynamic var time: String!
    dynamic var cutCount: Int = 0
}
