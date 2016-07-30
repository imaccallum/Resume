//
//  User+CoreDataProperties.swift
//  Resume
//
//  Created by Ian MacCallum on 2/1/16.
//  Copyright © 2016 Ian MacCallum. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension User {

    @NSManaged var id: NSNumber?
    @NSManaged var name: String?
    @NSManaged var location: String?
    @NSManaged var reputation: NSNumber?
    @NSManaged var age: NSNumber?
    @NSManaged var answerCount: NSNumber?
    @NSManaged var upVoteCount: NSNumber?
    @NSManaged var viewCount: NSNumber?
    @NSManaged var bronze: NSNumber?
    @NSManaged var silver: NSNumber?
    @NSManaged var gold: NSNumber?

}
