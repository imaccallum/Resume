//
//  MenuTransitionManager.swift
//  Menu
//
//  Created by Mathew Sanders on 9/7/14.
//  Copyright (c) 2014 Mat. All rights reserved.
//

import UIKit

class MenuTransitionManager: UIPercentDrivenInteractiveTransition {

    private var presenting = false
    private var interactive = false
    
    private var enterPanGesture: UIPanGestureRecognizer!
    private var exitPanGesture: UIPanGestureRecognizer!
    
    var sourceViewController: HomeViewController! {
        didSet {
            self.enterPanGesture = UIPanGestureRecognizer(target: self, action: "handleOnstagePan:")
            self.sourceViewController.view.addGestureRecognizer(self.enterPanGesture)
            self.sourceViewController.transitioningDelegate = self
        }
    }
    
    
    var destinationViewController: AboutViewController! {
        didSet {
            self.exitPanGesture = UIPanGestureRecognizer(target: self, action: "handleOffstagePan:")
            self.destinationViewController.view.addGestureRecognizer(self.exitPanGesture)
        }
    }
    
    func handleOnstagePan(pan: UIPanGestureRecognizer){
        let translation = pan.translationInView(pan.view!)

        let d = min(translation.magnitude / (pan.view!.bounds.width * 0.5), 1.0)
        println(d)
        switch (pan.state) {
            
        case .Began:
            interactive = true

            destinationViewController.transitioningDelegate = self
            sourceViewController.presentViewController(destinationViewController, animated: true) {}
        case .Changed:
            updateInteractiveTransition(d)
        default: // .Ended, .Cancelled, .Failed ...

            interactive = false
            if d > 0.2 {
                finishInteractiveTransition()
            } else {
                cancelInteractiveTransition()
            }
        }
    }
    
    func handleOffstagePan(pan: UIPanGestureRecognizer){
        
        let translation = pan.translationInView(pan.view!)
        
        let d = min(translation.magnitude / (pan.view!.bounds.width * 0.5), 1.0)
        
        switch (pan.state) {
            
        case UIGestureRecognizerState.Began:
            interactive = true

            destinationViewController.dismissViewControllerAnimated(true) {}
                break
            
        case UIGestureRecognizerState.Changed:
            updateInteractiveTransition(d)
            break
            
        default: // .Ended, .Cancelled, .Failed ...
            interactive = false
            if d > 0.1 {
                finishInteractiveTransition()
            } else {
                cancelInteractiveTransition()
            }
        }
    }

    func presentingViewController(viewController: HomeViewController) {
        viewController.view.alpha = 0
    }
    
    func dismissViewingController(viewController: HomeViewController) {
        viewController.view.alpha = 1
    }
}

extension MenuTransitionManager: UIViewControllerAnimatedTransitioning {
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return 0.5
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView()
        
        // create a tuple of our screens
        let screens : (from:UIViewController, to:UIViewController) = (transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!, transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!)
        
        let sourceViewController = !presenting ? screens.to as! HomeViewController : screens.from as! HomeViewController
        let destinationViewController = !presenting ? screens.from as! AboutViewController : screens.to as! AboutViewController
        
        let sourceView = sourceViewController.view
        let destinationView = destinationViewController.view
        
        
        
        container.addSubview(destinationView)
        container.addSubview(sourceView)
        

        
        
        
        
        
        let duration = transitionDuration(transitionContext)
        UIView.animateWithDuration(duration, animations: {
            
            if self.presenting {
                self.presentingViewController(sourceViewController)
            } else {
                self.dismissViewingController(sourceViewController)
            }
            
        }, completion: { finished in
                
            if transitionContext.transitionWasCancelled() {
                transitionContext.completeTransition(false)
//                UIApplication.sharedApplication().keyWindow?.addSubview(screens.from.view)
            } else {
                transitionContext.completeTransition(true)
//                UIApplication.sharedApplication().keyWindow?.addSubview(screens.to.view)
            }
        })
        
    }
    

}

extension MenuTransitionManager: UIViewControllerTransitioningDelegate {
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = true
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        presenting = false
        return self
    }
    
    func interactionControllerForPresentation(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactive ? self : nil
    }
    
    func interactionControllerForDismissal(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactive ? self : nil
    }
}



// CIRCULAR OPEN TRANSITION
//        sourceView.alpha = 1
//        destinationView.alpha = 1
//
//
//        // Create Paths
//        let radius: CGFloat = 500
//        let rect = CGRect(center: sourceView.frame.center, size: CGSize(width: 0, height: 0))
//        let startPath = UIBezierPath(ovalInRect: rect)
//        startPath.appendPath(UIBezierPath(rect: sourceView.bounds))
//        let finalPath = UIBezierPath(ovalInRect: CGRectInset(rect, -radius, -radius))
//        finalPath.appendPath(UIBezierPath(rect: sourceView.bounds))
//
//
//
//        if self.presenting {
//            println("presenting")
//
//            // Create Mask
//            let maskLayer = CAShapeLayer()
//            maskLayer.path = finalPath.CGPath
//            maskLayer.fillRule = kCAFillRuleEvenOdd
//            sourceView.layer.mask = maskLayer
//
//            // Perform Animation
//            let maskLayerAnimation = CABasicAnimation(keyPath: "path")
//            maskLayerAnimation.fromValue = startPath.CGPath
//            maskLayerAnimation.toValue = finalPath.CGPath
//            maskLayerAnimation.duration = self.transitionDuration(transitionContext)
//            maskLayerAnimation.delegate = self
//            maskLayer.addAnimation(maskLayerAnimation, forKey: "path")
//
//
//        } else {
//            println("dismissing")
//
//            // Create Mask
//            let maskLayer = CAShapeLayer()
//            maskLayer.path = startPath.CGPath
//            maskLayer.fillRule = kCAFillRuleEvenOdd
//            sourceView.layer.mask = maskLayer
//
//            // Perform Animation
//            let maskLayerAnimation = CABasicAnimation(keyPath: "path")
//            maskLayerAnimation.fromValue = finalPath.CGPath
//            maskLayerAnimation.toValue = startPath.CGPath
//            maskLayerAnimation.duration = self.transitionDuration(transitionContext)
//            maskLayerAnimation.delegate = self
//            maskLayer.addAnimation(maskLayerAnimation, forKey: "path")
//
//        }

