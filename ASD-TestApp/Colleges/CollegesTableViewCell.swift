//
//  CollegesTableViewCell.swift
//  ASD-TestApp
//
//  Created by Sergey Kuznetsov on 17/10/2018.
//  Copyright © 2018 Sergey Kuznetsov. All rights reserved.
//

import UIKit

class CollegesTableViewCell: UITableViewCell {
    @IBOutlet weak var collegeName: UILabel!
    @IBOutlet weak var collegeShortName: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
