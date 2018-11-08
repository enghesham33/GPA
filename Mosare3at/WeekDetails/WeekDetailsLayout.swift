//
//  WeekDetailsLayout.swift
//  Mosare3at
//
//  Created by Hesham Donia on 11/1/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation
import UIKit

public protocol WeekDetailsLayoutDelegate: BaseLayoutDelegate {
    func goToWeekVisionScreen()
    func goBack()
}


public class WeekDetailsLayout: BaseLayout {
    public var weekDetailsLayoutDelegate: WeekDetailsLayoutDelegate!
    
    var topView: TopView = TopView()
    var screenTitle: String!
    init(superview: UIView, weekDetailsLayoutDelegate: WeekDetailsLayoutDelegate, screenTitle: String) {
        super.init(superview: superview, delegate: weekDetailsLayoutDelegate)
        self.weekDetailsLayoutDelegate = weekDetailsLayoutDelegate
        self.screenTitle = screenTitle
    }
    
    lazy var mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var milestonesTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = true
        tableView.backgroundColor = UIColor.AppColors.gray
        tableView.layer.masksToBounds = true
        tableView.layer.cornerRadius = 8
        tableView.register(MilestoneCell.self, forCellReuseIdentifier: MilestoneCell.identifier)
        return tableView
    }()
    
    lazy var infoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ic_info")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor.AppColors.darkRed
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        imageView.addTapGesture(action: { (_) in
            self.weekDetailsLayoutDelegate.goToWeekVisionScreen()
        })
        return imageView
    }()
    
    lazy var weekTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = AppFont.font(type: .Bold, size: 20)
        return label
    }()
    
    public func setupViews() {
        let views = [topView, mainImageView, milestonesTableView, infoImageView, weekTitleLabel]
        self.superview.addSubviews(views)
        
        self.topView.snp.makeConstraints { maker in
            maker.leading.equalTo(superview.snp.leading)
            maker.trailing.equalTo(superview.snp.trailing)
            maker.top.equalTo(superview)
            
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 9))
        }
        
        self.topView.setupViews(screenTitle: screenTitle)
        self.topView.screenTitleLabel.isHidden = false
        self.topView.backgroundColor = .clear
        self.topView.delegate = self
        
        self.mainImageView.snp.makeConstraints { (maker) in
            maker.edges.equalTo(superview)
        }
        
        self.weekTitleLabel.snp.makeConstraints { (maker) in
            maker.leading.equalTo(superview).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2))
            maker.trailing.equalTo(superview).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2) * -1)
            maker.top.equalTo(topView.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2))
            
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 3))
        }
        
        self.milestonesTableView.snp.makeConstraints { (maker) in
            maker.leading.equalTo(superview).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2))
            maker.trailing.equalTo(superview).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2) * -1)
            maker.top.equalTo(weekTitleLabel.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 7))
            
            maker.bottom.equalTo(superview).offset(-1 * UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 4))
        }
        
        self.infoImageView.snp.makeConstraints { (maker) in
            maker.trailing.equalTo(milestonesTableView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 3) * -1)
            maker.top.equalTo(milestonesTableView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 4) * -1)
            
            maker.height.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 8))
        }
        
        self.superview.bringSubviewToFront(topView)
        
    }
}

extension WeekDetailsLayout: TopViewDelegate {
    public func goBack() {
        self.weekDetailsLayoutDelegate.goBack()
    }
    
    public func goToNotifications() {
        
    }
}
