//
//  Cut.swift
//  Doocine-iOS
//
//  Created by Sohn on 30/03/2017.
//  Copyright © 2017 Sohn. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift
import Realm

class Cut: Object {
    dynamic var firstImage: String!
    dynamic var secondImage: String!
    
    dynamic var cameraWalkMode: String!
    dynamic var shotSize: String!
    dynamic var dialog: String!
    
    public func isTopEndCut() -> Bool {
        return false
    }
}
