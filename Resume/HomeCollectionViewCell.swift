//
//  SwapCollectionViewCell.swift
//  TinderNavDemo
//
//  Created by Ian MacCallum on 7/7/15.
//  Copyright © 2015 Ian MacCallum. All rights reserved.
//

import UIKit
import CoreImage

class HomeCollectionViewCell: UICollectionViewScrollCell {
    
    @IBOutlet weak var bottomShapeView: ShapeView!
    @IBOutlet weak var topShapeView: ShapeView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        topShapeView.shapes = ShapeLayout.homeTopLayout()
        bottomShapeView.shapes = ShapeLayout.homeTopLayout()
        
        textLabel.textColor = UIColor(white: 1.0, alpha: 0.5)
        bringSubviewToFront(textLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.layer.cornerRadius = min(imageView.bounds.width, imageView.bounds.height) / 2
        topShapeView.setNeedsDisplay()
    }

    override func didScroll(withOffset offset: CGPoint) {
        let percent = offset.y / frame.height
        print("percent \(percent)")
        
//        let rotation = CATransform3DMakeAffineTransform(CGAffineTransformMakeRotation(4 * CGFloat(M_PI) * percent))
//        let scale = CATransform3DMakeAffineTransform(CGAffineTransformMakeScale(1 - fabs(percent), 1 - fabs(percent)))
//        let transform = CATransform3DConcat(rotation, scale)
//        let alpha = Float(1 - fabs(percent))
//    
//        topShapeView.shapeLayers.forEach { shapeLayer in
//            shapeLayer.transform = scale
//            shapeLayer.opacity = alpha
//        }
//
//        bottomShapeView.shapeLayers.forEach { shapeLayer in
//            shapeLayer.transform = scale
//            shapeLayer.opacity = alpha
//        }

    }
}