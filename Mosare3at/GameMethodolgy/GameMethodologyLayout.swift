//
//  GameMethodologyLayout.swift
//  Mosare3at
//
//  Created by Hesham Donia on 11/13/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation
import UIKit

public protocol GameMethodologyLayoutDelegate : class {
    func goBack()
}

public class GameMethodologyLayout: BaseLayout {
    
    public var delegate: GameMethodologyLayoutDelegate!
    
    var topView: TopView = TopView()
    var screenTitle = "gameWay".localized()
    
     init(superview: UIView, delegate: GameMethodologyLayoutDelegate) {
        super.init(superview: superview)
        self.delegate = delegate
    }
    
    lazy var itemsTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = true
        tableView.register(GameMethodologyCell.self, forCellReuseIdentifier: GameMethodologyCell.identifier)
        return tableView
    }()
    
    public func setupViews() {
        let views = [topView, itemsTableView]
        
        superview.addSubviews(views)
        
        self.topView.snp.makeConstraints { maker in
            maker.leading.equalTo(superview.snp.leading)
            maker.trailing.equalTo(superview.snp.trailing)
            maker.top.equalTo(superview)
            
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 9))
        }
        
        setupTopView(screenTitle: screenTitle)
        
        self.itemsTableView.snp.makeConstraints { (maker) in
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

extension GameMethodologyLayout: TopViewDelegate {
    public func goBack() {
        self.delegate.goBack()
    }
    
    public func goToNotifications() {
        
    }
}