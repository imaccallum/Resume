//
//  StackTagsDataSource.swift
//  Resume
//
//  Created by Ian MacCallum on 1/21/16.
//  Copyright © 2016 Ian MacCallum. All rights reserved.
//

import Foundation
import UIKit

class StackTagsDataSource: NSObject {
  
}

extension StackTagsDataSource: UICollectionViewDataSource {
  func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 15
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("StackTagCellID", forIndexPath: indexPath) as! StackTagCollectionViewCell
    cell.textLabel.text = "Cell \(indexPath.row)"
    return cell
  }
}