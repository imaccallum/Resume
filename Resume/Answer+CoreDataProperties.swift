//
//  Answer+CoreDataProperties.swift
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

extension Answer {

    @NSManaged var questionID: NSNumber?
    @NSManaged var question: String?
    @NSManaged var id: NSNumber?
    @NSManaged var link: String?
    @NSManaged var accepted: NSNumber?
    @NSManaged var score: NSNumber?

}
