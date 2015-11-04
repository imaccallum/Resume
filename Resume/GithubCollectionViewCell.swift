//
//  SwapCollectionViewCell.swift
//  TinderNavDemo
//
//  Created by Ian MacCallum on 7/7/15.
//  Copyright © 2015 Ian MacCallum. All rights reserved.
//

import UIKit

class GithubCollectionViewCell: UICollectionViewScrollCell {
    
    @IBOutlet weak var githubBannerView: UIBannerView! {
        didSet {
            githubBannerView.fillColor = UIColor.whiteColor()
            githubBannerView.path = { frame in
                let offset: CGFloat = frame.width * sqrt(3.0) / 3.0
                let path = UIBezierPath()
                path.moveToPoint(CGPoint(x: 0, y: 0))
                path.addLineToPoint(CGPoint(x: 0, y: frame.height / 2))
                path.addLineToPoint(CGPoint(x: frame.width / 2, y: (frame.height + offset) / 2))
                path.addLineToPoint(CGPoint(x: frame.width, y: frame.height / 2))
                path.addLineToPoint(CGPoint(x: frame.width, y: 0))
                path.addLineToPoint(CGPoint(x: frame.width, y: -1 - self.frame.height / 2))
                path.addLineToPoint(CGPoint(x: 0, y: -1 - self.frame.height / 2))
                path.closePath()
                
                return path
            }
        }
    }

    @IBOutlet weak var githubGraphView: GithubGraphView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        clipsToBounds = false
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.bringSubviewToFront(menuButton)
        contentView.bringSubviewToFront(githubBannerView)

        menuButton.horizontalAlignment = .Right
        menuButton.verticalAlignment = .Top
    }
    
    
    override func didScroll(withOffset offset: CGPoint) {
        let percent = offset.y / frame.height
        githubBannerView.transform = CGAffineTransformMakeTranslation(0, percent * frame.height * parallaxMultiplier)

    }
}