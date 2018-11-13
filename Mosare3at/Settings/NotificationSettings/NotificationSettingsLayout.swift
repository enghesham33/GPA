//
//  NotificationSettingsVC.swift
//  Mosare3at
//
//  Created by Hesham Donia on 11/13/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation
import UIKit
import Localize_Swift
import Material

public protocol NotificationsSettingsLayoutDelegate: class {
    func goBack()
}

public class NotificationsSettingsLayout: BaseLayout {
    
    var delegate: NotificationsSettingsLayoutDelegate!
    var topView: TopView = TopView()
    var screenTitle = "notificationsSettings".localized()
    
    init(superview: UIView, delegate: NotificationsSettingsLayoutDelegate) {
        super.init(superview: superview)
        self.delegate = delegate
    }
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.addShadow(offset: CGSize(width: -1, height: 1), radius: 1.0, color: .black, opacity: 0.5)
        return view
    }()
    
    lazy var weekSummaryTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        
        if Localize.currentLanguage() == "en" {
            label.textAlignment = .left
        } else {
            label.textAlignment = .right
        }
        label.text = "weekSummary".localized()
        label.font = AppFont.font(type: .Bold, size: 16)
        return label
    }()
    
    lazy var weekSummarySwitch: Switch = {
        let gSwitch = Switch(state: .on, style: .light, size: .medium)
        gSwitch.buttonOffColor = UIColor.AppColors.gray
        gSwitch.trackOffColor = UIColor.AppColors.gray.withAlphaComponent(0.5)
        gSwitch.buttonOnColor = UIColor.AppColors.darkRed
        gSwitch.trackOnColor = UIColor.AppColors.darkRed.withAlphaComponent(0.5)
        return gSwitch
        
    }()
    
    lazy var weekSummaryHorizontalView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.AppColors.gray
        return view
    }()
    
    lazy var newPointsTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        
        if Localize.currentLanguage() == "en" {
            label.textAlignment = .left
        } else {
            label.textAlignment = .right
        }
        label.text = "newPoints".localized()
        label.font = AppFont.font(type: .Bold, size: 16)
        return label
    }()
    
    lazy var newPointsSwitch: Switch = {
        let gSwitch = Switch(state: .on, style: .light, size: .medium)
        gSwitch.buttonOffColor = UIColor.AppColors.gray
        gSwitch.trackOffColor = UIColor.AppColors.gray.withAlphaComponent(0.5)
        gSwitch.buttonOnColor = UIColor.AppColors.darkRed
        gSwitch.trackOnColor = UIColor.AppColors.darkRed.withAlphaComponent(0.5)
        return gSwitch
        
    }()
    
    lazy var newPointsHorizontalView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.AppColors.gray
        return view
    }()
    
    lazy var newBadgeTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        
        if Localize.currentLanguage() == "en" {
            label.textAlignment = .left
        } else {
            label.textAlignment = .right
        }
        label.text = "newBadge".localized()
        label.font = AppFont.font(type: .Bold, size: 16)
        return label
    }()
    
    lazy var newBadgeSwitch: Switch = {
        let gSwitch = Switch(state: .on, style: .light, size: .medium)
        gSwitch.buttonOffColor = UIColor.AppColors.gray
        gSwitch.trackOffColor = UIColor.AppColors.gray.withAlphaComponent(0.5)
        gSwitch.buttonOnColor = UIColor.AppColors.darkRed
        gSwitch.trackOnColor = UIColor.AppColors.darkRed.withAlphaComponent(0.5)
        return gSwitch
        
    }()
    
    lazy var newBadgeHorizontalView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.AppColors.gray
        return view
    }()
    
    lazy var projectStartTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        
        if Localize.currentLanguage() == "en" {
            label.textAlignment = .left
        } else {
            label.textAlignment = .right
        }
        label.text = "projectStart".localized()
        label.font = AppFont.font(type: .Bold, size: 16)
        return label
    }()
    
    lazy var projectStartSwitch: Switch = {
        let gSwitch = Switch(state: .on, style: .light, size: .medium)
        gSwitch.buttonOffColor = UIColor.AppColors.gray
        gSwitch.trackOffColor = UIColor.AppColors.gray.withAlphaComponent(0.5)
        gSwitch.buttonOnColor = UIColor.AppColors.darkRed
        gSwitch.trackOnColor = UIColor.AppColors.darkRed.withAlphaComponent(0.5)
        return gSwitch
        
    }()
    
    lazy var projectStartHorizontalView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.AppColors.gray
        return view
    }()
    
    lazy var deadLineTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        
        if Localize.currentLanguage() == "en" {
            label.textAlignment = .left
        } else {
            label.textAlignment = .right
        }
        label.text = "deadLines".localized()
        label.font = AppFont.font(type: .Bold, size: 16)
        return label
    }()
    
    lazy var deadLineSwitch: Switch = {
        let gSwitch = Switch(state: .on, style: .light, size: .medium)
        gSwitch.buttonOffColor = UIColor.AppColors.gray
        gSwitch.trackOffColor = UIColor.AppColors.gray.withAlphaComponent(0.5)
        gSwitch.buttonOnColor = UIColor.AppColors.darkRed
        gSwitch.trackOnColor = UIColor.AppColors.darkRed.withAlphaComponent(0.5)
        return gSwitch
        
    }()
    
    lazy var deadLineHorizontalView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.AppColors.gray
        return view
    }()

    lazy var deliverableAcceptedTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        
        if Localize.currentLanguage() == "en" {
            label.textAlignment = .left
        } else {
            label.textAlignment = .right
        }
        label.text = "deliverablesAccepted".localized()
        label.font = AppFont.font(type: .Bold, size: 16)
        return label
    }()
    
    lazy var deliverableAcceptedSwitch: Switch = {
        let gSwitch = Switch(state: .on, style: .light, size: .medium)
        gSwitch.buttonOffColor = UIColor.AppColors.gray
        gSwitch.trackOffColor = UIColor.AppColors.gray.withAlphaComponent(0.5)
        gSwitch.buttonOnColor = UIColor.AppColors.darkRed
        gSwitch.trackOnColor = UIColor.AppColors.darkRed.withAlphaComponent(0.5)
        return gSwitch
        
    }()
    
    lazy var deliverableAcceptedHorizontalView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.AppColors.gray
        return view
    }()
    
    lazy var deliverableRefusedTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        
        if Localize.currentLanguage() == "en" {
            label.textAlignment = .left
        } else {
            label.textAlignment = .right
        }
        label.text = "deliverablesRefused".localized()
        label.font = AppFont.font(type: .Bold, size: 16)
        return label
    }()
    
    lazy var deliverableRefusedSwitch: Switch = {
        let gSwitch = Switch(state: .on, style: .light, size: .medium)
        gSwitch.buttonOffColor = UIColor.AppColors.gray
        gSwitch.trackOffColor = UIColor.AppColors.gray.withAlphaComponent(0.5)
        gSwitch.buttonOnColor = UIColor.AppColors.darkRed
        gSwitch.trackOnColor = UIColor.AppColors.darkRed.withAlphaComponent(0.5)
        return gSwitch
        
    }()
    
    lazy var deliverableRefusedHorizontalView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.AppColors.gray
        return view
    }()
    
    lazy var teamDataUpdatedTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        
        if Localize.currentLanguage() == "en" {
            label.textAlignment = .left
        } else {
            label.textAlignment = .right
        }
        label.text = "teamDataUpdated".localized()
        label.font = AppFont.font(type: .Bold, size: 16)
        return label
    }()
    
    lazy var teamDataUpdatedSwitch: Switch = {
        let gSwitch = Switch(state: .on, style: .light, size: .medium)
        gSwitch.buttonOffColor = UIColor.AppColors.gray
        gSwitch.trackOffColor = UIColor.AppColors.gray.withAlphaComponent(0.5)
        gSwitch.buttonOnColor = UIColor.AppColors.darkRed
        gSwitch.trackOnColor = UIColor.AppColors.darkRed.withAlphaComponent(0.5)
        return gSwitch
        
    }()
    
    lazy var teamDataUpdatedHorizontalView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.AppColors.gray
        return view
    }()
    
    lazy var gotCertificateTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        
        if Localize.currentLanguage() == "en" {
            label.textAlignment = .left
        } else {
            label.textAlignment = .right
        }
        label.text = "gotCert".localized()
        label.font = AppFont.font(type: .Bold, size: 16)
        return label
    }()
    
    lazy var gotCertificateSwitch: Switch = {
        let gSwitch = Switch(state: .on, style: .light, size: .medium)
        gSwitch.buttonOffColor = UIColor.AppColors.gray
        gSwitch.trackOffColor = UIColor.AppColors.gray.withAlphaComponent(0.5)
        gSwitch.buttonOnColor = UIColor.AppColors.darkRed
        gSwitch.trackOnColor = UIColor.AppColors.darkRed.withAlphaComponent(0.5)
        return gSwitch
        
    }()
    
    lazy var gotCertificateHorizontalView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.AppColors.gray
        return view
    }()
    
    lazy var newVideosTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        
        if Localize.currentLanguage() == "en" {
            label.textAlignment = .left
        } else {
            label.textAlignment = .right
        }
        label.text = "newVideos".localized()
        label.font = AppFont.font(type: .Bold, size: 16)
        return label
    }()
    
    lazy var newVideosSwitch: Switch = {
        let gSwitch = Switch(state: .on, style: .light, size: .medium)
        gSwitch.buttonOffColor = UIColor.AppColors.gray
        gSwitch.trackOffColor = UIColor.AppColors.gray.withAlphaComponent(0.5)
        gSwitch.buttonOnColor = UIColor.AppColors.darkRed
        gSwitch.trackOnColor = UIColor.AppColors.darkRed.withAlphaComponent(0.5)
        return gSwitch
        
    }()
    
    public func setupViews() {
        let views = [topView, containerView, weekSummaryTitleLabel, weekSummarySwitch, weekSummaryHorizontalView, newPointsSwitch, newPointsTitleLabel, newPointsHorizontalView, newBadgeSwitch, newBadgeTitleLabel, newBadgeHorizontalView, projectStartSwitch, projectStartTitleLabel, projectStartHorizontalView, deadLineSwitch, deadLineTitleLabel, deadLineHorizontalView, deliverableAcceptedSwitch, deliverableAcceptedTitleLabel, deliverableAcceptedHorizontalView, deliverableRefusedSwitch, deliverableRefusedTitleLabel, deliverableRefusedHorizontalView, teamDataUpdatedSwitch, teamDataUpdatedTitleLabel, teamDataUpdatedHorizontalView, gotCertificateSwitch, gotCertificateTitleLabel, gotCertificateHorizontalView, newVideosSwitch, newVideosTitleLabel]
        
        self.superview.addSubviews(views)
        
        self.topView.snp.makeConstraints { maker in
            maker.leading.equalTo(superview.snp.leading)
            maker.trailing.equalTo(superview.snp.trailing)
            maker.top.equalTo(superview)
            
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 9))
        }
        
        setupTopView(screenTitle: screenTitle)
        
        containerView.snp.makeConstraints { (maker) in
            maker.top.equalTo(topView.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.leading.equalTo(superview).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2))
            maker.trailing.equalTo(superview).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2) * -1)
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 73))
        }
        
        containerView.addSubviews([weekSummaryTitleLabel, weekSummarySwitch, weekSummaryHorizontalView, newPointsSwitch, newPointsTitleLabel, newPointsHorizontalView, newBadgeSwitch, newBadgeTitleLabel, newBadgeHorizontalView, projectStartSwitch, projectStartTitleLabel, projectStartHorizontalView, deadLineSwitch, deadLineTitleLabel, deadLineHorizontalView, deliverableAcceptedSwitch, deliverableAcceptedTitleLabel, deliverableAcceptedHorizontalView, deliverableRefusedSwitch, deliverableRefusedTitleLabel, deliverableRefusedHorizontalView, teamDataUpdatedSwitch, teamDataUpdatedTitleLabel, teamDataUpdatedHorizontalView, gotCertificateSwitch, gotCertificateTitleLabel, gotCertificateHorizontalView, newVideosSwitch, newVideosTitleLabel])
        
        weekSummarySwitch.snp.makeConstraints { (maker) in
            maker.trailing.equalTo(containerView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 3) * -1)
            maker.top.equalTo(containerView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 15))
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 5))
        }
        
        weekSummaryTitleLabel.snp.makeConstraints { (maker) in
            maker.leading.equalTo(containerView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1))
            maker.top.equalTo(containerView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.trailing.equalTo(weekSummarySwitch.snp.leading).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1) * -1)
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 5))
        }
        
        weekSummaryHorizontalView.snp.makeConstraints { (maker) in
            maker.leading.equalTo(weekSummaryTitleLabel)
            maker.top.equalTo(weekSummaryTitleLabel.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.trailing.equalTo(containerView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1) * -1)
            maker.height.equalTo(1)
        }
        
       newPointsSwitch.snp.makeConstraints { (maker) in
            maker.trailing.equalTo(containerView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 3) * -1)
            maker.top.equalTo(weekSummaryHorizontalView.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 15))
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 5))
        }
        
        newPointsTitleLabel.snp.makeConstraints { (maker) in
            maker.leading.equalTo(containerView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1))
            maker.top.equalTo(weekSummaryHorizontalView.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.trailing.equalTo(newPointsSwitch.snp.leading).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1) * -1)
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 5))
        }
        
        newPointsHorizontalView.snp.makeConstraints { (maker) in
            maker.leading.equalTo(newPointsTitleLabel)
            maker.top.equalTo(newPointsTitleLabel.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.trailing.equalTo(containerView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1) * -1)
            maker.height.equalTo(1)
        }
        
        newBadgeSwitch.snp.makeConstraints { (maker) in
            maker.trailing.equalTo(containerView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 3) * -1)
            maker.top.equalTo(newPointsHorizontalView.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 15))
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 5))
        }
        
        newBadgeTitleLabel.snp.makeConstraints { (maker) in
            maker.leading.equalTo(containerView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1))
            maker.top.equalTo(newPointsHorizontalView.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.trailing.equalTo(newBadgeSwitch.snp.leading).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1) * -1)
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 5))
        }
        
        newBadgeHorizontalView.snp.makeConstraints { (maker) in
            maker.leading.equalTo(newBadgeTitleLabel)
            maker.top.equalTo(newBadgeTitleLabel.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.trailing.equalTo(containerView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1) * -1)
            maker.height.equalTo(1)
        }
        
        projectStartSwitch.snp.makeConstraints { (maker) in
            maker.trailing.equalTo(containerView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 3) * -1)
            maker.top.equalTo(newBadgeHorizontalView.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 15))
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 5))
        }
        
        projectStartTitleLabel.snp.makeConstraints { (maker) in
            maker.leading.equalTo(containerView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1))
            maker.top.equalTo(newBadgeHorizontalView.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.trailing.equalTo(projectStartSwitch.snp.leading).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1) * -1)
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 5))
        }
        
        projectStartHorizontalView.snp.makeConstraints { (maker) in
            maker.leading.equalTo(projectStartTitleLabel)
            maker.top.equalTo(projectStartTitleLabel.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.trailing.equalTo(containerView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1) * -1)
            maker.height.equalTo(1)
        }
        
        deadLineSwitch.snp.makeConstraints { (maker) in
            maker.trailing.equalTo(containerView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 3) * -1)
            maker.top.equalTo(projectStartHorizontalView.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 15))
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 5))
        }
        
       deadLineTitleLabel.snp.makeConstraints { (maker) in
            maker.leading.equalTo(containerView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1))
            maker.top.equalTo(projectStartHorizontalView.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.trailing.equalTo(deadLineSwitch.snp.leading).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1) * -1)
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 5))
        }
        
       deadLineHorizontalView.snp.makeConstraints { (maker) in
            maker.leading.equalTo(deadLineTitleLabel)
            maker.top.equalTo(deadLineTitleLabel.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.trailing.equalTo(containerView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1) * -1)
            maker.height.equalTo(1)
        }
        
        deliverableAcceptedSwitch.snp.makeConstraints { (maker) in
            maker.trailing.equalTo(containerView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 3) * -1)
            maker.top.equalTo(deadLineHorizontalView.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 15))
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 5))
        }
        
        deliverableAcceptedTitleLabel.snp.makeConstraints { (maker) in
            maker.leading.equalTo(containerView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1))
            maker.top.equalTo(deadLineHorizontalView.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.trailing.equalTo(deliverableAcceptedSwitch.snp.leading).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1) * -1)
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 5))
        }
        
        deliverableAcceptedHorizontalView.snp.makeConstraints { (maker) in
            maker.leading.equalTo(deliverableAcceptedTitleLabel)
            maker.top.equalTo(deliverableAcceptedTitleLabel.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.trailing.equalTo(containerView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1) * -1)
            maker.height.equalTo(1)
        }
        
        deliverableRefusedSwitch.snp.makeConstraints { (maker) in
            maker.trailing.equalTo(containerView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 3) * -1)
            maker.top.equalTo(deliverableAcceptedHorizontalView.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 15))
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 5))
        }
        
        deliverableRefusedTitleLabel.snp.makeConstraints { (maker) in
            maker.leading.equalTo(containerView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1))
            maker.top.equalTo(deliverableAcceptedHorizontalView.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.trailing.equalTo(deliverableRefusedSwitch.snp.leading).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1) * -1)
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 5))
        }
        
        deliverableRefusedHorizontalView.snp.makeConstraints { (maker) in
            maker.leading.equalTo(deliverableRefusedTitleLabel)
            maker.top.equalTo(deliverableRefusedTitleLabel.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.trailing.equalTo(containerView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1) * -1)
            maker.height.equalTo(1)
        }
        
        teamDataUpdatedSwitch.snp.makeConstraints { (maker) in
            maker.trailing.equalTo(containerView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 3) * -1)
            maker.top.equalTo(deliverableRefusedHorizontalView.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 15))
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 5))
        }
        
        teamDataUpdatedTitleLabel.snp.makeConstraints { (maker) in
            maker.leading.equalTo(containerView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1))
            maker.top.equalTo(deliverableRefusedHorizontalView.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.trailing.equalTo(teamDataUpdatedSwitch.snp.leading).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1) * -1)
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 5))
        }
        
        teamDataUpdatedHorizontalView.snp.makeConstraints { (maker) in
            maker.leading.equalTo(teamDataUpdatedTitleLabel)
            maker.top.equalTo(teamDataUpdatedTitleLabel.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.trailing.equalTo(containerView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1) * -1)
            maker.height.equalTo(1)
        }
        
        gotCertificateSwitch.snp.makeConstraints { (maker) in
            maker.trailing.equalTo(containerView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 3) * -1)
            maker.top.equalTo(teamDataUpdatedHorizontalView.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 15))
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 5))
        }
        
        gotCertificateTitleLabel.snp.makeConstraints { (maker) in
            maker.leading.equalTo(containerView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1))
            maker.top.equalTo(teamDataUpdatedHorizontalView.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.trailing.equalTo(gotCertificateSwitch.snp.leading).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1) * -1)
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 5))
        }
        
        gotCertificateHorizontalView.snp.makeConstraints { (maker) in
            maker.leading.equalTo(gotCertificateTitleLabel)
            maker.top.equalTo(gotCertificateTitleLabel.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.trailing.equalTo(containerView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1) * -1)
            maker.height.equalTo(1)
        }
        
        newVideosSwitch.snp.makeConstraints { (maker) in
            maker.trailing.equalTo(containerView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 3) * -1)
            maker.top.equalTo(gotCertificateHorizontalView.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.width.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 15))
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 5))
        }
        
        newVideosTitleLabel.snp.makeConstraints { (maker) in
            maker.leading.equalTo(containerView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1))
            maker.top.equalTo(gotCertificateHorizontalView.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.trailing.equalTo(newVideosSwitch.snp.leading).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1) * -1)
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 5))
        }
        
    }
    public func setupTopView(screenTitle: String) {
        self.topView.setupViews(screenTitle: screenTitle)
        self.topView.screenTitleLabel.isHidden = false
        self.topView.delegate = self
    }
}

extension NotificationsSettingsLayout: TopViewDelegate {
    public func goBack() {
        self.delegate.goBack()
    }
    
    public func goToNotifications() {
        
    }
}

