//
//  SwapCollectionViewCell.swift
//  TinderNavDemo
//
//  Created by Ian MacCallum on 7/7/15.
//  Copyright © 2015 Ian MacCallum. All rights reserved.
//

import UIKit


class AppsCollectionViewCell: UICollectionViewScrollCell {

    override func didScroll(withOffset offset: CGPoint) {
        _ = offset.y / frame.height
    }

    
}
