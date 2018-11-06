//
//  MilestonesLayout.swift
//  Mosare3at
//
//  Created by Hesham Donia on 11/4/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation
import Material
import Localize_Swift

public protocol MilestonesLayoutDelegate: BaseLayoutDelegate {
    func goBack()
    func goNextPageMilestone()
    func goPreviousMilestone()
}

public class MilestonesLayout: BaseLayout {
    public var milestonesLayoutDelegate: MilestonesLayoutDelegate!
    
    var topView: TopView = TopView()
    var screenTitle: String!
    
    init(superview: UIView, milestonesLayoutDelegate: MilestonesLayoutDelegate, screenTitle: String) {
        super.init(superview: superview)
        self.milestonesLayoutDelegate = milestonesLayoutDelegate
        self.screenTitle = screenTitle
    }
    
    lazy var milestonesTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = true
        tableView.register(MilestonesCell.self, forCellReuseIdentifier: MilestonesCell.identifier)
        return tableView
    }()
    
    lazy var previousView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.addShadow(offset: CGSize(width: -1, height: 1), radius: 1.0, color: .black, opacity: 0.5)
        view.addTapGesture(action: { (_) in
            self.milestonesLayoutDelegate.goPreviousMilestone()
        })
        return view
    }()
    
    lazy var previousWeightLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.addBorder(width: 2, color: UIColor.AppColors.darkRed)
        label.font = AppFont.font(type: .Bold, size: 16)
        return label
    }()
    
    lazy var previousLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        if Localize.currentLanguage() == "en" {
            label.textAlignment = .left
        } else {
            label.textAlignment = .right
        }
        label.text = "previousMilestone".localized()
        label.font = AppFont.font(type: .Bold, size: 12)
        return label
    }()
    
    lazy var previousArrowsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "right_arrows")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor.AppColors.darkRed
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    lazy var verticalView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.AppColors.lightGray
        return view
    }()
    
    lazy var nextView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.addShadow(offset: CGSize(width: -1, height: 1), radius: 1.0, color: .black, opacity: 0.5)
        view.addTapGesture(action: { (_) in
            self.milestonesLayoutDelegate.goNextPageMilestone()
        })
        return view
    }()
    
    lazy var nextWeightLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.layer.masksToBounds = true
        label.textAlignment = .center
        label.addBorder(width: 2, color: UIColor.AppColors.darkRed)
        label.font = AppFont.font(type: .Bold, size: 16)
        return label
    }()
    
    lazy var nextLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        if Localize.currentLanguage() == "en" {
            label.textAlignment = .right
        } else {
            label.textAlignment = .left
        }
        label.text = "nextMilestone".localized()
        label.font = AppFont.font(type: .Bold, size: 12)
        return label
    }()
    
    lazy var nextArrowsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "left_arrows")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor.AppColors.darkRed
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    func setupViews() {
        
        let views = [topView, milestonesTableView, previousView, previousLabel, previousWeightLabel, previousArrowsImageView, nextView, nextLabel, nextWeightLabel, nextArrowsImageView, verticalView]
        
        self.superview.addSubviews(views)
        
        self.topView.snp.makeConstraints { maker in
            maker.leading.equalTo(superview.snp.leading)
            maker.trailing.equalTo(superview.snp.trailing)
            maker.top.equalTo(superview)
            
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 9))
        }
        
        setupTopView(screenTitle: screenTitle)
        
        self.previousView.snp.makeConstraints { (maker) in
            maker.leading.bottom.equalTo(superview)
            maker.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 50) - 1)
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 8))
        }
        
        self.previousView.addSubviews([previousLabel, previousWeightLabel, previousArrowsImageView])
        
        self.previousArrowsImageView.snp.makeConstraints { (maker) in
            maker.bottom.equalTo(previousView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 3) * -1)
            maker.leading.equalTo(previousView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2))
            maker.top.equalTo(previousView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 3))
            maker.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 5))
        }

        self.previousWeightLabel.snp.makeConstraints { (maker) in
            maker.trailing.equalTo(previousView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2) * -1)
            maker.centerY.equalTo(previousView)
            maker.width.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 6))
        }
        
         self.previousWeightLabel.layer.cornerRadius = UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 3)
        
        self.previousLabel.snp.makeConstraints { (maker) in
            maker.bottom.equalTo(previousView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 2) * -1)
            maker.leading.equalTo(previousArrowsImageView.snp.trailing).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1))
            maker.top.equalTo(previousView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 2))
            maker.trailing.equalTo(previousWeightLabel.snp.leading).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1) * -1)
        }
        
        self.verticalView.snp.makeConstraints { (maker) in
            maker.bottom.top.equalTo(previousView)
            maker.leading.equalTo(previousView.snp.trailing)
            maker.width.equalTo(1)
        }
        
        self.nextView.snp.makeConstraints { (maker) in
            maker.trailing.bottom.equalTo(superview)
            maker.leading.equalTo(verticalView.snp.trailing)
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 8))
        }
        
        self.nextView.addSubviews([nextLabel, nextWeightLabel, nextArrowsImageView])
        
        self.nextArrowsImageView.snp.makeConstraints { (maker) in
            maker.bottom.equalTo(nextView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 3) * -1)
            maker.trailing.equalTo(nextView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2) * -1)
            maker.top.equalTo(nextView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 3))
            maker.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 5))
        }
        
        self.nextWeightLabel.snp.makeConstraints { (maker) in
            maker.leading.equalTo(nextView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2))
            maker.centerY.equalTo(nextView)
            maker.width.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 6))
        }
        
        self.nextWeightLabel.layer.cornerRadius = UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 3)
        
        self.nextLabel.snp.makeConstraints { (maker) in
            maker.bottom.equalTo(nextView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 2) * -1)
            maker.leading.equalTo(nextWeightLabel.snp.trailing).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1))
            maker.top.equalTo(nextView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 2))
            maker.trailing.equalTo(nextArrowsImageView.snp.leading).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1) * -1)
        }
        
        self.milestonesTableView.snp.makeConstraints { (maker) in
            maker.top.equalTo(topView.snp.bottom)
            maker.leading.trailing.equalTo(superview)
            maker.bottom.equalTo(nextView.snp.bottom)
        }
    }
    
    public func setupTopView(screenTitle: String) {
        self.topView.setupViews(screenTitle: screenTitle)
        self.topView.screenTitleLabel.isHidden = false
        self.topView.backImageView.image = UIImage(named: "close")
        self.topView.delegate = self
    }
}

extension MilestonesLayout : TopViewDelegate {
    public func goBack() {
        self.milestonesLayoutDelegate.goBack()
    }
    
    public func goToNotifications() {
        
    }
}
