//
//  UICollectionViewScrollCell.swift
//  Resume
//
//  Created by Ian MacCallum on 8/4/15.
//  Copyright © 2015 Ian MacCallum. All rights reserved.
//

import UIKit


protocol CollectionViewCellScrollDelegate {
    func didScroll(withOffset offset: CGPoint)
}

class UICollectionViewScrollCell: UICollectionViewCell {
    @IBOutlet weak var menuButton: UIMenuButton!
    
    var parallaxMultiplier: CGFloat = 0.5
    
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
        bringSubviewToFront(menuButton)
    }
}

extension UICollectionViewScrollCell: CollectionViewCellScrollDelegate {
    func didScroll(withOffset offset: CGPoint) {
        
    }
}