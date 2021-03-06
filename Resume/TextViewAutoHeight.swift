//
//  TextViewAutoHeight.swift
//  Resume
//
//  Created by Ian MacCallum on 1/21/16.
//  Copyright © 2016 Ian MacCallum. All rights reserved.
//

import Foundation
import UIKit

class TextViewAutoHeight: UITextView {
  
  //MARK: attributes
  
  var  maxHeight:CGFloat?
  var  heightConstraint:NSLayoutConstraint?
  
  //MARK: initialize
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setUpInit()
  }

  override init(frame: CGRect, textContainer: NSTextContainer?) {
    super.init(frame: frame, textContainer: textContainer)
    setUpInit()
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setUpInit()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    setUpConstraint()
  }
  
  //MARK: private
  
  private func setUpInit() {
    for constraint in self.constraints {
      if constraint.firstAttribute == NSLayoutAttribute.Height {
        self.heightConstraint = constraint
        break;
      }
    }
    
  }
  
  private func setUpConstraint() {
    var finalContentSize:CGSize = self.contentSize
    finalContentSize.width  += (self.textContainerInset.left + self.textContainerInset.right ) / 2.0
    finalContentSize.height += (self.textContainerInset.top  + self.textContainerInset.bottom) / 2.0
    
    fixTextViewHeigth(finalContentSize)
  }
  
  private func fixTextViewHeigth(finalContentSize:CGSize) {
    if let maxHeight = self.maxHeight {
      var  customContentSize = finalContentSize;
      
      customContentSize.height = min(customContentSize.height, CGFloat(maxHeight))
      
      self.heightConstraint?.constant = customContentSize.height;
      
      if finalContentSize.height <= CGRectGetHeight(self.frame) {
        let textViewHeight = (CGRectGetHeight(self.frame) - self.contentSize.height * self.zoomScale)/2.0
        
        self.contentOffset = CGPointMake(0, -(textViewHeight < 0.0 ? 0.0 : textViewHeight))
        
      }
    }
  }
}