//
//  Extensions.swift
//  IanMacCallum
//
//  Created by Ian MacCallum on 6/10/15.
//  Copyright (c) 2015 Ian MacCallum. All rights reserved.
//

import Foundation
import UIKit


func delay(delay:Double, closure:()->()) {
    dispatch_after(
        dispatch_time(
            DISPATCH_TIME_NOW,
            Int64(delay * Double(NSEC_PER_SEC))
        ),
        dispatch_get_main_queue(), closure)
}
