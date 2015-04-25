//
//  Extensions.swift
//  Resume
//
//  Created by Ian MacCallum on 4/24/15.
//  Copyright (c) 2015 Ian MacCallum. All rights reserved.
//

import Foundation
import UIKit

extension CGPoint {
    var magnitude: CGFloat {
        return hypot(self.x, self.y)
    }
}

extension CGRect {
    var center: CGPoint {
        return CGPoint(x: self.origin.x + (self.width / 2.0), y: self.origin.y + (self.height / 2.0))
    }
    
    public init(center: CGPoint, size: CGSize) {
        self.origin = CGPoint(x: center.x - (size.width / 2.0), y: center.y - (size.height / 2.0))
        self.size = size
    }
}