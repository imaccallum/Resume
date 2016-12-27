//
//  StackWebService.swift
//  Resume
//
//  Created by Ian MacCallum on 2/1/16.
//  Copyright © 2016 Ian MacCallum. All rights reserved.
//

import Foundation
import CoreData
import UIKit

struct StackAnswer {
  var id: Int?
  var score: Int?
  var question: String?
  var link: String?
  var accepted: Bool?
  
  init(dict: [String: AnyObject]) {
    id = dict["answer_id"] as? Int
    score = dict["score"] as? Int
    question = dict["title"] as? String
    link = dict["link"] as? String
    accepted = dict["is_accepted"] as? Bool
  }
}

struct StackTag {
  var count: Int?
  var name: String?
}

struct StackUser {
  var badges: (bronze: Int?, silver: Int?, gold: Int?)?
  
  var name: String?
  var location: String?
  var rep: Int?
  var age: Int?
  var id: Int?
  
  var answerCount: Int?
  var upVoteCount: Int?
  var viewCount: Int?
  
  init(dict: [String: AnyObject]) {
    let badgesDict = dict["badge_counts"] as? [String: Int]
    let bronze = badgesDict?["bronze"]
    let silver = badgesDict?["silver"]
    let gold = badgesDict?["gold"]
    badges = (bronze, silver, gold)
    
    name = dict["display_name"] as? String
    location = dict["location"] as? String
    rep = dict["reputation"] as? Int
    age = dict["age"] as? Int
    id = dict["user_id"] as? Int
    
    answerCount = dict["answer_count"] as? Int
    upVoteCount = dict["up_vote_count"] as? Int
    viewCount = dict["view_count"] as? Int
  }
}

struct Stack {
  static var context: NSManagedObjectContext {
    return (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
  }
}

// MARK: - Web Service
extension Stack {
  
  private static func fetchStackRequest(url: URL, completion: @escaping ([[String: AnyObject]]) -> ()) {
    URLSession.shared.dataTask(with: url as URL) { data, response, error in
      
      guard let data = data, let dict = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary, let items = dict?["items"] as? [[String: AnyObject]] else { return }
      completion(items)
      }.resume()
  }
  
  static func fetchAnswers(completion: @escaping ([StackAnswer]) -> ()) {
    
    let url = URL(string: "https://api.stackexchange.com/2.2/users/3810673/answers?order=desc&sort=votes&site=stackoverflow&filter=!)s))yOCYWlGW-j97TO1h")!
    
    fetchStackRequest(url: url) { items in
      let answers = items.map { StackAnswer(dict: $0) }
      completion(answers )
    }
  }
    
  static func fetchTags(completion: ([StackTag]) -> ()) {
    let url = URL(string: "https://api.stackexchange.com/2.2/users/3810673/tags?order=desc&min=10&sort=popular&site=stackoverflow&filter=!-.G.68phH_FJ")!
    fetchStackRequest(url) { items in
      let tags = items.map { StackTag(count: $0["count"] as? Int, name: $0["name"] as? String) }
      completion(tags)
    }
  }
  
  static func fetchUser(completion: StackUser -> ()) {
    let url = URL(string: "https://api.stackexchange.com/2.2/users/3810673?order=desc&sort=reputation&site=stackoverflow&filter=!-*f(6q9Y*e_4")!
    fetchStackRequest(url) { items in
      guard let user = items.first else { return }
      completion(StackUser(dict: user))
    }
  }
  
}

// MARK: - Tags Core Data
extension Stack {
  // Create
  static func createTag(name: String, count: Int) {
    let newTag = NSEntityDescription.insertNewObjectForEntityForName("Tag", inManagedObjectContext: context) as? Tag
    newTag?.name = name
    newTag?.count = count
  }
  
