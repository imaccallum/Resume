//
//  UICenteredTextView.swift
//  Resume
//
//  Created by Ian MacCallum on 8/8/15.
//  Copyright © 2015 Ian MacCallum. All rights reserved.
//

import Foundation
import UIKit

class UICenteredTextView: UITextView {
    override var contentSize: CGSize {
        didSet {
            let top = (frame.height - contentSize.height) / 2
            contentInset.top = top < 0 ? 0 : top
        }
    }
}