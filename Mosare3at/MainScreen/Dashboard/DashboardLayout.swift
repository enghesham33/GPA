//
//  ProgramLayout.swift
//  Mosare3at
//
//  Created by Hesham Donia on 10/14/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation
import UIKit

public protocol DashboardLayoutDelegate: BaseLayoutDelegate {
    func openSideMenu()
    func goToNotificationsScreen()
}

public class DashboardLayout : BaseLayout {
    
    public var dashboardLayoutDelegate: DashboardLayoutDelegate!
    
    var topView: TopView = TopView()
    
    init(superview: UIView, dashboardLayoutDelegate: DashboardLayoutDelegate) {
        super.init(superview: superview, delegate: dashboardLayoutDelegate)
        self.dashboardLayoutDelegate = dashboardLayoutDelegate
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
            self.dashboardLayoutDelegate.openSideMenu()
        }
    }
}

extension DashboardLayout : TopViewDelegate {
    public func goBack() {
        // open side menu here
    }
    
    public func goToNotifications() {
        self.dashboardLayoutDelegate.goToNotificationsScreen()
        // go to notifications screen
    }
}
