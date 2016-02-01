//
//  StackAnswersDataSource.swift
//  Resume
//
//  Created by Ian MacCallum on 1/21/16.
//  Copyright © 2016 Ian MacCallum. All rights reserved.
//

import Foundation
import UIKit

class StackAnswersDataSource: NSObject {
  
}

extension StackAnswersDataSource: UICollectionViewDataSource {
  func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 15
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("StackAnswerCellID", forIndexPath: indexPath) as! StackAnswerCollectionViewCell
    cell.textLabel.text = "Cell \(indexPath.row)"
    return cell
  }
}