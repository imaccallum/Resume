//
//  SwapCollectionViewCell.swift
//  TinderNavDemo
//
//  Created by Ian MacCallum on 7/7/15.
//  Copyright © 2015 Ian MacCallum. All rights reserved.
//

import UIKit

class StackCollectionViewCell: UICollectionViewScrollCell {
    
    @IBOutlet weak var reputationLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var stackBannerView: UIBannerView! {
        didSet {
            stackBannerView.fillColor = UIColor.whiteColor()
            stackBannerView.path = { frame in
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
        }
    }
    @IBAction func careersButtonPressed(sender: UIButton) {
    }

    @IBOutlet weak var stackGraphView: StackGraphView!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        clipsToBounds = false
        backgroundColor = UIColor.grayColor()
                
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.bringSubviewToFront(stackBannerView)
        
        menuButton.horizontalAlignment = .Left
        menuButton.verticalAlignment = .Top

        
        // Stack User Information
        let data = NSUserDefaults.standardUserDefaults().objectForKey("StackUser") as? NSData
        let user = NSKeyedUnarchiver.unarchiveObjectWithData(data!) as? StackUser
        nameLabel.text = user?.name ?? "Ian"
        reputationLabel.text = "\(user?.reputation ?? 0) rep"
        

    }
    
    
    override func didScroll(withOffset offset: CGPoint) {
        let percent = offset.y / frame.height
        stackBannerView.transform = CGAffineTransformMakeTranslation(0, percent * frame.height * parallaxMultiplier)
    }
}