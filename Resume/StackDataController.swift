//
//  StackDataController.swift
//  Resume
//
//  Created by Ian MacCallum on 8/16/15.
//  Copyright © 2015 Ian MacCallum. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class StackUser: NSObject, NSCoding {
    var name: String?
    var image: UIImage? = UIImage(named: "Profile_Picture")
    var imageUrl: String?
    var badges: (bronze: Int, silver: Int, gold: Int)?
    var reputation: Int?
    let careersUrl = "http://careers.stackoverflow.com/ianmaccallum"

    override var description: String {
        return "\(name): \(reputation)"
    }

    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObjectForKey("name") as? String
        image = aDecoder.decodeObjectForKey("image") as? UIImage
        imageUrl = aDecoder.decodeObjectForKey("url") as? String
        badges?.bronze = (aDecoder.decodeObjectForKey("bronze") as? Int) ?? 0
        badges?.silver = (aDecoder.decodeObjectForKey("silver") as? Int) ?? 0
        badges?.gold = (aDecoder.decodeObjectForKey("gold") as? Int) ?? 0
        reputation = aDecoder.decodeObjectForKey("reputation") as? Int
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeObject(image, forKey: "image")
        aCoder.encodeObject(imageUrl, forKey: "url")
        aCoder.encodeObject(badges?.bronze, forKey: "bronze")
        aCoder.encodeObject(badges?.silver, forKey: "silver")
        aCoder.encodeObject(badges?.gold, forKey: "gold")
        aCoder.encodeObject(reputation, forKey: "reputation")
    }

    init(userDict: [String: AnyObject]) {
        name = userDict["display_name"] as? String
        imageUrl = userDict["profile_image"] as? String
        let bronze = (userDict["badge_counts"] as! [String: Int])["bronze"]
        let silver = (userDict["badge_counts"] as! [String: Int])["silver"]
        let gold = (userDict["badge_counts"] as! [String: Int])["gold"]
        badges = (bronze ?? 0, silver ?? 0, gold ?? 0)
        reputation = userDict["reputation"] as? Int
    }
}


class StackWebService {
    let id = 3810673

    func fetchUser(completion: ((user: StackUser?) -> Void)) {
       
        let url = NSURL(string: "https://api.stackexchange.com/2.2/users/\(id)?order=desc&sort=reputation&site=stackoverflow")
        print(url)
        NSURLSession.sharedSession().dataTaskWithURL(url!) { data, response, error in
            
            print(data)
            print(response)
            print(error)
            guard let data = data else {
                completion(user: nil)
                return
            }

            
            do {
                let dict = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
                print(dict)
                let items = (dict["items"] as? [[String: AnyObject]]) ?? []
                print(items)
                if let item = items.first {
                    completion(user: StackUser(userDict: item))
                } else {
                    completion(user: nil)
                }
                
            } catch {
                completion(user: nil)
            }
        }.resume()
    }
    
    
    
    func fetchReputation(var page: Int = 1, completion: ((repObjs: [[String: AnyObject]]) -> Void)) {
                
        let fromDate = Int(NSDate().dateBySubtractingDays(30).timeIntervalSince1970)
        let toDate = Int(NSDate().timeIntervalSince1970)
        
        let url = NSURL(string: "https://api.stackexchange.com/2.2/users/\(id)/reputation?page=\(page)&fromDate=\(fromDate)&toDate=\(toDate)&site=stackoverflow")!
        print(url)
        NSURLSession.sharedSession().dataTaskWithURL(url) { data, response, error in
            guard let data = data else {
                completion(repObjs: [[:]])
                return
            }

            do {
                let dict = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
                print(dict)
                let items = (dict["items"] as? [[String: AnyObject]]) ?? []
                completion(repObjs: items)
                
                let complete = (dict["has_more"] as? Int) ?? 0 == 0
                
                if !complete {
                    self.fetchReputation(page++, completion: completion)
                    print("hasMore")
                }
            } catch {
                completion(repObjs: [[:]])
            }
        }.resume()
    }
    
    func deleteAllObjects() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let fetchRequest = NSFetchRequest(entityName: "StackReputation")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try appDelegate.persistentStoreCoordinator.executeRequest(deleteRequest, withContext: appDelegate.managedObjectContext)
        } catch let error as NSError {
            print(error.localizedDescription)
            // TODO: handle the error
        }
    }
}

class StackDataImporter {
    var context: NSManagedObjectContext!
    var webService: StackWebService!
    
    init(context: NSManagedObjectContext, webService: StackWebService) {
        self.context = context
        self.webService = webService

    }
    
    func importUser() {
        webService.fetchUser() { user in
            guard let user = user else { return }
            print(user)
            
            let data = NSKeyedArchiver.archivedDataWithRootObject(user)
            NSUserDefaults.standardUserDefaults().setObject(data, forKey: "StackUser")
        }
    }
    
    func importReputation() {
        webService.fetchReputation { repObjs in
            print(repObjs)
            repObjs.forEach {
                print($0)
                let newRepObject = NSEntityDescription.insertNewObjectForEntityForName(StackReputation.entityName, inManagedObjectContext: self.context) as! StackReputation
                
                let timeInterval = ($0["on_date"] as? Int) ?? 0
                let change = ($0["reputation_change"] as? Int) ?? 0
                newRepObject.change = NSNumber(integer: change)
                newRepObject.date = NSDate(timeIntervalSince1970: NSTimeInterval(timeInterval))
            }
            let _ = try? self.context.save()
        }
    }
}

