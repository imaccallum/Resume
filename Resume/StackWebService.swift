//
//  StackWebService.swift
//  Resume
//
//  Created by Ian MacCallum on 2/1/16.
//  Copyright © 2016 Ian MacCallum. All rights reserved.
//

import Foundation

struct StackAnswer {
  var questionID: Int?
  var answerID: Int?
  var score: Int?
  var link: String?
  var accepted: Bool?
  
  init(dict: [String: AnyObject]) {
    questionID = dict["question_id"] as? Int
    answerID = dict["answer_id"] as? Int
    score = dict["score"] as? Int
    link = dict["link"] as? String
    accepted = dict["is_accepted"] as? Bool
  }
}

struct StackQuestion {
  var questionID: Int?
  var title: String?
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
  
  private static func fetchStackRequest(url: NSURL, completion: ([[String: AnyObject]]) -> ()) {
    NSURLSession.sharedSession().dataTaskWithURL(url) { data, response, error in
      
      guard let data = data, dict = try? NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as? NSDictionary, items = dict?["items"] as? [[String: AnyObject]] else { return }
      completion(items)
      }.resume()
  }
  
  static func fetchAnswers(completion: [StackAnswer] -> ()) {
    
    let url = NSURL(string: "https://api.stackexchange.com/2.2/users/3810673/answers?order=desc&min=4&sort=votes&site=stackoverflow&filter=!)Q29lpdRHRphI-GyXE95Nizd")!
    
    fetchStackRequest(url) { items in
      let answers = items.map { StackAnswer(dict: $0) }
      completion(answers ?? [])
    }
  }
  
  static func fetchQuestionTitles(ids: [Int], completion: [StackQuestion] -> ()) {
    
    let str = ids.map({ "\($0)" }).joinWithSeparator(";")
    let url = NSURL(string: "https://api.stackexchange.com/2.2/questions/\(str)?order=desc&sort=activity&site=stackoverflow&filter=!Su916jc4Kl_vGwFogo")!
    
    fetchStackRequest(url) { items in
      let questions = items.map {
        StackQuestion(questionID: $0["question_id"] as? Int, title: $0["title"] as? String)
      }
      
      completion(questions ?? [])
    }
  }
  
  static func fetchTags(completion: [StackTag] -> ()) {
    let url = NSURL(string: "https://api.stackexchange.com/2.2/users/3810673/tags?order=desc&min=10&sort=popular&site=stackoverflow&filter=!-.G.68phH_FJ")!
    fetchStackRequest(url) { items in
      let tags = items.map { StackTag(count: $0["count"] as? Int, name: $0["name"] as? String) }
      completion(tags)
    }
  }
  
  static func fetchUser(id: Int, completion: StackUser -> ()) {
    let url = NSURL(string: "https://api.stackexchange.com/2.2/users/\(id)?order=desc&sort=reputation&site=stackoverflow&filter=!-*f(6q9Y*e_4")!
    fetchStackRequest(url) { items in
      guard let user = items.first else { return }
      completion(StackUser(dict: user))
    }
  }
  
}