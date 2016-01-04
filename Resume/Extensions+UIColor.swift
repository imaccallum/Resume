//
//  UIColorExtension.swift
//  Resume
//
//  Created by Ian MacCallum on 8/24/15.
//  Copyright © 2015 Ian MacCallum. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    private static var flatColors: [UIColor] = []
    
    static func flatBlue() -> UIColor {
        return UIColor(red: 98 / 255, green: 203 / 255, blue: 236 / 255, alpha: 1)
    }
    
    static func flatGreen() -> UIColor {
        return UIColor(red: 132 / 255, green: 198 / 255, blue: 114 / 255, alpha: 1)
    }
    
    static func flatRed() -> UIColor {
        return UIColor(red: 237 / 255, green: 78 / 255, blue: 96 / 255, alpha: 1)
    }
    
    static func flatPurple() -> UIColor {
        return UIColor(red: 124 / 255, green: 120 / 255, blue: 181 / 255, alpha: 1)
    }
    
    static func flatYellow() -> UIColor {
        return UIColor(red: 251 / 255, green: 216 / 255, blue: 50 / 255, alpha: 1)
    }
    
    static func flatOrange() -> UIColor {
        return UIColor(red: 243 / 255, green: 133 / 255, blue: 93 / 255, alpha: 1)
    }
    
    static func flatPink() -> UIColor {
        return UIColor(red: 227 / 255, green: 92 / 255, blue: 160 / 255, alpha: 1)
    }
    
    static func randomFlatColor(deletion: Bool = true) -> UIColor {
        struct Temp { static var colors: [UIColor] = [] }
        
        if deletion {
            let colors = [flatBlue(), flatGreen(), flatRed(), flatPurple(), flatYellow(), flatOrange(), flatPink()]
            return colors[Int.random(colors.count)]
        } else {
            if Temp.colors.count == 0 {
                Temp.colors = [flatBlue(), flatGreen(), flatRed(), flatPurple(), flatYellow(), flatOrange(), flatPink()]
            }
        
            let index = Int.random(flatColors.count)
            let temp = Temp.colors[index]
            Temp.colors.removeAtIndex(index)
            
            return temp
        }
    }
}


extension UIColor {

    static func ufBlue() -> UIColor {
        return UIColor(red: 0 / 255, green: 82 / 255, blue: 155 / 255, alpha: 1.0)
    }
    static func ufOrange() -> UIColor {
        return UIColor(red: 243 / 255, green: 119 / 255, blue: 54 / 255, alpha: 1.0)
    }
    static func ufOrangeLight() -> UIColor {
        return UIColor(red: 252 / 255, green: 80 / 255, blue: 35 / 255, alpha: 1.0)
    }
    static func lightBlue() -> UIColor {
        return UIColor(red: 0 / 255, green: 144 / 255, blue: 213 / 255, alpha: 1.0)
    }
    
    
    
    
}