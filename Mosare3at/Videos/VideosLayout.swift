//
//  VideosLayout.swift
//  Mosare3at
//
//  Created by Hesham Donia on 11/13/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation
import UIKit

public protocol VideosLayoutDelegate : class {
    func goBack()
}

public class VideosLayout: BaseLayout {
    
    public var delegate: VideosLayoutDelegate!
    
    var topView: TopView = TopView()
    var screenTitle = "videos".localized()
    
    init(superview: UIView, delegate: VideosLayoutDelegate) {
        super.init(superview: superview)
        self.delegate = delegate
    }
    
    lazy var videosTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = true
        tableView.register(VideoCell.self, forCellReuseIdentifier: VideoCell.identifier)
        return tableView
    }()
    
    public func setupViews() {
        let views = [topView, videosTableView]
        
        superview.addSubviews(views)
        
        self.topView.snp.makeConstraints { maker in
            maker.leading.equalTo(superview.snp.leading)
            maker.trailing.equalTo(superview.snp.trailing)
            maker.top.equalTo(superview)
            
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 9))
        }
        
        setupTopView(screenTitle: screenTitle)
        
        self.videosTableView.snp.makeConstraints { (maker) in
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

extension VideosLayout: TopViewDelegate {
    public func goBack() {
        self.delegate.goBack()
    }
    
    public func goToNotifications() {
        
    }
}