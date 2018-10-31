//
//  ProjectPageLayout.swift
//  Mosare3at
//
//  Created by Hesham Donia on 10/22/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation
import UIKit
import Localize_Swift

public protocol ProjectPageLayoutDelegate: BaseLayoutDelegate {
    
}

public class ProjectPageLayout: BaseLayout {
    var projectPageLayoutDelegate: ProjectPageLayoutDelegate!
    
    init(superview: UIView, projectPageLayoutDelegate: ProjectPageLayoutDelegate) {
        super.init(superview: superview, delegate: projectPageLayoutDelegate)
        self.projectPageLayoutDelegate = projectPageLayoutDelegate
    }
    
    lazy var mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = AppFont.font(type: .Regular, size: 16)
        return label
    }()
    
    lazy var summaryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = AppFont.font(type: .Bold, size: 24)
        return label
    }()
    
    lazy var weeksTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.register(WeekCell.self, forCellReuseIdentifier: WeekCell.identifier)
        return tableView
    }()
    
    public func setupViews() {
        self.superview.addSubviews([mainImageView, titleLabel, summaryLabel, weeksTableView])
        
        mainImageView.snp.makeConstraints { (maker) in
            maker.leading.top.trailing.equalTo(superview)
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 20))
        }
        
        titleLabel.snp.makeConstraints { (maker) in
            maker.leading.trailing.equalTo(superview)
            maker.top.equalTo(superview).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 5))
            
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 3))
        }
        
        summaryLabel.snp.makeConstraints { (maker) in
            maker.leading.trailing.equalTo(superview)
            maker.top.equalTo(titleLabel.snp.bottom)
            
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 5))
        }
        
        weeksTableView.snp.makeConstraints { (maker) in
            maker.leading.trailing.equalTo(mainImageView)
            maker.top.equalTo(mainImageView.snp.bottom)
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 60))
        }
    }
}
