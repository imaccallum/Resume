//
//  HomeViewController.swift
//  Resume
//
//  Created by Ian MacCallum on 4/24/15.
//  Copyright (c) 2015 Ian MacCallum. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    let transitionManager = MenuTransitionManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.transitionManager.sourceViewController = self
        self.transitionManager.destinationViewController = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("AboutViewControllerID") as! AboutViewController
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}

