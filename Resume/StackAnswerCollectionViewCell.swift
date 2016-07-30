//
//  StackAnswerCollectionViewCell.swift
//  Resume
//
//  Created by Ian MacCallum on 1/19/16.
//  Copyright © 2016 Ian MacCallum. All rights reserved.
//

import Foundation
import UIKit

class StackAnswerCollectionViewCell: UICollectionViewCell {
  @IBOutlet weak var scoreLabel: UILabel!
  @IBOutlet weak var textLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    scoreLabel.numberOfLines = 3
  }
  
  func configure(answer: Answer) {
    let score = answer.score ?? 0
    let question = answer.question ?? ""
    
    scoreLabel.text = "\(score)"
    textLabel.text = question

    if answer.accepted?.boolValue == true {
      scoreLabel.backgroundColor = UIColor.stackBoxGreen()
      scoreLabel.textColor = UIColor.stackBoxYellow()
    } else {
      scoreLabel.backgroundColor = nil
      
      scoreLabel.textColor = UIColor.stackBoxText()
    }
  }
  
}