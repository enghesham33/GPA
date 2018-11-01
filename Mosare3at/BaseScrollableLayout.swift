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
        scrollView.isScrollEnabled = true
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
        
//        self.scrollView.snp.makeConstraints { maker in
//            maker.leading.equalTo(self.superview.snp.leading)
//            maker.trailing.equalTo(self.superview.snp.trailing)
//            maker.top.equalTo(self.superview.snp.bottom)
//            maker.bottom.equalTo(self.superview.snp.bottom)
//        }
//
//        self.scrollView.contentSize = CGSize(width: self.superview.frame.width, height: UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 210))
//
//        self.scrollView.addSubview(contentView)
//
//        contentView.snp.makeConstraints { maker in
//            maker.edges.equalTo(self.scrollView)
//            maker.width.equalTo(self.scrollView)
//            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 210))
//        }
        
        self.scrollView.snp.makeConstraints { maker in
            maker.edges.equalTo(self.superview)
        }

        self.scrollView.addSubview(contentView)

        self.scrollView.contentSize = CGSize(width: UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 100), height: UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 210))

        contentView.snp.makeConstraints { maker in
            maker.leading.equalTo(self.scrollView.snp.leading)
            maker.trailing.equalTo(self.scrollView.snp.trailing)
            maker.top.equalTo(self.scrollView.snp.bottom)
            maker.width.equalTo(self.scrollView)
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 210))
        }
    }
    
}

