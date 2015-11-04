//
//  SwapCollectionViewCell.swift
//  TinderNavDemo
//
//  Created by Ian MacCallum on 7/7/15.
//  Copyright © 2015 Ian MacCallum. All rights reserved.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewScrollCell {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    override func didScroll(withOffset offset: CGPoint) {
        let percent = offset.y / frame.height
        print(percent)

    }
}