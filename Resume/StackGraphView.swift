//
//  StackGraphView.swift
//  Resume
//
//  Created by Ian MacCallum on 8/11/15.
//  Copyright © 2015 Ian MacCallum. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class StackGraphView: UIView {
    let fetchedResultsController: NSFetchedResultsController
    let maxDays = 30
    var maxHeight: CGFloat  {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let fetchRequest = NSFetchRequest(entityName: StackReputation.entityName)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "change", ascending: false)]
        fetchRequest.fetchLimit = 1
        
        let objs = try? appDelegate.managedObjectContext.executeFetchRequest(fetchRequest) as? [StackReputation]
        
        if let maxChange = objs??.first {
            return CGFloat(maxChange.change ?? 200)
        } else {
            return 200
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let fetchRequest = NSFetchRequest(entityName: StackReputation.entityName)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: appDelegate.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        super.init(coder: aDecoder)
        
        _ = try? fetchedResultsController.performFetch()
        
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        drawGraph(maxHeight)
    }

    func drawGraph(maxHeight: CGFloat) {
        layer.sublayers = []
        
        let fetchedReputationObject = (fetchedResultsController.fetchedObjects as? [StackReputation]) ?? []
        
        for repObj in fetchedReputationObject {
            let height = frame.height * CGFloat(repObj.change ?? 0) / maxHeight
            let width = frame.width / CGFloat(maxDays)
            let offset = CGFloat(repObj.dayOf30) * width

            drawBar(withFrame: CGRect(x: offset, y: frame.height - height, width: width, height: height))
        }
    }
    
    func drawBar(withFrame frame: CGRect) {
        print("height \(frame.height) y \(frame.origin.y)")
        let layer = CAShapeLayer()
        let path = UIBezierPath(rect: frame)
        layer.path = path.CGPath
        layer.fillColor = UIColor.greenColor().CGColor
        self.layer.addSublayer(layer)
    }
}