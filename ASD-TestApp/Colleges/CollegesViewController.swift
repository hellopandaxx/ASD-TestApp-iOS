//
//  ViewController.swift
//  ASD-TestApp
//
//  Created by Sergey Kuznetsov on 17/10/2018.
//  Copyright © 2018 Sergey Kuznetsov. All rights reserved.
//

import UIKit
import RealmSwift

class CollegesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var collegesTableView: UITableView!
    
    var colleges: Results<College>?
    
    var token: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collegesTableView.delegate = self
        collegesTableView.dataSource = self
        
        collegeService.loadColleges()
        
        pairTableAndRealm()
    }

    func pairTableAndRealm(){
        guard let realm = try? Realm() else { return }
        colleges = realm.objects(College.self)
        token = colleges?.observe { [weak self] (changes: RealmCollectionChange) in
            guard let tableView = self?.collegesTableView else { return }
            switch changes {
            case .initial:
                tableView.reloadData()
                break
            case .update(_, let deletions, let insertions, let modifications):
                tableView.beginUpdates()
                tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }),
                                     with: .automatic)
                tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}),
                                     with: .automatic)
                tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }),
                                     with: .automatic)
                tableView.endUpdates()
                break
            case .error(let error):
                fatalError("\(error)")
                break
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colleges?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CollegeCell", for: indexPath) as? CollegesTableViewCell
        
        cell?.collegeName.text = colleges![indexPath.row].name
        
        cell?.collegeShortName.text = colleges![indexPath.row].abbreviation
        cell?.ratingLabel.text = colleges![indexPath.row].rating.description
        
        return cell!
    }
    
    @IBAction func sortChanged(_ sender: UISegmentedControl) {
        switch(sender.selectedSegmentIndex)
        {
            case 0:
                colleges = colleges?.sorted(byKeyPath: "rating", ascending: false)
                collegesTableView.reloadData()
                break
        case 1:
            colleges = colleges?.sorted(byKeyPath: "rating", ascending: true)
            collegesTableView.reloadData()
            break
        case 2:
            colleges = colleges?.sorted(byKeyPath: "name", ascending: true)
            collegesTableView.reloadData()
            break
        default:
            print()
            break
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCollege" {
            let collegeController = segue.destination as? CollegeViewController
            
            if let indexPath = collegesTableView.indexPathForSelectedRow {
                let college = colleges![indexPath.row]
                collegeController?.college = college
            }
        }
    }
}

