//
//  CollegeService.swift
//  ASD-TestApp
//
//  Created by Sergey Kuznetsov on 17/10/2018.
//  Copyright © 2018 Sergey Kuznetsov. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import RealmSwift

final class CollegeService: NSObject {
    let baseUrl = "http://asdgroup.pro/tasks/"

    func loadColleges()
    {
        let collegesPath = "colleges.json"
        
        let collegesUrl = baseUrl + collegesPath
        
        Alamofire.request(collegesUrl, method: .get).responseData { [weak self] response in
            
            guard let collegesData = response.value else { return }
            
            let collegesJson = try! JSON(data: collegesData)
            
            let colleges = collegesJson.compactMap{College(json: $1)}
            
            self?.saveColleges(colleges)
            
            
            let ratingsPath = "ratings.json"
            let ratingsUrl = (self?.baseUrl)! + ratingsPath
            
            Alamofire.request(ratingsUrl, method: .get).responseData { [weak self] response in
                
                guard let collegesData = response.value else { return }
                
                let collegesJson = try! JSON(data: collegesData)
                
                let raitings = collegesJson.compactMap{CollegeRaiting(json: $1)}
                
                self?.saveRatings(raitings)
            }
        }
        
        let collegesInfoPath = "details.json"
        
        let collegesDetailsUrl = baseUrl + collegesInfoPath
        
        Alamofire.request(collegesDetailsUrl, method: .get).responseData { [weak self] response in
            
            guard let detailsData = response.value else { return }
            
            let detailsJson = try! JSON(data: detailsData)
            
            let collegesDetails = detailsJson.compactMap{CollegeDetail(json: $1)} //
            
            self?.saveCollegesDetails(collegesDetails)
        }
    }
    
    func getCollegeSite(collegeId: Int) -> String? {
        do{
            let realm = try Realm()
            
            let details = realm.objects(CollegeDetail.self).filter("id==%@", collegeId)
            
            return details.first?.site
        } catch{
            print(error)
        }
        
        return nil
    }
    
    private func saveRatings(_ raitings: [CollegeRaiting]){
        do{
            let realm = try Realm()
            
            for rating in raitings{
                let college = realm.object(ofType: College.self, forPrimaryKey: rating.id)
                
                    realm.beginWrite()
                    college?.rating = rating.rating
                    try realm.commitWrite()
            }
        } catch{
            print(error)
        }
    }
    
    private func saveColleges(_ colleges: [College]){
        do{
            let realm = try Realm()
            
            let oldColleges = realm.objects(College.self)
            
            realm.beginWrite()
            realm.delete(oldColleges)
            realm.add(colleges)
            try realm.commitWrite()
        } catch{
            print(error)
        }
    }
    
    private func saveCollegesDetails(_ details: [CollegeDetail]){
        do{
            let realm = try Realm()
            
            let oldCollegeDetails = realm.objects(CollegeDetail.self)
            
            realm.beginWrite()
            realm.delete(oldCollegeDetails)
            realm.add(details)
            try realm.commitWrite()
        } catch{
            print(error)
        }
    }
}
