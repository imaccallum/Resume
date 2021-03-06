//
//  ShapeKit+Presets.swift
//  Resume
//
//  Created by Ian MacCallum on 1/4/16.
//  Copyright © 2016 Ian MacCallum. All rights reserved.
//

import Foundation
import UIKit

class ShapeLayout {
    
    class func homeTopLayout() -> [Shape] {
        return [
            
            // Row 1
            Shape(tile: CGPoint(x: 2, y: 2),    type: .Triangle,    size: .M,   direction: .Left),
            Shape(tile: CGPoint(x: 2, y: 2),    type: .Triangle,    size: .S,   direction: .Left),
            Shape(tile: CGPoint(x: 12, y: 2),   type: .Semicircle,  size: .L,   direction: .Top),
            Shape(tile: CGPoint(x: 12, y: 2),   type: .Square,      size: .M,   direction: nil),
            Shape(tile: CGPoint(x: 14, y: 4),   type: .Circle,      size: .S,   direction: .Right),
            Shape(tile: CGPoint(x: 37, y: 3),   type: .Diamond,     size: .M,   direction: nil),
            Shape(tile: CGPoint(x: 30, y: 4),   type: .Square,     size: .SM,   direction: nil),
            Shape(tile: CGPoint(x: 28, y: 12),  type: .Triangle,    size: .ML,   direction: .Right),
            Shape(tile: CGPoint(x: 42, y: 2),   type: .Triangle,    size: .S,   direction: .Right),
            Shape(tile: CGPoint(x: 46, y: 2),   type: .Semicircle,  size: .L,   direction: .Top),
            Shape(tile: CGPoint(x: 50, y: 6),   type: .Circle,      size: .M,   direction: nil),
            Shape(tile: CGPoint(x: 64, y: 2),   type: .Circle,      size: .M,   direction: .Right),
            Shape(tile: CGPoint(x: 66, y: 4),   type: .Diamond,     size: .S,   direction: .Right),
            Shape(tile: CGPoint(x: 72, y: 2),   type: .Triangle,    size: .SM,  direction: .Right),
            Shape(tile: CGPoint(x: 64, y: 12),  type: .Semicircle,  size: .L,   direction: .Right),
            Shape(tile: CGPoint(x: 70, y: 18),  type: .Circle,      size: .S,   direction: nil),
            Shape(tile: CGPoint(x: 80, y: 2),   type: .Diamond,     size: .ML,  direction: nil),
            Shape(tile: CGPoint(x: 84, y: 6),   type: .Circle,      size: .S,   direction: .Right),
            Shape(tile: CGPoint(x: 90, y: 2),   type: .Triangle,    size: .M,   direction: .Right),
            
            // Row 2
            Shape(tile: CGPoint(x: 2, y: 24),   type: .Triangle,    size: .S,   direction: .Top),
            Shape(tile: CGPoint(x: 2, y: 12),   type: .Triangle,    size: .M,   direction: .Top),
            Shape(tile: CGPoint(x: 2, y: 20),   type: .Triangle,    size: .M,   direction: .Right),
            Shape(tile: CGPoint(x: 6, y: 6),    type: .Diamond,     size: .S,   direction: .Right),
            Shape(tile: CGPoint(x: 6, y: 12),   type: .Diamond,     size: .S,   direction: .Right),
            Shape(tile: CGPoint(x: 12, y: 16),  type: .Semicircle,  size: .LXL, direction: .Top),
            Shape(tile: CGPoint(x: 12, y: 12),  type: .Square,      size: .ML,  direction: .Top),
            Shape(tile: CGPoint(x: 12, y: 16),  type: .Square,      size: .ML,  direction: .Top),
            Shape(tile: CGPoint(x: 40, y: 24),  type: .Circle,      size: .S,   direction: nil),
            Shape(tile: CGPoint(x: 52, y: 22),  type: .Diamond,     size: .S,   direction: nil),
            Shape(tile: CGPoint(x: 43, y: 12),  type: .Diamond,     size: .ML,  direction: nil),
            Shape(tile: CGPoint(x: 47, y: 16),  type: .Circle,      size: .S,   direction: nil),
            Shape(tile: CGPoint(x: 56, y: 14),  type: .Diamond,     size: .M,   direction: nil),
            Shape(tile: CGPoint(x: 62, y: 12),  type: .Triangle,    size: .S,   direction: .Right),
            Shape(tile: CGPoint(x: 58, y: 22),  type: .Triangle,    size: .SM,  direction: .Bottom),
            Shape(tile: CGPoint(x: 64, y: 22),  type: .Triangle,    size: .SM,  direction: .Top),
            Shape(tile: CGPoint(x: 82, y: 16),  type: .Diamond,     size: .SM,   direction: nil),
            Shape(tile: CGPoint(x: 90, y: 12),  type: .Diamond,     size: .SM,  direction: nil),
            Shape(tile: CGPoint(x: 82, y: 20),  type: .Triangle,    size: .M,   direction: .Bottom),
            Shape(tile: CGPoint(x: 90, y: 20),  type: .Square,      size: .M,   direction: .Right),
            
            // Row 3
        ]
    }
    
