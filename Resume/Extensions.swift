//
//  Extensions.swift
//  IanMacCallum
//
//  Created by Ian MacCallum on 6/10/15.
//  Copyright (c) 2015 Ian MacCallum. All rights reserved.
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

extension CGRect {
    init(center: CGPoint, size: CGSize) {
        let origin = CGPoint(x: center.x - size.width / 2, y: center.y - size.height / 2)
        self.init(origin: origin, size: size)
    }
    
    var center: CGPoint {
        return CGPoint(x: self.width / 2, y: self.height / 2)
    }
}

extension CGPoint {
    init(angle: CGFloat, radius: CGFloat, center: CGPoint = CGPointZero) {
        self.init(x: radius * cos(angle) + center.x, y: radius * sin(angle) + center.y)
    }
}

public func >(lhs: NSIndexPath, rhs: NSIndexPath) -> Bool {
    return lhs.compare(rhs) == .OrderedDescending
}

