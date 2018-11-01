//
//  WeekVisionLayout.swift
//  Mosare3at
//
//  Created by Hesham Donia on 11/1/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation
import UIKit
import Material

public protocol WeekVisionLayoutDelegate: BaseLayoutDelegate {
    func goBack()
}

public class WeekVisionLayout : BaseScrollableLayout {
    public var weekVisionLayoutDelegate: WeekVisionLayoutDelegate!
    
    var topView: TopView = TopView()
    var screenTitle: String!
    
    init(superview: UIView, weekVisionLayoutDelegate: WeekVisionLayoutDelegate, screenTitle: String) {
        super.init(superview: superview)
        self.weekVisionLayoutDelegate = weekVisionLayoutDelegate
        self.screenTitle = screenTitle
    }
    
    lazy var weekVisionTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = true
        tableView.register(WeekVisionCell.self, forCellReuseIdentifier: WeekVisionCell.identifier)
        return tableView
    }()
    
    override func setupViews() {
        super.setupViews()
        
        let views = [topView, weekVisionTableView]
        
        self.contentView.addSubviews(views)
        
        self.topView.snp.makeConstraints { maker in
            maker.leading.equalTo(superview.snp.leading)
            maker.trailing.equalTo(superview.snp.trailing)
            maker.top.equalTo(superview)
            
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 9))
        }
        
        self.topView.setupViews(screenTitle: screenTitle)
        self.topView.screenTitleLabel.isHidden = false
        self.topView.backImageView.image = UIImage(named: "close")
        self.topView.delegate = self
        
        self.weekVisionTableView.snp.makeConstraints { (maker) in
            maker.top.equalTo(topView.snp.bottom)
            maker.leading.trailing.bottom.equalTo(superview)
        }
    }
}

extension WeekVisionLayout : TopViewDelegate {
    public func goBack() {
        self.weekVisionLayoutDelegate.goBack()
    }
    
    public func goToNotifications() {
        
    }
}
