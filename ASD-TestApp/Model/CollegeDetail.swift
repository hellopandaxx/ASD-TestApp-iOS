//
//  CollegeDetail.swift
//  ASD-TestApp
//
//  Created by Sergey Kuznetsov on 17/10/2018.
//  Copyright © 2018 Sergey Kuznetsov. All rights reserved.
//

import UIKit
import SwiftyJSON
import RealmSwift

class CollegeDetail: Object {
    @objc dynamic var id = 0
    @objc dynamic var site = ""
    
    convenience init(json: JSON) {
        self.init()
        
        self.id = json["college_id"].intValue
        self.site = json["site"].stringValue
    }
}
