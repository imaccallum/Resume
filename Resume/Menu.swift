//
// Menu.swift
//  Resume
//
//  Created by Ian MacCallum on 8/4/15.
//  Copyright © 2015 Ian MacCallum. All rights reserved.
//

import UIKit
import Foundation


//MARK: Typealiases
typealias Block = () -> ()
typealias SuccessBlock = Bool -> ()

//MARK: Menu Node
class MenuNode: NSObject {
    let title: String
    let imageName: String?
    
    init(title: String, imageName: String?) {
        self.title = title
        self.imageName = imageName
        super.init()
    }
    
    func image() -> UIImage? {
        guard let imageName = imageName else { return nil }
        return UIImage(named: imageName)
    }
}


//MARK: Delegate Protocol
@objc protocol MenuDelegate {
    func menu(menu: Menu, didUpdateWithPercent percent: CGFloat)
    func menu(menu: Menu, shouldSnapToItemIndex index: Int)
    func menu(menu: Menu, didDismissWithIndex index: Int)    
}


//MARK: - Data Source Protocol
@objc protocol MenuDataSource {
    optional func sizeForIndicatorViewForMenu(menu: Menu) -> CGSize
    func presentingViewForMenu(menu: Menu) -> UIView
    func numberOfItemsInMenu(menu: Menu) -> Int
    func menu(menu: Menu, nodeForItemAtIndex index: Int) -> MenuNode
}

// MARK: - Menu Indicator State
enum MenuState {
    case Hidden, Visible, Tracking, Animating
}


//MARK: - Menu
class Menu: NSObject {

    private var currentIndex: Int = -1 { didSet { if oldValue != currentIndex { didChangeIndex(currentIndex) } } }
    private var presentingView: UIView { return dataSource.presentingViewForMenu(self) }
    private var itemCount: Int { return dataSource.numberOfItemsInMenu(self) }
    private let dataSource: MenuDataSource
    weak var delegate: MenuDelegate?
    
    private var menuTopEdgeConstraint: NSLayoutConstraint?
    private var indicatorView: MenuIndicatorView!
    private var panOriginalCenterY: CGFloat = 0
    private var menuOriginalY: CGFloat = 0
    private var menuView: UIView!
    private var tracking = false
    
    init(dataSource: MenuDataSource) {
        self.dataSource = dataSource
        super.init()
        addIndicator()
    }
    
    private func addIndicator() {
        
        // Instantiate Indicator
        indicatorView = MenuIndicatorView(size: CGSizeMake(48, 48), shapeColor: UIColor.whiteColor())
        let minimum = presentingView.frame.height / CGFloat(2 * itemCount)
        indicatorView.updateCenterY(minimum)
        indicatorView.addInView(presentingView)
        presentingView.bringSubviewToFront(indicatorView)
        // Handle Gestures
        let panGesture = UIPanGestureRecognizer(target: self, action: "handlePan:")
        indicatorView.addGestureRecognizer(panGesture)

        let tapGesture = UITapGestureRecognizer(target: self, action: Selector("handleTap:"))
        indicatorView.addGestureRecognizer(tapGesture)
        
        // Update Contraints
        presentingView.translatesAutoresizingMaskIntoConstraints = false
        presentingView.needsUpdateConstraints()
        showIndicator()
    }
    
    // Handle Gestures
    func handleTap(sender: UIGestureRecognizer){

    }
    
    func handlePan(sender: UIPanGestureRecognizer) {
        
        let dy = sender.translationInView(presentingView).y
        let y = panOriginalCenterY + dy
        let h = presentingView.frame.height
        let minimum = h / CGFloat(2 * itemCount)
        let maximum = CGFloat(2 * itemCount - 1) * minimum
        let percent = (y - minimum) / (maximum - minimum)
        let index = indexForPercent(percent)

        if sender.state == .Began {
            panOriginalCenterY = sender.locationInView(presentingView).y - sender.locationInView(indicatorView).y + indicatorView.frame.height / 2
            tracking = true
        } else if sender.state == .Changed  {
            currentIndex = index
            indicatorView.updateCenterY(y)
            delegate?.menu(self, didUpdateWithPercent: percent)
        } else if sender.state == .Ended || sender.state == .Cancelled {
            tracking = false
            delegate?.menu(self, shouldSnapToItemIndex: index)
        } else {
            tracking = false
        }
    }
    
    func shouldSnapToItemIndex(index: Int) {
        
    }
    
    func didChangeIndex(index: Int) {
        let image = dataSource.menu(self, nodeForItemAtIndex: index).image()
        indicatorView.updateImage(image)
    }
    
