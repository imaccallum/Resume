//
//  SwapCollectionViewCell.swift
//  TinderNavDemo
//
//  Created by Ian MacCallum on 7/7/15.
//  Copyright © 2015 Ian MacCallum. All rights reserved.
//

import UIKit
import CoreData




class StackCollectionViewCell: UICollectionViewScrollCell {

  @IBOutlet weak var answersCollectionView: StackAnswersCollectionView!
  @IBOutlet weak var tagsCollectionView: StackTagsCollectionView!
  @IBOutlet weak var pageControl: UIPageControl!
  

  required init?(coder aDecoder: NSCoder) {
    
    super.init(coder: aDecoder)
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    answersCollectionView.backgroundColor = UIColor.whiteColor()
    tagsCollectionView.backgroundColor = UIColor.whiteColor()
    
    answersCollectionView.delegate = self
    
    backgroundColor = UIColor.stackTan()
  }
  

  override func layoutSubviews() {
    super.layoutSubviews()
    
    
    let count = Int(ceil(answersCollectionView.contentSize.width / answersCollectionView.frame.width))
    pageControl.numberOfPages = count
  }
  override func didScroll(withOffset offset: CGPoint) {
    _ = offset.y / frame.height
  }
  
}



extension StackCollectionViewCell: UICollectionViewDelegate {

  func scrollViewDidScroll(scrollView: UIScrollView) {
    let width = answersCollectionView.frame.width
    let page = round(answersCollectionView.contentOffset.x / width)
    pageControl.currentPage = Int(page)
  }
}