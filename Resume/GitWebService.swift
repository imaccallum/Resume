//
//  GitWebService.swift
//  Resume
//
//  Created by Ian MacCallum on 2/2/16.
//  Copyright © 2016 Ian MacCallum. All rights reserved.
//

import Foundation
import UIKit
import CoreData

struct GitProfile {
  
  var user: String?
  var name: String?
  var location: String?
  var id: Int?
  
  var followers: Int?
  var following: Int?
  var repoCount: Int?
  var avatar: String?
  
  init(dict: [String: AnyObject]) {
    
    user = dict["login"] as? String
    name = dict["name"] as? String
    id = dict["id"] as? Int
    location = dict["location"] as? String
    avatar = dict["avatar_url"] as? String
    
    followers = dict["followers"] as? Int
    following = dict["following"] as? Int
    repoCount = dict["public_repos"] as? Int
  }
}

struct GitRepo {
  var id: Int?
  var title: String?
  var link: String?
  var stars: Int?
  
  init(dict: [String: AnyObject]) {
    id = dict["id"] as? Int
    stars = dict["stargazers_count"] as? Int
    title = dict["name"] as? String
    link = dict["url"] as? String
  }
}

struct Git {
  static var context: NSManagedObjectContext {
    return (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
  }
}

extension Git {
  
  static func fetchProfile(completion: GitProfile -> ()) {
    let url = NSURL(string: "https://api.github.com/users/imaccallum")!
    
    NSURLSession.sharedSession().dataTaskWithURL(url) { data, response, error in
      guard let data = data, dict = try? NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as? NSDictionary, user = dict as? [String: AnyObject] else { return }
      completion(GitProfile(dict: user))
    }.resume()
  }
  
  static func fetchRepos(completion: [GitRepo] -> ()) {
    let url = NSURL(string: "https://api.github.com/users/imaccallum/repos")!

    NSURLSession.sharedSession().dataTaskWithURL(url) { data, response, error in
      guard let data = data, array = try? NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as? NSArray, items = array as? [[String: AnyObject]] else { return }
      let repos = items.map { GitRepo(dict: $0) }
      completion(repos)
    }.resume()
  }
}

// MARK: - Profile Core Data
extension Git {
  // Create
  static func createProfile(profile: GitProfile) {
    let newProfile = NSEntityDescription.insertNewObjectForEntityForName("Profile", inManagedObjectContext: context) as? Profile
    newProfile?.id = profile.id
    newProfile?.user = profile.user
    newProfile?.name = profile.name
    newProfile?.location = profile.location
    newProfile?.avatar = profile.avatar
    
    newProfile?.followers = profile.followers
    newProfile?.following = profile.following
    newProfile?.repoCount = profile.repoCount
  }
  
  // Read
  static func fetchProfile(id: Int) -> Profile? {
    
    let fetchRequest = NSFetchRequest(entityName: "Profile")
    fetchRequest.predicate = NSPredicate(format: "id = %@", "\(id)")
    fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: false)]
    fetchRequest.fetchLimit = 1
    do {
      return try context.executeFetchRequest(fetchRequest).first as? Profile
    } catch {
      return nil
    }
  }
  
  // Update
  static func updateProfile(profile: GitProfile) {
    guard let id = profile.id else { return }
    
    if let existingProfile = fetchProfile(id) {
      existingProfile.user = profile.user
      existingProfile.name = profile.name
      existingProfile.location = profile.location
      existingProfile.avatar = profile.avatar
      
      existingProfile.followers = profile.followers
      existingProfile.following = profile.following
      existingProfile.repoCount = profile.repoCount
      
    } else {
      createProfile(profile)
    }
  }
  
  // Delete
  static func deleteProfile(id: Int) {
    if let profile = fetchProfile(id) {
      context.deleteObject(profile)
    }
  }
}


// MARK: - Repo Core Data
extension Git {
  // Create
  static func createRepo(repo: GitRepo) {
    let newRepo = NSEntityDescription.insertNewObjectForEntityForName("Repo", inManagedObjectContext: context) as? Repo
    newRepo?.id = repo.id
    newRepo?.title = repo.title
    newRepo?.link = repo.link
    newRepo?.stars = repo.stars
  }
  
  // Read
  static func fetchRepo(id: Int) -> Repo? {
    
    let fetchRequest = NSFetchRequest(entityName: "Repo")
    fetchRequest.predicate = NSPredicate(format: "id = %@", "\(id)")
    fetchRequest.sortDescriptors = [NSSortDescriptor(key: "stars", ascending: false)]
    fetchRequest.fetchLimit = 1
    do {
      return try context.executeFetchRequest(fetchRequest).first as? Repo
    } catch {
      return nil
    }
  }
  
  // Update
  static func updateRepo(repo: GitRepo) {
    guard let id = repo.id else { return }
    
    if let existingRepo = fetchRepo(id) {
      existingRepo.title = repo.title
      existingRepo.link = repo.link
      existingRepo.stars = repo.stars
    } else {
      createRepo(repo)
    }
  }
  
  // Delete
  static func deleteRepo(id: Int) {
    if let repo = fetchRepo(id) {
      context.deleteObject(repo)
    }
  }
}