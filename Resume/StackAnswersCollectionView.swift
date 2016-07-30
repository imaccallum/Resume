//
//  StackAnswersCollectionView.swift
//  Resume
//
//  Created by Ian MacCallum on 2/1/16.
//  Copyright © 2016 Ian MacCallum. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class StackAnswersCollectionView: UICollectionView {
  let fetchedResultsController: NSFetchedResultsController
  
  required init?(coder aDecoder: NSCoder) {
    let fetchRequest = NSFetchRequest(entityName: "Answer")
    let p1 = NSPredicate(format: "score != nil")
    let p2 = NSPredicate(format: "question != nil")
    let p3 = NSPredicate(format: "accepted != nil")
    let p4 = NSPredicate(format: "link != nil")
    
    fetchRequest.predicate = NSCompoundPredicate(type: .AndPredicateType, subpredicates: [p1, p2, p3, p4])
    fetchRequest.sortDescriptors = [NSSortDescriptor(key: "score", ascending: false)]
    fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: Stack.context, sectionNameKeyPath: nil, cacheName: nil)
    
    super.init(coder: aDecoder)
    
    let answerCell = UINib(nibName: "StackAnswerCollectionViewCell", bundle: nil)
    registerNib(answerCell, forCellWithReuseIdentifier: "StackAnswerCellID")
    
    
    // Data sources and delegation
    fetchedResultsController.delegate = self
    dataSource = self
    
    do {
      try fetchedResultsController.performFetch()
    } catch {}
  }
}


extension StackAnswersCollectionView: UICollectionViewDataSource {
  func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return fetchedResultsController.sections?.count ?? 0
  }
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return fetchedResultsController.sections?[section].numberOfObjects ?? 0
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("StackAnswerCellID", forIndexPath: indexPath) as! StackAnswerCollectionViewCell
    let answer = fetchedResultsController.objectAtIndexPath(indexPath) as! Answer

    
    cell.configure(answer)
    return cell
  }
  
}

extension StackAnswersCollectionView: NSFetchedResultsControllerDelegate {
  
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