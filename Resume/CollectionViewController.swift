//
//  ViewController.swift
//  Resume
//
//  Created by Ian MacCallum on 8/4/15.
//  Copyright © 2015 Ian MacCallum. All rights reserved.
//

import Foundation
import UIKit




class CollectionViewController: UICollectionViewController {
  let pages = ["Home", "Bio", "Education", "Apps", "Stack", "Github", "Contact"]
  var menu: Menu!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Set Properties
    collectionView?.alwaysBounceVertical = true
    collectionView?.pagingEnabled = true
    
    // Setup Layout
    let layout = UICollectionViewFlowLayout()
    layout.minimumInteritemSpacing = 0
    layout.minimumLineSpacing = 0
    layout.sectionInset = UIEdgeInsetsZero
    collectionView?.setCollectionViewLayout(layout, animated: false)
    
    // Register Cells
    pages.forEach {
      collectionView?.registerNib(UINib(nibName: "\($0)CollectionViewCell", bundle: NSBundle.mainBundle()), forCellWithReuseIdentifier: "\($0)CellID")
    }
    
    // Setup Menu
    menu = Menu(dataSource: self)
    menu.delegate = self
    
    // Setup Gestures
    let leftSwipe = UISwipeGestureRecognizer(target: self, action: "handleLeftSwipe:")
    let rightSwipe = UISwipeGestureRecognizer(target: self, action: "handleRightSwipe:")
    leftSwipe.direction = .Left
    rightSwipe.direction = .Right
    collectionView?.addGestureRecognizer(leftSwipe)
    collectionView?.addGestureRecognizer(rightSwipe)
  }
  
  func handleLeftSwipe(sender: UISwipeGestureRecognizer) {
    menu.showIndicator(true)
  }
  
  func handleRightSwipe(sender: UISwipeGestureRecognizer) {
    menu.hideIndicator(true)
  }
  
  override func prefersStatusBarHidden() -> Bool {
    return true
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    menu.handleScroll(collectionView)
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    // Align Cells
    collectionView?.indexPathsForVisibleItems().sort(>).forEach {
      if let cell = collectionView?.cellForItemAtIndexPath($0) as? UICollectionViewScrollCell {
        collectionView?.bringSubviewToFront(cell)
      }
    }
  }
  
  override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
    super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
    
    
    guard let collectionView = collectionView else { return }
    
    let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
    flowLayout?.invalidateLayout()
  }
}

// MARK - UICollectionViewDelegateFlowLayout
extension CollectionViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    return collectionView.frame.size
  }
}


// MARK - CollectionView Data Source
extension CollectionViewController {
  override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return pages.count
  }
  
  override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewScrollCell {
    
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("\(pages[indexPath.row])CellID", forIndexPath: indexPath) as! UICollectionViewScrollCell
    cell.clipsToBounds = true
    cell.layoutIfNeeded()
    return cell
  }
}


// MARK - ScrollView Delegate
extension CollectionViewController {
  override func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
    
    if let cell = cell as? UICollectionViewScrollCell {
      cell.didEndDisplay()
    }
  }
  
  override func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
    if let cell = cell as? UICollectionViewScrollCell {
      cell.willBeginDisplay()
    }
  }
  
  override func scrollViewDidScroll(scrollView: UIScrollView) {
    menu.handleScroll(scrollView)
    
    collectionView?.visibleCells().flatMap { $0 as? UICollectionViewScrollCell }.forEach {
      $0.didScroll(withOffset: scrollView.convertPoint($0.frame.origin, toView: scrollView.superview))
    }
  }
}


// MARK - Menu Data Source
extension CollectionViewController: MenuDataSource {
  func presentingViewForMenu(menu: Menu) -> UIView {
    return view
  }
  
  func numberOfItemsInMenu(menu: Menu) -> Int {
    return pages.count
  }
  
  func menu(menu: Menu, nodeForItemAtIndex index: Int) -> MenuNode {
    let name = ["Hello", "About", "Hamburger", "Map", "Settings", "Hamburger", "Map"][index]
    return MenuNode(title: "Index \(index)", imageName: name)
  }
}


// MARK - Menu Delegate
extension CollectionViewController: MenuDelegate {
  func menu(menu: Menu, didDismissWithIndex index: Int) {
    
  }
  
  func menu(menu: Menu, didUpdateWithPercent percent: CGFloat) {
    guard let contentHeight = collectionView?.contentSize.height, height = collectionView?.frame.height else { return }
    collectionView?.contentOffset.y = percent * (contentHeight - height)
  }
  
  func menu(menu: Menu, shouldSnapToItemIndex index: Int) {
    collectionView?.scrollToItemAtIndexPath(NSIndexPath(forItem: index, inSection: 0), atScrollPosition: .Top, animated: true)
  }
}