//
//  ForgetPasswordDoneLayout.swift
//  Mosare3at
//
//  Created by Hesham Donia on 10/3/18.
//  Copyright © 2018 Hesham Donia. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import Material

public class ForgetPasswordDoneLayout: BaseLayout {
    var forgetPasswordDelegate: ForgetPasswordDelegate!
    
    var topView: TopView = TopView()
    var isHidden: Bool = true
    
    init(superview: UIView, forgetPasswordDelegate: ForgetPasswordDelegate) {
        super.init(superview: superview, delegate: forgetPasswordDelegate)
        self.forgetPasswordDelegate = forgetPasswordDelegate
    }
    
    lazy var doneImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var linkSentLabel: UILabel = {
        let label = UILabel()
        label.text = "emailSent".localized()
        label.textColor = .black
        label.textAlignment = .center
        label.font = AppFont.font(type: .Bold, size: 16)
        return label
    }()
    
    lazy var checkEmailLabel: UILabel = {
        let label = UILabel()
        label.text = "checkEmail".localized()
        label.textColor = .black
        label.textAlignment = .center
        label.font = AppFont.font(type: .Regular, size: 13)
        return label
    }()
    
    lazy var resendPasswordButton: RaisedButton = {
        let button = RaisedButton(title: "resendPassword".localized(), titleColor: .white)
        button.backgroundColor = UIColor.AppColors.green
        button.titleLabel?.font = AppFont.font(type: .Bold, size: 18)
        
        button.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center
        button.addShadow(offset: CGSize.zero, radius: 2.0, color: .black, opacity: 0.5)
        button.addTapGesture { recognizer in
            self.forgetPasswordDelegate.resendLinkToCurrentEmail()
        }
        return button
    }()
    
    lazy var changePasswordLabel: UILabel = {
        let label = UILabel()
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let underlineAttributedString = NSAttributedString(string: "changePassword".localized(), attributes: underlineAttribute)
        label.attributedText = underlineAttributedString
        label.textColor = .black
        label.textAlignment = .center
        label.font = AppFont.font(type: .Bold, size: 13)
        label.addTapGesture(action: { (recognizer) in
            self.forgetPasswordDelegate.changePassword()
        })
        return label
    }()
    
    public func setupViews() {
        let views = [doneImageView, linkSentLabel, checkEmailLabel, changePasswordLabel, resendPasswordButton, topView]
        self.superview.addSubviews(views)
        
        self.topView.snp.makeConstraints { maker in
            maker.leading.equalTo(superview.snp.leading)
            maker.trailing.equalTo(superview.snp.trailing)
            maker.top.equalTo(superview)
            
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 9))
        }
        
        self.topView.setupViews(screenTitle: "forgetPassword".localized())
        self.topView.delegate = self
        
        self.doneImageView.snp.makeConstraints { maker in
            maker.leading.equalTo(superview.snp.leading).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 25))
            maker.trailing.equalTo(superview.snp.trailing).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 25) * -1)
            
            maker.top.equalTo(superview).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 25))
            
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 30))
        }
        
        self.linkSentLabel.snp.makeConstraints { maker in
            maker.leading.equalTo(superview.snp.leading).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1))
            maker.trailing.equalTo(superview.snp.trailing).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1) * -1)
            
            maker.top.equalTo(doneImageView.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 2))
            
            maker.height.equalTo("emailSent".localized().heightOfString(usingFont: linkSentLabel.font))
        }
        
        self.checkEmailLabel.snp.makeConstraints { maker in
            maker.leading.equalTo(superview.snp.leading).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1))
            maker.trailing.equalTo(superview.snp.trailing).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 1) * -1)
            
            maker.top.equalTo(linkSentLabel.snp.bottom)
            
            maker.height.equalTo("checkEmail".localized().heightOfString(usingFont: checkEmailLabel.font))
        }
        
        self.resendPasswordButton.snp.makeConstraints { maker in
            maker.leading.equalTo(superview.snp.leading).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 5))
            maker.trailing.equalTo(superview.snp.trailing).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_WIDTH, relativeView: nil, percentage: 5) * -1)
            
            maker.top.equalTo(checkEmailLabel.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 3))
            
            maker.height.equalTo(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 6))
        }
        
        self.changePasswordLabel.snp.makeConstraints { maker in
            
            maker.centerX.equalTo(self.superview.snp.centerX)
            maker.top.equalTo(resendPasswordButton.snp.bottom).offset(UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, relativeView: nil, percentage: 3))
            
            maker.height.equalTo("changePassword".localized().heightOfString(usingFont: checkEmailLabel.font))
        }
    }
    
    public func hideAllViews() {
        doneImageView.isHidden = true
        linkSentLabel.isHidden = true
        checkEmailLabel.isHidden = true
        changePasswordLabel.isHidden = true
        resendPasswordButton.isHidden = true
        isHidden = true
    }
    
    public func showAllViews() {
        doneImageView.isHidden = false
        linkSentLabel.isHidden = false
        checkEmailLabel.isHidden = false
        changePasswordLabel.isHidden = false
        resendPasswordButton.isHidden = false
        isHidden = false
        
    }
    
}

extension ForgetPasswordDoneLayout: TopViewDelegate {
    public func goBack() {
        self.forgetPasswordDelegate.goBack()
    }
    
    public func goToNotifications() {
        // go to notifications screen
    }
}
