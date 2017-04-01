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

class Cut: RLMObject {
    dynamic var firstImage: String!
    dynamic var secondImage: String!
    
    dynamic var cameraWalkMode: Int = 0
    dynamic var shotSize: Int = 0
    dynamic var dialog: String!
    
    public func isTopEndCut() -> Bool {
        return false
    }
}