  // Read
  static func fetchStackTag(name: String) -> Tag? {
    
    let fetchRequest = NSFetchRequest(entityName: "Tag")
    fetchRequest.predicate = NSPredicate(format: "name = %@", name)
    fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
    fetchRequest.fetchLimit = 1
    do {
      return try context.executeFetchRequest(fetchRequest).first as? Tag
    } catch {
      return nil
    }
  }
  
  // Update
  static func updateTag(name: String?, count: Int?) {
    guard let name = name, count = count else { return }
    if let tag = fetchStackTag(name) {
      tag.count = count
    } else {
      createTag(name, count: count)
    }
  }
  
  // Delete
  static func deleteTag(name: String) {
    if let tag = fetchStackTag(name) {
      context.deleteObject(tag)
    }
  }
}

// MARK: - Answer Core Data
extension Stack {
  // Create
  static func createAnswer(answer: StackAnswer) {
    let newAnswer = NSEntityDescription.insertNewObjectForEntityForName("Answer", inManagedObjectContext: context) as? Answer
    newAnswer?.id = answer.id
    newAnswer?.question = answer.question
    newAnswer?.score = answer.score
    newAnswer?.link = answer.link
    newAnswer?.accepted = answer.accepted
    
  }
  
  // Read
  static func fetchAnswer(id: Int) -> Answer? {
    
    let fetchRequest = NSFetchRequest(entityName: "Answer")
    fetchRequest.predicate = NSPredicate(format: "id = %@", "\(id)")
    fetchRequest.sortDescriptors = [NSSortDescriptor(key: "score", ascending: false)]
    fetchRequest.fetchLimit = 1
    do {
      return try context.executeFetchRequest(fetchRequest).first as? Answer
    } catch {
      return nil
    }
  }

  // Update
  static func updateAnswer(answer: StackAnswer) {
    guard let id = answer.id else { return }

    if let existingAnswer = fetchAnswer(id) {
      existingAnswer.question = answer.question
      existingAnswer.score = answer.score
      existingAnswer.link = answer.link
      existingAnswer.accepted = answer.accepted
    } else {
      createAnswer(answer)
    }
  }
  
  // Delete
  static func deleteAnswer(answerID id: Int) {
    if let answer = fetchAnswer(id) {
      context.deleteObject(answer)
    }
  }
}

// MARK: - Answer Core Data
extension Stack {
  // Create
  static func createUser(user: StackUser) {
    let newUser = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: context) as? User
    newUser?.id = user.id
    newUser?.name = user.name
    newUser?.location = user.location
    newUser?.age = user.age
    newUser?.reputation = user.rep
    
    newUser?.upVoteCount = user.upVoteCount
    newUser?.answerCount = user.answerCount
    newUser?.viewCount = user.viewCount
    
    newUser?.bronze = user.badges?.bronze
    newUser?.silver = user.badges?.silver
    newUser?.gold = user.badges?.gold
    
  }
  
  // Read
  static func fetchUser(id: Int) -> User? {
    
    let fetchRequest = NSFetchRequest(entityName: "User")
    fetchRequest.predicate = NSPredicate(format: "id = %@", "\(id)")
    fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: false)]
    fetchRequest.fetchLimit = 1
    do {
      return try context.executeFetchRequest(fetchRequest).first as? User
    } catch {
      return nil
    }
  }
  
  // Update
  static func updateUser(user: StackUser) {
    guard let id = user.id else { return }
    
    if let existingUser = fetchUser(id) {
      existingUser.name = user.name
      existingUser.location = user.location
      existingUser.age = user.age
      existingUser.reputation = user.rep
      
      existingUser.upVoteCount = user.upVoteCount
      existingUser.answerCount = user.answerCount
      existingUser.viewCount = user.viewCount
      
      existingUser.bronze = user.badges?.bronze
      existingUser.silver = user.badges?.silver
      existingUser.gold = user.badges?.gold
      
    } else {
      createUser(user)
    }
  }
  
  // Delete
  static func deleteUser(id: Int) {
    if let user = fetchUser(id) {
      context.deleteObject(user)
    }
  }
}
