//
//  BaseScrollableLayout.swift
//  Mosare3at
//
//  Created by Hesham Donia on 9/30/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation
import SnapKit
import UIKit

public class BaseScrollableLayout {
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        return scrollView
    }()
    
    var contentView = UIView()
    var superview = UIView()
    
    /**
     Initializer that initialize the superView of the scrollable screen and set its background.
     - Parameter superview: The main container of the screen
     */
    public init(superview: UIView) {
        self.superview = superview
        self.superview.backgroundColor = .white
    }
    
    /**
     Setup the constrains of the superView and scrollView .
     */
    func setupViews() {
        
        self.superview.addSubview(self.scrollView)
        
        self.scrollView.snp.makeConstraints { maker in
            maker.edges.equalTo(self.superview)
        }
        
        self.scrollView.addSubview(contentView)
        
        contentView.snp.makeConstraints { maker in
            maker.edges.equalTo(self.superview)
            maker.width.equalTo(self.superview)
            maker.height.greaterThanOrEqualTo(2000)
        }
    }
    
}

