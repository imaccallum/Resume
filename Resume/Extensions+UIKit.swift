//
//  Extensions+UIKit.swift
//  Resume
//
//  Created by Ian MacCallum on 1/4/16.
//  Copyright © 2016 Ian MacCallum. All rights reserved.
//

import Foundation
import UIKit


extension CAGradientLayer {
    convenience init(one: UIColor, two: UIColor) {
        self.init()
        let colour_array = [one.CGColor,two.CGColor]
        self.colors = colour_array
    }
}

extension UIBezierPath {
    
    convenience init(polygonInRect rect: CGRect, numberOfSides sides: Int, offset: CGFloat = 0) {
        self.init()
        for i in 0..<sides {
            let angle = CGFloat(i) * CGFloat(2) * CGFloat(M_PI) / CGFloat(sides) + offset
            let radius = min(rect.width, rect.height) / 2
            let point = CGPoint(angle: angle, radius: radius, center: rect.center)
            i == 0 ? moveToPoint(point) : addLineToPoint(point)
        }
        
        closePath()
    }
}

