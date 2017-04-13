//
//  MovieStoryboard.swift
//  Doocine-iOS
//
//  Created by Sohn on 18/03/2017.
//  Copyright © 2017 Sohn. All rights reserved.
//

import Foundation
import RealmSwift

class MovieStoryboard: Object {
    dynamic var id: Int = 0
    dynamic var title: String!
    dynamic var group: String!
    dynamic var director: String!
    dynamic var cameraMan: String!
    dynamic var actor: String!
}
