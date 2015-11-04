//
//  ViewController.swift
//  Menu
//
//  Created by Mathew Sanders on 9/7/14.
//  Copyright (c) 2014 Mat. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    @IBOutlet var menuButtons: [UIMenuButton]!
    let transitionManager = MenuTransitionManager()
    var selectedIndex: Int?
    var frame: CGRect?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.2)
        print(selectedIndex)
        print(frame)
        self.transitioningDelegate = self.transitionManager

    }
    
    
    @IBAction func unwindToMainViewController (sender: UIButton){
        dismissViewControllerAnimated(true, completion: nil)
    }
}

