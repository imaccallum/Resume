//
//  StackAnswerFlowLayout.swift
//  Resume
//
//  Created by Ian MacCallum on 1/19/16.
//  Copyright © 2016 Ian MacCallum. All rights reserved.
//

import Foundation
import UIKit

class StackScrollFlowLayout: UICollectionViewFlowLayout {
  private var attributes: [UICollectionViewLayoutAttributes] = []
  var rows: Int = 3 { didSet { invalidateLayout() } }

  init(rows: Int) {
    self.rows = rows
    super.init()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override func prepareLayout() {
    guard let collectionView = collectionView else { return }
    
    attributes = (0..<collectionView.numberOfSections()).flatMap { section -> [UICollectionViewLayoutAttributes] in
      return (0..<collectionView.numberOfItemsInSection(section)).flatMap { item -> UICollectionViewLayoutAttributes? in
        return self.layoutAttributesForItemAtIndexPath(NSIndexPath(forItem: item, inSection: section))
      }
    }
  }
  
  override func collectionViewContentSize() -> CGSize {
    guard let collectionView = collectionView else { return CGSizeZero }
    let section = collectionView.numberOfSections().predecessor()
    let width = offsetForSection(section) + widthForSection(section)
    let height = collectionView.frame.height
    
    return CGSize(width: width, height: height)
  }
  
  override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    return attributes.filter { $0.frame.intersects(rect) }
  }
  
  func offsetForSection(section: Int) -> CGFloat {
    return section == 0 ? 0 : widthForSection(section.predecessor()) + offsetForSection(section.predecessor())
  }
  
  func widthForSection(section: Int) -> CGFloat {
    guard let collectionView = collectionView else { return 0 }
    let width = collectionView.frame.width
    let count = collectionView.numberOfItemsInSection(section)
    let pages = ceil(CGFloat(count) / CGFloat(rows))
    return pages * width
  }
  
  override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
    guard let collectionView = collectionView else { return nil }
    
    let attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
    attributes.frame = self.collectionView(collectionView, frameForItemAtIndexPath: indexPath)
    
    return attributes
  }
  
  func collectionView(collectionView: UICollectionView, frameForItemAtIndexPath indexPath: NSIndexPath) -> CGRect {
    let w = collectionView.frame.width
    let h = collectionView.frame.height / CGFloat(rows)
    
    let page = floor(CGFloat(indexPath.row) / CGFloat(rows))
    let indexOnPage = indexPath.row % rows
    
    let x = offsetForSection(indexPath.section) + CGFloat(page) * w
    let y = CGFloat(indexOnPage) * h
    
    return CGRect(x: x, y: y, width: w, height: h)
  }
}