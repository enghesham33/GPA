//
//  RegisteredProgramsLayout.swift
//  Mosare3at
//
//  Created by Hesham Donia on 11/20/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation
import UIKit

public protocol RegisteredProgramsLayoutDelegate : class {
    func goBack()
}

class RegisteredProgramsLayout: BaseLayout {
    
    var delegate: RegisteredProgramsLayoutDelegate!
    
    var topView: TopView = TopView()
    var screenTitle = "registeredProjects".localized()
    
    init(superview: UIView, delegate: RegisteredProgramsLayoutDelegate) {
        super.init(superview: superview)
        self.delegate = delegate
    }
    
    lazy var programsTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = true
        tableView.register(RegisteredProgramCell.self, forCellReuseIdentifier: RegisteredProgramCell.identifier)
        return tableView
    }()
    
    public func setupViews() {
        let views = [topView, programsTableView]
        
        superview.addSubviews(views)
        
        self.topView.snp.makeConstraints { maker in
            maker.leading.equalTo(superview.snp.leading)
            maker.trailing.equalTo(superview.snp.trailing)
            maker.top.equalTo(superview)
            
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 9))
        }
        
        setupTopView(screenTitle: screenTitle)
        
        self.programsTableView.snp.makeConstraints { (maker) in
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

extension RegisteredProgramsLayout: TopViewDelegate {
    func goBack() {
        self.delegate.goBack()
    }
    
    func goToNotifications() {
        
    }
}