    class func homeBottomLayout() -> [Shape] {
        var shapes = homeTopLayout()
        
        shapes += [
            Shape(tile: CGPoint(x: 14, y: 34),  type: .Diamond,     size: .ML,   direction: nil),
            Shape(tile: CGPoint(x: 28, y: 37),  type: .Circle,      size: .SM,   direction: nil),
            Shape(tile: CGPoint(x: 36, y: 34),  type: .Diamond,     size: .ML,   direction: nil),
        
        
            Shape(tile: CGPoint(x: 2, y: 30),   type: .Triangle,    size: .M,   direction: .Left),
            Shape(tile: CGPoint(x: 2, y: 30),   type: .Triangle,    size: .M,   direction: .Right),
            Shape(tile: CGPoint(x: 2, y: 38),   type: .Diamond,     size: .M,   direction: nil),
            Shape(tile: CGPoint(x: 4, y: 40),  type: .Circle,      size: .S,   direction: nil),
            
            Shape(tile: CGPoint(x: 12, y: 32),  type: .Triangle,    size: .SM,   direction: .Left),
            Shape(tile: CGPoint(x: 24, y: 30),  type: .Diamond,     size: .S,   direction: nil),
            Shape(tile: CGPoint(x: 34, y: 30),  type: .Square,      size: .S,   direction: nil),
            Shape(tile: CGPoint(x: 48, y: 40),  type: .Semicircle,  size: .M,   direction: .Left),
            Shape(tile: CGPoint(x: 50, y: 42),  type: .Semicircle,  size: .S,   direction: .Left),
            Shape(tile: CGPoint(x: 44, y: 31),  type: .Triangle,    size: .M,   direction: .Right),

            
            Shape(tile: CGPoint(x: 32, y: 44),  type: .Circle,      size: .S,   direction: nil),
            Shape(tile: CGPoint(x: 24, y: 44),  type: .Triangle,    size: .S,   direction: .Bottom),
            Shape(tile: CGPoint(x: 25, y: 50),  type: .Triangle,    size: .M,   direction: .Left),
            Shape(tile: CGPoint(x: 17, y: 50),  type: .Triangle,    size: .M,   direction: .Right),
            Shape(tile: CGPoint(x: 10, y: 44),  type: .Diamond,     size: .SM,  direction: nil),

            Shape(tile: CGPoint(x: 2, y: 46),   type: .Triangle,     size: .ML,   direction: .Top),
            Shape(tile: CGPoint(x: 16, y: 54),  type: .Diamond,     size: .S,  direction: nil),
            Shape(tile: CGPoint(x: 30, y: 54),  type: .Circle,      size: .S,   direction: nil),

            Shape(tile: CGPoint(x: 39, y: 48),  type: .Diamond,     size: .M,  direction: nil),
            Shape(tile: CGPoint(x: 36, y: 52),  type: .Triangle,    size: .SM,   direction: .Top),
            Shape(tile: CGPoint(x: 44, y: 50),  type: .Triangle,    size: .M,   direction: .Bottom),
            Shape(tile: CGPoint(x: 48, y: 54),  type: .Triangle,    size: .S,   direction: .Bottom),
        ]
        
        return shapes
    }
}