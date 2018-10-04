//
//  BaseLayout.swift
//  Mosare3at
//
//  Created by Hesham Donia on 9/30/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation
import UIKit
import Localize_Swift
import SnapKit

public protocol BaseLayoutDelegate {
    func retry()
}

public class BaseLayout {
    
    var superview: UIView!
    
    /**
     Initializer that initialize the superView of the layout and set its background.
     - Parameter superview: The main container of the screen
     */
    init(superview: UIView, delegate: BaseLayoutDelegate) {
        self.superview = superview
        superview.backgroundColor = .white
    }
}
