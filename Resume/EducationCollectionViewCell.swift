//
//  SwapCollectionViewCell.swift
//  TinderNavDemo
//
//  Created by Ian MacCallum on 7/7/15.
//  Copyright © 2015 Ian MacCallum. All rights reserved.
//

import UIKit

class EducationCollectionViewCell: UICollectionViewScrollCell {
    
    @IBOutlet weak var head: UIImageView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    override func didScroll(withOffset offset: CGPoint) {
        let percent = offset.y / frame.height
        print(percent)
    }
}