//
//  SwapCollectionViewCell.swift
//  TinderNavDemo
//
//  Created by Ian MacCallum on 7/7/15.
//  Copyright © 2015 Ian MacCallum. All rights reserved.
//

import UIKit
import CoreData
class BioCollectionViewCell: UICollectionViewScrollCell {
    
    @IBOutlet weak var videoBannerView: UIBannerView!
    @IBOutlet weak var videoImageView: UIImageView!
    @IBOutlet weak var bioTextView: UICenteredTextView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        clipsToBounds = false
        backgroundColor = UIColor.grayColor()
        
        NSNotificationCenter.defaultCenter().addObserverForName(UIContentSizeCategoryDidChangeNotification, object: nil, queue: NSOperationQueue.mainQueue()) { notification in
            self.layoutSubviews()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

        contentView.bringSubviewToFront(videoBannerView)
        contentView.bringSubviewToFront(videoImageView)

        bioTextView.contentOffset.y = 0
        bioTextView.backgroundColor = nil
        bioTextView.textColor = UIColor.whiteColor()
        
        
        menuButton.horizontalAlignment = .Right
        menuButton.verticalAlignment = .Center
        menuButton.fillColor = UIColor.lightBlue()

        videoBannerView.fillColor = UIColor.whiteColor()
        videoBannerView.path = { frame in
            let offset: CGFloat = frame.width * sqrt(3.0) / 3.0
            let path = UIBezierPath()
            path.moveToPoint(CGPoint(x: 0, y: frame.height - offset))
            path.addLineToPoint(CGPoint(x: 0, y: frame.height))
            path.addLineToPoint(CGPoint(x: 0, y: frame.height + self.frame.height / 2))
            path.addLineToPoint(CGPoint(x: frame.width, y: frame.height + self.frame.height / 2))
            path.addLineToPoint(CGPoint(x: frame.width, y: frame.height))

            path.closePath()
            
        
            
            return path
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let titleString = "About Me\n"
        let titleFont = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        
        let attrTitle = NSMutableAttributedString(string: titleString)
        attrTitle.addAttribute(NSFontAttributeName, value: titleFont, range: NSMakeRange(0, titleString.characters.count))
        attrTitle.addAttribute(NSForegroundColorAttributeName, value: UIColor.whiteColor(), range: NSMakeRange(0, titleString.characters.count))

        let bodyString = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut aliquam arcu eu neque condimentum, sit amet semper leo consectetur. In id dictum nulla. Aliquam consequat justo mattis, faucibus felis quis, tincidunt mauris. Aliquam erat volutpat. Sed mauris elit, malesuada malesuada tortor sit amet, malesuada congue nibh. Praesent eu dapibus augue, ac scelerisque dui. Quisque eleifend iaculis hendrerit. Cras id lobortis elit. Sed sapien purus, maximus eu tincidunt non, fermentum at augue. In dapibus libero metus, id pretium felis pellentesque ac."
        let bodyFont = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        
        let attrBody = NSMutableAttributedString(string: bodyString)
        attrBody.addAttribute(NSFontAttributeName, value: bodyFont, range: NSMakeRange(0, bodyString.characters.count))
        attrBody.addAttribute(NSForegroundColorAttributeName, value: UIColor.whiteColor().colorWithAlphaComponent(0.75), range: NSMakeRange(0, bodyString.characters.count))

        attrTitle.appendAttributedString(attrBody)
        bioTextView.attributedText = attrTitle

    }

    override func didScroll(withOffset offset: CGPoint) {
        let percent = offset.y / frame.height
        
        videoBannerView.transform = CGAffineTransformMakeTranslation(0, percent * frame.height * parallaxMultiplier)

        if fabs(percent) < 0.9 {
            bioTextView.alpha = 1 - fabs(percent) / 0.9
        } else {
            bioTextView.alpha = 0
        }
        
    }
}