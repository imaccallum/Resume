//
//  Extensions+Foundation.swift
//  Resume
//
//  Created by Ian MacCallum on 12/28/15.
//  Copyright © 2015 Ian MacCallum. All rights reserved.
//

import Foundation
import UIKit

extension Int {
    static func random(value: Int) -> Int {
        return Int(arc4random_uniform(UInt32(value)))
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
    init(angle: CGFloat, radius: CGFloat, center: CGPoint = CGPoint.zero) {
        self.init(x: radius * cos(angle) + center.x, y: radius * sin(angle) + center.y)
    }
    
    func midPoint(point: CGPoint) -> CGPoint {
        return CGPoint(x: (x + point.x) / 2, y: (y + point.y) / 2)
    }
}

extension CGSize {
    func half() -> CGSize {
        return CGSize(width: width / 2, height: height / 2)
    }
}



public func >(lhs: NSIndexPath, rhs: NSIndexPath) -> Bool {
    return lhs.compare(rhs as IndexPath) == .orderedDescending
}


prefix func + (value: CGPoint) -> CGPoint {
    return value
}

prefix func - (value: CGPoint) -> CGPoint {
    return CGPoint(x: -value.x, y: -value.y)
}

func + (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

func + (left: CGPoint, right: CGSize) -> CGPoint {
    return CGPoint(x: left.x + right.width, y: left.y + right.height)
}

func - (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

func * (left: CGPoint, right: CGPoint) -> CGFloat {
    return left.x * right.x + left.y * right.y
}

func * (left: CGPoint, right: CGFloat) -> CGPoint {
    return CGPoint(x: left.x * right, y: left.y * right)
}

func * (left: CGFloat, right: CGPoint) -> CGPoint {
    return CGPoint(x: right.x * left, y: right.y * left)
}

func / (left: CGPoint, right: CGFloat) -> CGPoint {
    return CGPoint(x: left.x / right, y: left.y / right)
}

func == (left: CGPoint, right: CGPoint) -> Bool {
    return left.equalTo(right)
}

func += ( left: inout CGPoint, right: CGPoint) {
    left = left + right
}

func -= ( left: inout CGPoint, right: CGPoint) {
    left = left - right
}

func *= ( left: inout CGPoint, right: CGFloat) {
    left = left * right
}

func /= ( left: inout CGPoint, right: CGFloat) {
    left = left / right
}
