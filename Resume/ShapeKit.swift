//
//  ShapeKit.swift
//  Shapes
//
//  Created by Ian MacCallum on 12/30/15.
//  Copyright © 2015 Ian MacCallum. All rights reserved.
//

import Foundation
import UIKit

func * (left: CGFloat, right: CGSize) -> CGSize {
  return CGSize(width: left * right.width, height: left * right.height)
}

enum ShapeType {
  case Square, Diamond, Triangle, Circle, Semicircle
}

enum ShapeSize: CGFloat {
  case XS = 2, S = 4, SM = 6, M = 8, ML = 12, L = 16, LXL = 24, XL = 32 // Percent of screen width
}

enum ShapeDirection: Int {
  case Top = 0, Bottom, Left, Right
}

struct Shape {
  let tile: CGPoint
  let type: ShapeType
  let size: ShapeSize
  let direction: ShapeDirection?
}

class ShapeView: UIView {
  var shapeLayers: [ShapeLayer] = []
  var shapes: [Shape] = []
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    backgroundColor = UIColor.clearColor()
    clipsToBounds = false
    
    drawShapes()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    shapeLayers.forEach { shape in
      shape.updatePath(bounds)
      shape.zPosition = 1
    }
  }
  
  func drawShapes() {
    
    shapes.enumerate().forEach { (i, shape) in
      let shape = ShapeLayer(type: shape.type, atTile: shape.tile, size: shape.size, direction: shape.direction)
      self.shapeLayers.append(shape)
      self.layer.insertSublayer(shape, atIndex: UInt32(i))
    }
  }
}



class ShapeLayer: CAShapeLayer {
  
  let type: ShapeType
  let size: ShapeSize
  let direction: ShapeDirection?
  let tile: CGPoint
  
  override init(layer: AnyObject) {
    type = .Circle
    size = .M
    direction = nil
    tile = CGPointZero
    super.init(layer: layer)
  }
  
  init(type: ShapeType, atTile tile: CGPoint, size: ShapeSize, direction: ShapeDirection? = nil) {
    self.direction = direction
    self.tile = tile
    self.type = type
    self.size = size
    
    super.init()
    masksToBounds = true
    fillColor = UIColor.randomFlatColor(false).CGColor
  }
  
  func updatePath(rect: CGRect) {
    let unit = rect.width / 100
    
    let x = CGFloat(tile.x) * unit
    let y = CGFloat(tile.y) * unit
    
    let newSize = self.size.rawValue * CGSize(width: unit, height: unit)
    let newOrigin = CGPoint(x: x, y: y)
    let newRect = CGRect(origin: newOrigin, size: newSize)
    
    
    
    frame = newRect
    path = pathForType(type, ofSize: newRect.size, direction: direction)
  }
  
  func pathForType(type: ShapeType, ofSize size: CGSize, direction: ShapeDirection?) -> CGPath {
    let rect = CGRect(origin: CGPointZero, size: size)
    
    switch type {
    case .Circle:
      return UIBezierPath(ovalInRect: rect).CGPath
    case .Semicircle:
      return pathForSemicircle(rect.size, direction: direction)
    case .Square:
      return UIBezierPath(rect: rect).CGPath
    case .Diamond:
      return pathForDiamond(rect.size)
    case .Triangle:
      return pathForTriangle(rect.size, direction: direction)
    }
  }
  
  func pathForTriangle(size: CGSize, direction: ShapeDirection?) -> CGPath {
    let direction = direction ?? .Bottom
    var points = [CGPoint(x: size.width, y: 0), CGPointZero, CGPoint(x: size.width, y: size.height), CGPoint(x: 0, y: size.height)]
    points.removeAtIndex(direction.rawValue)
    
    let path = UIBezierPath()
    path.moveToPoint(points[0])
    path.addLineToPoint(points[1])
    path.addLineToPoint(points[2])
    path.closePath()
    return path.CGPath
  }
  
  func pathForDiamond(size: CGSize) -> CGPath {
    let path = UIBezierPath()
    path.moveToPoint(CGPoint(x: size.width / 2, y: 0))
    path.addLineToPoint(CGPoint(x: size.width, y: size.height / 2))
    path.addLineToPoint(CGPoint(x: size.width / 2, y: size.height))
    path.addLineToPoint(CGPoint(x: 0, y: size.height / 2))
    path.closePath()
    return path.CGPath
  }
  
  func pathForSemicircle(size: CGSize, direction: ShapeDirection?) -> CGPath {
    let point = CGPoint(x: size.width / 2, y: size.height / 2)
    let angles = direction == .Left || direction == .Right ? [CGFloat(M_PI_2), CGFloat(3 * M_PI_2)] : [CGFloat(0), CGFloat(M_PI)]
    
    return UIBezierPath(arcCenter: point, radius: size.width / 2, startAngle: angles[0], endAngle: angles[1], clockwise: direction == .Bottom || direction == .Left).CGPath
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}