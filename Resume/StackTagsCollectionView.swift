//
//  StackTagsCollectionView.swift
//  Resume
//
//  Created by Ian MacCallum on 2/1/16.
//  Copyright © 2016 Ian MacCallum. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class StackTagsCollectionView: UICollectionView {
  let fetchedResultsController: NSFetchedResultsController
  
  required init?(coder aDecoder: NSCoder) {
    let fetchRequest = NSFetchRequest(entityName: "Tag")
    fetchRequest.predicate = NSPredicate(value: true)
    fetchRequest.sortDescriptors = [NSSortDescriptor(key: "count", ascending: false)]
    fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: Stack.context, sectionNameKeyPath: nil, cacheName: nil)
    super.init(coder: aDecoder)
    
    let tagCell = UINib(nibName: "StackTagCollectionViewCell", bundle: nil)
    registerNib(tagCell, forCellWithReuseIdentifier: "StackTagCellID")
    
    
    // Data sources and delegation
    fetchedResultsController.delegate = self
    dataSource = self

    
    // Layout
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .Horizontal
    layout.estimatedItemSize = CGSize(width: 50, height: 32)
    layout.minimumLineSpacing = 8
    layout.minimumInteritemSpacing = 8
    contentInset.left = 8
    contentInset.right = 8
    setCollectionViewLayout(layout, animated: false)
    
    do {
      try fetchedResultsController.performFetch()
    } catch {}
  }
  
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
  }
}


extension StackTagsCollectionView: UICollectionViewDataSource {
  func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return fetchedResultsController.sections?.count ?? 0
  }
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return fetchedResultsController.sections?[section].numberOfObjects ?? 0
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("StackTagCellID", forIndexPath: indexPath) as! StackTagCollectionViewCell
    let tag = fetchedResultsController.objectAtIndexPath(indexPath) as! Tag

    cell.configure(tag)
    return cell
  }
}

extension StackTagsCollectionView: NSFetchedResultsControllerDelegate {
  
  //MARK: NSFetchedResultsController Delegate Functions
  func controllerWillChangeContent(controller: NSFetchedResultsController) {}
  
  func controllerDidChangeContent(controller: NSFetchedResultsController) {}
  
  func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
    switch type {
    case .Insert:
      insertItemsAtIndexPaths([newIndexPath!])
    case .Delete:
      deleteItemsAtIndexPaths([indexPath!])
    case .Move:
      moveItemAtIndexPath(indexPath!, toIndexPath: newIndexPath!)
    case .Update:
      reloadItemsAtIndexPaths([indexPath!])
    }
  }
}