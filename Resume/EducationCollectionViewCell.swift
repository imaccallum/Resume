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
        
        print(head.layer.position)
        let temp = head.layer.position
        head.layer.anchorPoint = CGPoint(x: 0, y: 0)
        head.layer.position = temp
        print(head.layer.position)

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        let a = CATransform3DMakeTranslation(-head.frame.width / 2, -head.frame.height / 2, 0)
//        let b = CATransform3DMakeRotation(-CGFloat(M_PI_4), 0, 0, 1)
//        
////        head.layer.transform = a
//        head.layer.transform = CATransform3DConcat(a, b)
//
//        head.layer.transform = CATransform3DMakeTranslation(-head.frame.width / 2, -head.frame.height / 2, 0)
//        head.layer.transform = CATransform3DRotate(head.layer.transform, -CGFloat(M_PI_4), 0, 0, 1)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        

    }

    override func didScroll(withOffset offset: CGPoint) {
        let percent = offset.y / frame.height
        print(percent)

//        head.layer.anchorPoint = CGPoint(x: 0, y: 1)
//
//        let a = CATransform3DMakeTranslation(-head.frame.width / 2, head.frame.height / 2, 0)
////        let b = CATransform3DMakeRotation(CGFloat(M_PI_4) * (1 - fabs(percent)), 0, 0, 1)
//        //
//                head.layer.transform = a
//        head.layer.transform = CATransform3DConcat(a, b)

//        let a = CATransform3DMakeTranslation(-head.frame.width / 2, head.frame.height / 2, 0)
//        let b = CATransform3DMakeRotation(CGFloat(M_PI_4) * fabs(percent), 0, 0, 1)
//
//        head.layer.transform = CATransform3DConcat(a, b)
    }
}