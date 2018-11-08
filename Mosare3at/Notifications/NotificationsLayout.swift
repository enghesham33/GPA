//
//  NotificationsLayout.swift
//  Mosare3at
//
//  Created by Hesham Donia on 11/8/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation
import UIKit

public protocol NotificationsLayoutDelegate: BaseLayoutDelegate {
    func goBack()
}

public class NotificationsLayout: BaseLayout {
    
    var notificationsLayoutDelegate: NotificationsLayoutDelegate!
    var topView: TopView = TopView()
    var screenTitle: String!
    
    init(superview: UIView, notificationsLayoutDelegate: NotificationsLayoutDelegate, screenTitle: String) {
        super.init(superview: superview)
        self.notificationsLayoutDelegate = notificationsLayoutDelegate
        self.screenTitle = screenTitle
    }
    
    lazy var notificationsTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .singleLine
        tableView.isScrollEnabled = true
        tableView.register(NotificationCell.self, forCellReuseIdentifier: NotificationCell.identifier)
        return tableView
    }()
    
    public func setupViews() {
        let views = [topView, notificationsTableView]
        
        self.superview.addSubviews(views)
        
        self.topView.snp.makeConstraints { maker in
            maker.leading.equalTo(superview.snp.leading)
            maker.trailing.equalTo(superview.snp.trailing)
            maker.top.equalTo(superview)
            
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 9))
        }
        
        setupTopView(screenTitle: screenTitle)
        
        self.notificationsTableView.snp.makeConstraints { (maker) in
            maker.top.equalTo(topView.snp.bottom)
            maker.leading.trailing.bottom.equalTo(superview)
        }
    }
    
    public func setupTopView(screenTitle: String) {
        self.topView.setupViews(screenTitle: screenTitle)
        self.topView.screenTitleLabel.isHidden = false
        self.topView.backImageView.image = UIImage(named: "close")
        self.topView.delegate = self
    }
}

extension NotificationsLayout: TopViewDelegate {
    public func goBack() {
        self.notificationsLayoutDelegate.goBack()
    }
    
    public func goToNotifications() {
        
    }
}
