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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        collectionView?.backgroundColor = UIColor.whiteColor()
        collectionView?.alwaysBounceVertical = true
        collectionView?.pagingEnabled = true
        
        pages.forEach {
            collectionView?.registerNib(UINib(nibName: "\($0)CollectionViewCell", bundle: NSBundle.mainBundle()), forCellWithReuseIdentifier: "\($0)CellID")
        }
    }

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        for index in collectionView?.indexPathsForVisibleItems().sort(>) ?? [] {
            if let cell = collectionView?.cellForItemAtIndexPath(index) as? UICollectionViewScrollCell {
                collectionView?.bringSubviewToFront(cell)
            }
        }
    }
}


// MARK - CollectionView Data Source
extension CollectionViewController {
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewScrollCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("\(pages[indexPath.row])CellID", forIndexPath: indexPath) as! UICollectionViewScrollCell
        
        cell.menuButton.delegate = self
        cell.menuButton.tag = indexPath.row
        
        return cell
    }
}

extension CollectionViewController: MenuButtonDelegate {
    func didSelectMenuButton(menuButton: UIMenuButton, atIndex index: Int) {
        performSegueWithIdentifier("MenuSegue", sender: menuButton)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "MenuSegue" {
            let dvc = segue.destinationViewController as! MenuViewController
            let button = sender as? UIMenuButton
            
            dvc.selectedIndex = button?.tag
            dvc.frame = button?.frame
        }
    }
}



// MARK - CollectionView Delegate Flow Layout
extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsZero
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSizeZero
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSizeZero
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return view.frame.size
    }
}

// MARK - ScrollView Delegate
extension CollectionViewController {
    override func scrollViewDidScroll(scrollView: UIScrollView) {

        collectionView?.visibleCells().flatMap {$0 as? UICollectionViewScrollCell }.forEach {
            $0.didScroll(withOffset: scrollView.convertPoint($0.frame.origin, toView: scrollView.superview))
        }
    }
}