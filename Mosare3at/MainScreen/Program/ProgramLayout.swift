//
//  ProgramLayout.swift
//  Mosare3at
//
//  Created by Hesham Donia on 10/14/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation
import UIKit
import SideMenu
import Localize_Swift

public protocol ProgramLayoutDelegate: BaseLayoutDelegate {
    func openSideMenu()
}

public class ProgramLayout : BaseLayout {
    
    public var programLayoutDelegate: ProgramLayoutDelegate!
    
    var topView: TopView = TopView()
    
    init(superview: UIView, programLayoutDelegate: ProgramLayoutDelegate) {
        super.init(superview: superview, delegate: programLayoutDelegate)
        self.programLayoutDelegate = programLayoutDelegate
    }
    
    public func setupViews() {
        
        let views = [topView]
        self.superview.addSubviews(views)
        
        self.topView.snp.makeConstraints { maker in
            maker.leading.equalTo(superview.snp.leading)
            maker.trailing.equalTo(superview.snp.trailing)
            maker.top.equalTo(superview)
            
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 9))
        }
        
        self.topView.setupViews(screenTitle: "")
        self.topView.backImageView.image = UIImage(named: "side_menu")
        self.topView.logoImageView.isHidden = false
        self.topView.screenTitleLabel.isHidden = true
        self.topView.delegate = self
        self.topView.backImageView.addTapGesture(action: nil)
        self.topView.backImageView.addTapGesture { (_) in
            self.programLayoutDelegate.openSideMenu()
        }
    }
}

extension ProgramLayout : TopViewDelegate {
    public func goBack() {
        // open side menu here
        
    }
}


extension ProgramLayout: UISideMenuNavigationControllerDelegate {
    
}
