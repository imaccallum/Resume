//
//  SwapCollectionViewCell.swift
//  TinderNavDemo
//
//  Created by Ian MacCallum on 7/7/15.
//  Copyright © 2015 Ian MacCallum. All rights reserved.
//

import UIKit

class StackCollectionViewCell: UICollectionViewScrollCell {
  let answersDataSource = StackAnswersDataSource()
  let tagsDataSource = StackTagsDataSource()

  @IBOutlet weak var answersCollectionView: UICollectionView! {
    didSet {
      let answerCell = UINib(nibName: "StackAnswerCollectionViewCell", bundle: nil)
      answersCollectionView.registerNib(answerCell, forCellWithReuseIdentifier: "StackAnswerCellID")
      answersCollectionView.dataSource = answersDataSource
      answersCollectionView.delegate = self
    }
  }
  
  @IBOutlet weak var tagsCollectionView: UICollectionView! {
    didSet {
      let tagCell = UINib(nibName: "StackTagCollectionViewCell", bundle: nil)
      tagsCollectionView.registerNib(tagCell, forCellWithReuseIdentifier: "StackTagCellID")
      tagsCollectionView.dataSource = tagsDataSource
    }
  }
  @IBOutlet weak var pageControl: UIPageControl!
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    answersCollectionView.backgroundColor = UIColor.whiteColor()
    tagsCollectionView.backgroundColor = UIColor.whiteColor()
    
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
