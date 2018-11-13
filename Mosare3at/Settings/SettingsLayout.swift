//
//  SettingsLayout.swift
//  Mosare3at
//
//  Created by Hesham Donia on 11/13/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation
import UIKit
import Localize_Swift

public protocol SettingsLayoutDelegate: class {
    func goBack()
    func goToNotificationsSettings()
    func changeFontSize()
}

public class SettingsLayout: BaseLayout {
    
    var delegate: SettingsLayoutDelegate!
    var topView: TopView = TopView()
    var screenTitle = "settings".localized()
    
    init(superview: UIView, delegate: SettingsLayoutDelegate) {
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
    
    lazy var fontSizeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        
        if Localize.currentLanguage() == "en" {
            label.textAlignment = .left
        } else {
            label.textAlignment = .right
        }
        label.text = "fontSize".localized()
        label.font = AppFont.font(type: .Bold, size: 16)
        label.addTapGesture(action: { (_) in
            self.delegate.changeFontSize()
        })
        return label
    }()
    
    lazy var notificationsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        
        if Localize.currentLanguage() == "en" {
            label.textAlignment = .left
        } else {
            label.textAlignment = .right
        }
        label.text = "notificationsSettings".localized()
        label.font = AppFont.font(type: .Bold, size: 16)
        label.addTapGesture(action: { (_) in
            self.delegate.goToNotificationsSettings()
        })
        return label
    }()
    
    lazy var horizontalView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.AppColors.gray
        return view
    }()
    
    public func setupViews() {
        let views = [topView, containerView, fontSizeLabel, notificationsLabel, horizontalView]
        
        superview.addSubviews(views)
        
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
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 20))
        }
        
        containerView.addSubviews([fontSizeLabel, notificationsLabel, horizontalView])
        
        fontSizeLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(containerView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1))
            maker.leading.equalTo(containerView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2))
            maker.trailing.equalTo(containerView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2) * -1)
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 9.5))
        }
        
        horizontalView.snp.makeConstraints { (maker) in
            maker.top.equalTo(fontSizeLabel.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 0.5))
            maker.leading.trailing.equalTo(containerView)
            maker.height.equalTo(1)
        }
        
        notificationsLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(horizontalView.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 0.5))
            maker.leading.equalTo(containerView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2))
            maker.trailing.equalTo(containerView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 2) * -1)
            maker.bottom.equalTo(containerView).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 1) * -1)
        }
    }
    public func setupTopView(screenTitle: String) {
        self.topView.setupViews(screenTitle: screenTitle)
        self.topView.screenTitleLabel.isHidden = false
        self.topView.delegate = self
    }
}

extension SettingsLayout: TopViewDelegate {
    public func goBack() {
        self.delegate.goBack()
    }
    
    public func goToNotifications() {
        
    }
}
