//
//  UICollectionViewScrollCell.swift
//  Resume
//
//  Created by Ian MacCallum on 8/4/15.
//  Copyright © 2015 Ian MacCallum. All rights reserved.
//

import UIKit


protocol CollectionViewCellScrollDelegate {
  func didScroll(withOffset offset: CGPoint)
  func didEndDisplay()
  func willBeginDisplay()
}

class UICollectionViewScrollCell: UICollectionViewCell {
  var parallaxMultiplier: CGFloat = 0.5
}

extension UICollectionViewScrollCell: CollectionViewCellScrollDelegate {
  func didScroll(withOffset offset: CGPoint) {}
  func didEndDisplay() {}
  func willBeginDisplay() {}
}