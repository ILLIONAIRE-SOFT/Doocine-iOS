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
    dynamic var id: Int = 0
    dynamic var sceneId: Int = 0
    dynamic var cutNumber: Int = 0
    
    dynamic var firstImage: String!
    dynamic var secondImage: String!
    
    dynamic var cameraWalkMode: String!
    dynamic var shotSize: String!
    dynamic var dialog: String!
    
    public func isTopEndCut() -> Bool {
        return false
    }
    
    public func needSecondSubCut() -> Bool {
        if self.cameraWalkMode == "FIX" {
            return false
        } else {
            return true
        }
    }
}

