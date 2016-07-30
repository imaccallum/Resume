//
//  UIColorExtension.swift
//  Resume
//
//  Created by Ian MacCallum on 8/24/15.
//  Copyright © 2015 Ian MacCallum. All rights reserved.
//

import Foundation
import UIKit


// MARK: - Flat
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


// MARK: - Education
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



// MARK: - Stack
extension UIColor {
  
  static func stackTan() -> UIColor {
    return UIColor(red: 255 / 255, green: 248 / 255, blue: 221 / 255, alpha: 1.0)
  }
 
  static func stackTagBlue() -> UIColor {
    return UIColor(red: 225 / 255, green: 236 / 255, blue: 244 / 255, alpha: 1.0)
  }
  
  static func stackTagText() -> UIColor {
    return UIColor(red: 60 / 255, green: 116 / 255, blue: 155 / 255, alpha: 1.0)
  }
  static func stackDividerOrange() -> UIColor {
    return UIColor(red: 244 / 255, green: 156 / 255, blue: 92 / 255, alpha: 1.0)
  }
  
  static func stackDividerGray() -> UIColor {
    return UIColor(red: 205 / 255, green: 205 / 255, blue: 205 / 255, alpha: 1.0)
  }
  
  static func stackGraphGreen() -> UIColor {
    return UIColor(red: 173 / 255, green: 200 / 255, blue: 159 / 255, alpha: 1.0)
  }
  
  static func stackLabelGray() -> UIColor {
    return UIColor(red: 153 / 255, green: 153 / 255, blue: 153 / 255, alpha: 1.0)
  }
  
  static func stackBoxText() -> UIColor {
    return UIColor(red: 119 / 255, green: 119 / 255, blue: 119 / 255, alpha: 1.0)
  }
  
  static func stackBoxOutline() -> UIColor {
    return UIColor(red: 205 / 255, green: 205 / 255, blue: 205 / 255, alpha: 1.0)
  }
  
  static func stackBoxYellow() -> UIColor {
    return UIColor(red: 225 / 255, green: 230 / 255, blue: 56 / 255, alpha: 1.0)
  }
  
  static func stackBoxGreen() -> UIColor {
    return UIColor(red: 117 / 255, green: 131 / 255, blue: 94 / 255, alpha: 1.0)
  }
}

// MARK: - Git