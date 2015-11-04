//
//  UIPolyImageView.swift
//  IanMacCallum
//
//  Created by Ian MacCallum on 6/13/15.
//  Copyright © 2015 Ian MacCallum. All rights reserved.
//

import Foundation
import UIKit

class UIPolyImageView: UIImageView {
    
    var mask = CAShapeLayer()
    var stroke = CAShapeLayer()
    
    var sides: Int = 6
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        stroke.lineWidth = 4
        stroke.strokeColor = UIColor.blackColor().CGColor
        stroke.fillColor = nil
        
        layer.mask = mask
        layer.addSublayer(stroke)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let path = UIBezierPath(polygonInRect: frame, numberOfSides: sides, offset: CGFloat(M_PI_2)).CGPath
        mask.path = path
        stroke.path = path
    }
}