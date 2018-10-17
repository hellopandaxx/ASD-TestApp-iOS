//
//  College.swift
//  ASD-TestApp
//
//  Created by Sergey Kuznetsov on 17/10/2018.
//  Copyright © 2018 Sergey Kuznetsov. All rights reserved.
//

import UIKit
import SwiftyJSON
import RealmSwift

class College: Object {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var abbreviation = ""
    @objc dynamic var rating = 0.0

    override static func primaryKey() -> String?{
        return "id"
    }
    
    convenience init(json: JSON) {
        self.init()
        
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.abbreviation = json["abbreviation"].stringValue
    }
}
