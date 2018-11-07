//
//  DeliverableDetailsLayout.swift
//  Mosare3at
//
//  Created by Hesham Donia on 11/7/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation
import Material
import UIKit


public protocol DeliverableDetailsLayoutDelegate: BaseLayoutDelegate {
    func goBack()
}

public class DeliverableDetailsLayout: BaseLayout {
    
    public var deliverableDetailsLayoutDelegate: DeliverableDetailsLayoutDelegate!
    
    var topView: TopView = TopView()
    var screenTitle: String!
    
    init(superview: UIView, deliverableDetailsLayoutDelegate: DeliverableDetailsLayoutDelegate, screenTitle: String) {
        super.init(superview: superview)
        self.deliverableDetailsLayoutDelegate = deliverableDetailsLayoutDelegate
        self.screenTitle = screenTitle
    }
    
    lazy var deliverablesDetailsTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = true
        tableView.register(DeliverableDetailsCell.self, forCellReuseIdentifier: DeliverableDetailsCell.identifier)
        tableView.register(ImportantNoteCell.self, forCellReuseIdentifier: ImportantNoteCell.identifier)
        tableView.register(UploadVideoCell.self, forCellReuseIdentifier: UploadVideoCell.identifier)
        return tableView
    }()
    
    func setupViews() {
        let views = [topView, deliverablesDetailsTableView]
        
        self.superview.addSubviews(views)
        
        self.topView.snp.makeConstraints { maker in
            maker.leading.equalTo(superview.snp.leading)
            maker.trailing.equalTo(superview.snp.trailing)
            maker.top.equalTo(superview)
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 9))
        }
        
        setupTopView(screenTitle: screenTitle)
        
        self.deliverablesDetailsTableView.snp.makeConstraints { (maker) in
            maker.top.equalTo(topView.snp.bottom)
            maker.leading.trailing.bottom.equalTo(superview)
        }
    }
    
    public func setupTopView(screenTitle: String) {
        self.topView.setupViews(screenTitle: screenTitle)
        self.topView.screenTitleLabel.isHidden = false
        self.topView.delegate = self
    }
    
}

extension DeliverableDetailsLayout : TopViewDelegate {
    public func goBack() {
        self.deliverableDetailsLayoutDelegate.goBack()
    }
    
    public func goToNotifications() {
        
    }
}
