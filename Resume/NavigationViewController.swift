//
//  NavigationViewController.swift
//  Resume
//
//  Created by Ian MacCallum on 9/7/15.
//  Copyright (c) 2015 Ian MacCallum. All rights reserved.
//

import Foundation
import UIKit

protocol NavigationDelegate {
    func navigationViewController(controller: NavigationViewController, didDismissWithIndex index: Int)
}

class NavigationViewController: UIViewController {
    
    let transitionManager = NavigationTransitionManager()

    var delegate: NavigationDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        transitioningDelegate = transitionManager
    }
}