//
//  SwapCollectionViewCell.swift
//  TinderNavDemo
//
//  Created by Ian MacCallum on 7/7/15.
//  Copyright © 2015 Ian MacCallum. All rights reserved.
//

import UIKit

class AppsCollectionViewCell: UICollectionViewScrollCell {
    
    @IBOutlet weak var topBannerView: UIBannerView!
    @IBOutlet weak var bottomBannerView: UIBannerView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        clipsToBounds = false
        backgroundColor = UIColor.grayColor()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.bringSubviewToFront(topBannerView)
        contentView.bringSubviewToFront(bottomBannerView)
        
        menuButton.horizontalAlignment = .Right
        menuButton.verticalAlignment = .Top
        
        topBannerView.fillColor = UIColor.whiteColor()
        topBannerView.path = { frame in
            let offset: CGFloat = frame.width * sqrt(3.0) / 3.0
            let path = UIBezierPath()
            path.moveToPoint(CGPoint(x: 0, y: 0))
            path.addLineToPoint(CGPoint(x: 0, y: offset))
            path.addLineToPoint(CGPoint(x: frame.width, y: 0))
            path.addLineToPoint(CGPoint(x: frame.width, y: -1 - self.frame.height / 4))
            path.addLineToPoint(CGPoint(x: 0, y: -1 - self.frame.height / 4))
            path.closePath()
            
            return path
        }
        
        bottomBannerView.fillColor = UIColor.whiteColor()
        bottomBannerView.path = { frame in
            let offset: CGFloat = frame.width * sqrt(3.0) / 3.0
            let path = UIBezierPath()
            path.moveToPoint(CGPoint(x: 0, y: frame.height))
            path.addLineToPoint(CGPoint(x: frame.width, y: frame.height - offset))
            path.addLineToPoint(CGPoint(x: frame.width, y: frame.height))
            path.addLineToPoint(CGPoint(x: frame.width, y: frame.height + self.frame.height / 2))
            path.addLineToPoint(CGPoint(x: 0, y: frame.height + self.frame.height / 2))
            path.closePath()
            
            return path
        }


    }
    
    
    override func didScroll(withOffset offset: CGPoint) {
        let percent = offset.y / frame.height
        
        topBannerView.transform = CGAffineTransformMakeTranslation(0, percent * frame.height * parallaxMultiplier)
        bottomBannerView.transform = CGAffineTransformMakeTranslation(0, percent * frame.height * parallaxMultiplier)

    }
}