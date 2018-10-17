//
//  CollegeViewController.swift
//  ASD-TestApp
//
//  Created by Sergey Kuznetsov on 17/10/2018.
//  Copyright © 2018 Sergey Kuznetsov. All rights reserved.
//

import UIKit

class CollegeViewController: UIViewController {
    @IBOutlet weak var collegeNameLabel: UILabel!
    
    @IBOutlet weak var collegeShortNameLabel: UILabel!
    
    @IBOutlet weak var collegeSiteLabel: UILabel!
    
    var college : College?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collegeNameLabel.text = college?.name
        collegeShortNameLabel.text = college?.abbreviation
        collegeSiteLabel.text = collegeService.getCollegeSite(collegeId: (college?.id)!) ?? ""

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
