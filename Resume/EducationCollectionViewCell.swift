//
//  SwapCollectionViewCell.swift
//  TinderNavDemo
//
//  Created by Ian MacCallum on 7/7/15.
//  Copyright © 2015 Ian MacCallum. All rights reserved.
//

import UIKit

class EducationCollectionViewCell: UICollectionViewScrollCell {
    
    @IBOutlet weak var logoBannerView: UIBannerView!
    @IBOutlet weak var bottomBannerView: UIBannerView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var infoStackView: UIStackView!
    @IBOutlet weak var educationCollectionView: EducationCollectionView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        clipsToBounds = false
//        background = CAGradientLayer(one: Color.ufOrangeLight, two: Color.ufOrange)
        backgroundColor = UIColor.ufOrange()

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        menuButton.horizontalAlignment = .Left
        menuButton.verticalAlignment = .Top
        menuButton.fillColor = UIColor.ufBlue()
        
        contentView.bringSubviewToFront(logoBannerView)
        contentView.bringSubviewToFront(bottomBannerView)

        logoBannerView.path = { frame in
            let offset: CGFloat = frame.width * sqrt(3.0) / 3.0
            let path = UIBezierPath()
            path.moveToPoint(CGPoint(x: 0, y: 0))
            path.addLineToPoint(CGPoint(x: 0, y: frame.height / 2))
            path.addLineToPoint(CGPoint(x: frame.width / 2, y: (frame.height + offset) / 2))
            path.addLineToPoint(CGPoint(x: frame.width, y: frame.height / 2))
            path.addLineToPoint(CGPoint(x: frame.width, y: 0))
            path.addLineToPoint(CGPoint(x: frame.width, y: -1 - self.frame.height / 4))
            path.addLineToPoint(CGPoint(x: 0, y: -1 - self.frame.height / 4))
            path.closePath()
            
            return path
        }
        logoBannerView.fillColor = UIColor.whiteColor()
        
        
        bottomBannerView.path = { frame in
            let offset: CGFloat = frame.width * sqrt(3.0) / 3.0
            let path = UIBezierPath()
            path.moveToPoint(CGPoint(x: 0, y: frame.height - offset / 2))
            path.addLineToPoint(CGPoint(x: frame.width / 2, y: frame.height))
            path.addLineToPoint(CGPoint(x: frame.width, y: frame.height - offset / 2))
            path.addLineToPoint(CGPoint(x: frame.width, y: frame.height + self.frame.height / 2))
            path.addLineToPoint(CGPoint(x: 0, y: frame.height + self.frame.height / 2))
            path.closePath()
            
            return path
        }
        bottomBannerView.fillColor = UIColor.whiteColor()
    }
    
    override func didScroll(withOffset offset: CGPoint) {
        let percent = offset.y / frame.height
        print(percent)
        
        logoBannerView.transform = CGAffineTransformMakeTranslation(0, percent * frame.height * parallaxMultiplier)
        bottomBannerView.transform = CGAffineTransformMakeTranslation(0, percent * frame.height * parallaxMultiplier)

        let a = 1 - fabs(percent)
        logoImageView.alpha = a
        infoStackView.alpha = a
    }
}