//
//  UIBannerView.swift
//  Resume
//
//  Created by Ian MacCallum on 8/5/15.
//  Copyright © 2015 Ian MacCallum. All rights reserved.
//

import Foundation
import UIKit

class UIBannerView: UIView {
    let shapeLayer = CAShapeLayer()
    var path: (frame: CGRect) -> UIBezierPath {
        didSet { layoutSubviews() }
    }
    var fillColor = UIColor.whiteColor() {
        didSet { shapeLayer.fillColor = fillColor.CGColor }
    }
    
   required  init?(coder aDecoder: NSCoder) {
        path = { frame in return UIBezierPath(rect: frame) }
    
        super.init(coder: aDecoder)
        backgroundColor = nil
        userInteractionEnabled = false

    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("touches began")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.insertSublayer(shapeLayer, atIndex: 0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        shapeLayer.path = path(frame: bounds).CGPath

        
    }
}