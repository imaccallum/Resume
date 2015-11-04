//
//  UIMenuButton.swift
//  Resume
//
//  Created by Ian MacCallum on 10/21/15.
//  Copyright © 2015 Ian MacCallum. All rights reserved.
//

import Foundation
import UIKit

enum HorizontalAlignment {
    case Left, Right
}
enum VerticalAlignment {
    case Top, Center, Bottom
}

protocol MenuButtonDelegate {
    func didSelectMenuButton(menuButton: UIMenuButton, atIndex index: Int)
}

class UIMenuButton: UIButton {
 
    let shapeLayer = CAShapeLayer()
    var horizontalAlignment: HorizontalAlignment = .Left
    var verticalAlignment: VerticalAlignment = .Center
    var color = UIColor.lightBlue()
    var delegate: MenuButtonDelegate?

    var path: (frame: CGRect) -> UIBezierPath {
        didSet { layoutSubviews() }
    }
    var fillColor = UIColor.whiteColor() {
        didSet { shapeLayer.fillColor = fillColor.CGColor }
    }
    
    required init?(coder aDecoder: NSCoder) {
        path = { frame in return UIBezierPath(rect: frame) }
        
        super.init(coder: aDecoder)
        backgroundColor = nil
        userInteractionEnabled = true
        
        addTarget(self, action: "buttonPressed:", forControlEvents: .TouchUpInside)

    }

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.insertSublayer(shapeLayer, atIndex: 0)

        path = { frame in
            let path = UIBezierPath()
            let offset: CGFloat = 2 * frame.width * sqrt(3) / 3
            
            let base = self.horizontalAlignment == .Left ? 0 : frame.width
            let point = self.horizontalAlignment == .Left ? frame.width : 0
            
            
            let top: CGFloat = self.verticalAlignment == .Top ? 0 : self.verticalAlignment == .Bottom ? frame.height - offset : (frame.height - offset) / 2
            let bottom: CGFloat = self.verticalAlignment == .Top ? offset : self.verticalAlignment == .Bottom ? frame.height : (frame.height + offset) / 2
            let center: CGFloat = self.verticalAlignment == .Top ? offset / 2 : self.verticalAlignment == .Bottom ? frame.height - offset / 2 : frame.height / 2
            
            path.moveToPoint(CGPoint(x: base, y: top))
            path.addLineToPoint(CGPoint(x: base, y: bottom))
            path.addLineToPoint(CGPoint(x: point, y: center))
            
            path.closePath()
            return path
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        shapeLayer.path = path(frame: bounds).CGPath
    }
    
    
    func buttonPressed(sender: UIButton) {
        print("Pressed")
        delegate?.didSelectMenuButton(self, atIndex: tag)
        
    }
}