    func indexForPercent(percent: CGFloat) -> Int {
        let page = max(min(1, percent), 0)
        return Int(round(page * CGFloat(itemCount - 1)))
    }

    func handleScroll<T: UIScrollView>(sender: T?) {
        guard !tracking, let sender = sender else { return }

        let percent = sender.contentOffset.y / (sender.contentSize.height - sender.frame.height)
        let minimum = presentingView.frame.height / CGFloat(2 * itemCount)
        let maximum = CGFloat(2 * itemCount - 1) * minimum
        let offset = minimum + percent * (maximum - minimum)
        let index = indexForPercent(percent)

        indicatorView.updateCenterY(offset)
        currentIndex = index
    }
    
    func showIndicator(animated: Bool = false) {
        indicatorView.show(animated)
    }
    
    func hideIndicator(animated: Bool = false) {
        indicatorView.hide(animated)
    }
    
    // MARK: - Constraints
    private func getEqualConstraint(item: AnyObject, toItem: AnyObject, attribute: NSLayoutAttribute) -> NSLayoutConstraint{
        return NSLayoutConstraint(item: item, attribute: attribute, relatedBy: .Equal, toItem: toItem, attribute: attribute, multiplier: 1, constant: 0)
    }
}

//MARK: - IndicatorView Class
class MenuIndicatorView: UIView {

    private var edgeConstraint: NSLayoutConstraint?
    private var topConstraint: NSLayoutConstraint?
    private var state: MenuState = .Hidden
    private let imageView = UIImageView()
    private var shapeColor: UIColor
    private var size: CGSize
    
    init(size:CGSize, shapeColor: UIColor) {
        self.size = size
        self.shapeColor = shapeColor
        super.init(frame: CGRectMake(0, 0, size.width, size.height))
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor.clearColor()
        
//        let diamond = ShapeLayer(type: .Diamond, inTileRect: bounds, size: .M, color: UIColor.whiteColor())
//        layer.addSublayer(diamond)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(frame: CGRect) {
        super.drawRect(frame)
    }
    
    //MARK: - Indicator methods
    func addInView(hostView:UIView) {
        
        hostView.addSubview(self)
        hostView.bringSubviewToFront(self)
        frame = CGRect(x: 64, y: 64, width: 64, height: 64)
        topConstraint = NSLayoutConstraint(item: self, attribute: .Top, relatedBy: .Equal, toItem: hostView, attribute: .Top, multiplier: 1, constant: 0)
        
        //hide the indicator, will appear from the outside of the screen
        edgeConstraint = NSLayoutConstraint(item: self, attribute: .Trailing, relatedBy: .Equal, toItem: hostView, attribute: .Trailing, multiplier: 1, constant: 0)
        
        hostView.addConstraints([
            edgeConstraint!,
            NSLayoutConstraint(item: self, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: size.width),
            NSLayoutConstraint(item: self, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: size.height),
            topConstraint!
            ])
        
        hostView.layoutIfNeeded()
        
        
        //add Icon imageView
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        
        //constraints for imageView
        self.addConstraints([
            NSLayoutConstraint(item: imageView, attribute: .Leading, relatedBy: .Equal, toItem: self, attribute: .Leading, multiplier: 1, constant: 10),
            NSLayoutConstraint(item: imageView, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 24),
            NSLayoutConstraint(item: imageView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 24),
            NSLayoutConstraint(item: imageView, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1, constant: 0),
            ])
        
        imageView.layoutIfNeeded()
    }

    func updateCenterY(y: CGFloat) {
        let adjustedY = y - size.height / 2
        topConstraint?.constant = adjustedY
        superview?.layoutIfNeeded()
    }
    
    ///Hides the indicator
    func hide(animated: Bool) {
        state = .Animating
        
        animateX(frame.width, duration: animated ? 0.2 : 0) { success in
            self.hidden = true
            self.state = .Hidden
        }
    }
    
    ///Shows the indicator
    func show(animated: Bool){
        state = .Animating
        
        self.hidden = false

        animateX(0, duration: animated ? 0.2 : 0) { success in
            self.state = .Visible
        }
    }

    func animateX(constant: CGFloat, duration: NSTimeInterval, completion: SuccessBlock? = nil) {
        edgeConstraint?.constant = constant
        UIView.animateWithDuration(duration, delay: 0, options: .CurveEaseOut, animations: {
            self.superview?.layoutIfNeeded()
        }) { success in
            completion?(success)
        }
    }
    
    func updateImage(image: UIImage?) {
        
        let transition = CATransition()
        transition.duration = 0.2
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        transition.type = kCATransitionFade
        imageView.layer.addAnimation(transition, forKey: nil)
        
        imageView.image = image
    }
}
