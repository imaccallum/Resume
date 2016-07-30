//
//  Profile+CoreDataProperties.swift
//  Resume
//
//  Created by Ian MacCallum on 2/2/16.
//  Copyright © 2016 Ian MacCallum. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Profile {
  
  @NSManaged var name: String?
  @NSManaged var user: String?
  @NSManaged var location: String?
  @NSManaged var id: NSNumber?
  @NSManaged var avatar: String?
  @NSManaged var followers: NSNumber?
  @NSManaged var following: NSNumber?
  @NSManaged var repoCount: NSNumber?
  
}
