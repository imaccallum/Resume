//
//  StackTagCollectionViewCell.swift
//  Resume
//
//  Created by Ian MacCallum on 1/21/16.
//  Copyright © 2016 Ian MacCallum. All rights reserved.
//

import Foundation
import UIKit

class StackTagCollectionViewCell: UICollectionViewCell {
  @IBOutlet weak var textLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    backgroundColor = UIColor.stackTagBlue()
    textLabel.textColor = UIColor.stackTagText()
  }
  
  func configure(tag: Tag) {
    let name = tag.name ?? ""
    let count = tag.count ?? 0
    
    textLabel.text = "\(count) x \(name)"
  }
  
  override func preferredLayoutAttributesFittingAttributes(layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
    let attr = layoutAttributes
    
    var newFrame = attr.frame
    frame = newFrame
    textLabel.sizeToFit()
    setNeedsLayout()
    layoutIfNeeded()
    
    let desiredHeight = contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height
    newFrame.size.height = desiredHeight
    attr.frame = newFrame
    return attr
  }
}