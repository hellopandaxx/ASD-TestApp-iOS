//
//  CollegeRaiting.swift
//  ASD-TestApp
//
//  Created by Sergey Kuznetsov on 17/10/2018.
//  Copyright © 2018 Sergey Kuznetsov. All rights reserved.
//

import UIKit
import SwiftyJSON
import RealmSwift

class CollegeRaiting: Object {
    @objc dynamic var id = 0
    @objc dynamic var rating = 0.0
    
    convenience init(json: JSON) {
        self.init()
        
        self.id = json["college_id"].intValue
        self.rating = json["rating"].doubleValue
}
}

