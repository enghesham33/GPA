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
    
    lazy var dashboardTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = true
        tableView.register(DashboardCell.self, forCellReuseIdentifier: DashboardCell.identifier)
        return tableView
    }()
    
    public func setupViews() {
        
        let views = [topView, dashboardTableView]
        self.superview.addSubviews(views)
        
        self.topView.snp.makeConstraints { maker in
            maker.leading.equalTo(superview.snp.leading)
            maker.trailing.equalTo(superview.snp.trailing)
            maker.top.equalTo(superview)
            
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 9))
        }
        
        self.topView.setupViews(screenTitle: "")
        self.topView.backImageView.image = UIImage(named: "side_menu")
        self.topView.notificationsImageView.isHidden = false
        self.topView.logoImageView.isHidden = false
        self.topView.screenTitleLabel.isHidden = true
        self.topView.delegate = self
        if AppDelegate.instance.unreadNotificationsNumber > 0 {
            self.topView.notificationsNumberLabel.isHidden = false
            self.topView.notificationsNumberLabel.layer.masksToBounds = true
            self.topView.notificationsNumberLabel.layer.cornerRadius = UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1)
            self.topView.notificationsNumberLabel.text = "\(AppDelegate.instance.unreadNotificationsNumber)"
        }
        
        self.topView.backImageView.addTapGesture(action: nil)
        self.topView.backImageView.addTapGesture { (_) in
            self.dashboardLayoutDelegate.openSideMenu()
        }
        
        self.dashboardTableView.snp.makeConstraints { maker in
            maker.leading.trailing.bottom.equalTo(superview)
            maker.top.equalTo(self.topView.snp.bottom)
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
